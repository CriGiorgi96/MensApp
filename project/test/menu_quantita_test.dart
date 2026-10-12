import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/database/database.dart';

/// Test del flusso "quantità disponibile" del menù giornaliero:
/// la mensa imposta le quantità, l'accettazione di un ordine le
/// diminuisce e quando arrivano a 0 il piatto esce dal menù.
void main() {
  late AppDatabase db;
  late int mensaId;
  late int utenteId;
  late int pastaId;
  late int insalataId;
  late int acquaId;

  const iva = '11111111111';

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());

    final gestoreId = await db
        .into(db.gestori)
        .insert(GestoriCompanion.insert(email: 'g@x.it', password: 'pw'));

    mensaId = await db
        .into(db.mense)
        .insert(
          MenseCompanion.insert(
            gestoreId: gestoreId,
            nomeMensa: 'Mensa Centrale',
            citta: 'Roma',
            comune: 'Roma',
            indirizzo: 'Via Roma 1',
            partitaIva: Value(iva),
          ),
        );

    utenteId = await db
        .into(db.utenti)
        .insert(
          UtentiCompanion.insert(
            nome: 'Anna',
            cognome: 'Bianchi',
            indirizzo: 'Via X 1',
            comune: 'Roma',
            provincia: 'RM',
            email: 'anna.bianchi@x.it',
            password: 'pw',
            dataNascita: DateTime(2000, 1, 1),
          ),
        );

    Future<int> inserisciPasto(String nome, String categoria) {
      return db
          .into(db.pasti)
          .insert(
            PastiCompanion.insert(
              partitaIva: Value(iva),
              nome: nome,
              categoria: categoria,
              prezzo: const Value(3.5),
            ),
          );
    }

    pastaId = await inserisciPasto('Pasta al pomodoro', 'PRIMI');
    insalataId = await inserisciPasto('Insalata mista', 'CONTORNI');
    acquaId = await inserisciPasto('Acqua naturale', 'BEVANDE');
  });

  tearDown(() async {
    await db.close();
  });

  /// Salva il menù di oggi con le quantità indicate per categoria.
  Future<void> salvaMenu({
    required Map<int, int> primi,
    required Map<int, int> contorni,
    required Map<int, int> bevande,
  }) async {
    await db.salvaMenuCategoriaOggi(
      mensaId: mensaId,
      categoria: 'PRIMI',
      pastiSelezionati: primi.keys.toList(),
      quantita: primi,
    );
    await db.salvaMenuCategoriaOggi(
      mensaId: mensaId,
      categoria: 'CONTORNI',
      pastiSelezionati: contorni.keys.toList(),
      quantita: contorni,
    );
    await db.salvaMenuCategoriaOggi(
      mensaId: mensaId,
      categoria: 'BEVANDE',
      pastiSelezionati: bevande.keys.toList(),
      quantita: bevande,
    );
  }

  /// Crea un ordine "In attesa" con i piatti indicati e ne restituisce l'id.
  Future<int> creaOrdine(List<(int pastoId, int quantita)> piatti) async {
    final ordineId = await db
        .into(db.ordini)
        .insert(
          OrdiniCompanion.insert(
            utenteId: utenteId,
            mensaId: mensaId,
            giornoRitiro: DateTime.now(),
            orarioRitiro: '12:00',
          ),
        );

    for (final (pastoId, quantita) in piatti) {
      await db
          .into(db.ordinePiatti)
          .insert(
            OrdinePiattiCompanion.insert(
              ordineId: ordineId,
              pastoId: pastoId,
              nomePasto: 'piatto',
              prezzo: const Value(3.5),
              quantita: Value(quantita),
            ),
          );
    }

    return ordineId;
  }

  test('Le quantità impostate nel menù di oggi vengono salvate e rilette', () async {
    await salvaMenu(
      primi: {pastaId: 5},
      contorni: {insalataId: 3},
      bevande: {acquaId: 12},
    );

    final quantita = await db.getQuantitaMenuDiOggi(mensaId);

    expect(quantita[pastaId], 5);
    expect(quantita[insalataId], 3);
    expect(quantita[acquaId], 12);

    // Tutti i piatti sono nel menù di oggi.
    final menu = await db.getMenuDiOggi(mensaId);
    expect(
      menu.map((pasto) => pasto.id),
      containsAll([pastaId, insalataId, acquaId]),
    );
  });

  test('Salvare un piatto selezionato senza disponibilità è un errore', () async {
    await expectLater(
      db.salvaMenuCategoriaOggi(
        mensaId: mensaId,
        categoria: 'PRIMI',
        pastiSelezionati: [pastaId],
        quantita: {},
      ),
      throwsA(isA<Exception>()),
    );

    // La transazione è fallita: nessuna riga è stata aggiunta.
    final menu = await db.getMenuDiOggi(mensaId);
    expect(menu, isEmpty);
  });

  test('Una riga legacy senza quantità non viene decrementata', () async {
    // Simula una riga di menù creata prima che la disponibilità
    // diventasse obbligatoria: colonna lasciata a null.
    final oggi = DateTime.now();
    final data = '${oggi.year.toString().padLeft(4, '0')}-'
        '${oggi.month.toString().padLeft(2, '0')}-'
        '${oggi.day.toString().padLeft(2, '0')}';
    await db
        .into(db.menuGiornalieri)
        .insert(
          MenuGiornalieriCompanion.insert(
            mensaId: mensaId,
            pastoId: acquaId,
            data: data,
          ),
        );

    final ordineId = await creaOrdine([(acquaId, 4)]);
    await db.aggiornaStatoOrdine(ordineId, 'Ricevuto');

    final quantita = await db.getQuantitaMenuDiOggi(mensaId);
    expect(quantita.containsKey(acquaId), isTrue);
    expect(quantita[acquaId], isNull);

    final menu = await db.getMenuDiOggi(mensaId);
    expect(menu.map((pasto) => pasto.id), contains(acquaId));
  });

  test("Accettando un ordine la quantità disponibile diminuisce", () async {
    await salvaMenu(primi: {pastaId: 5}, contorni: {}, bevande: {});

    final ordineId = await creaOrdine([(pastaId, 2)]);
    await db.aggiornaStatoOrdine(ordineId, 'Ricevuto');

    final quantita = await db.getQuantitaMenuDiOggi(mensaId);
    expect(quantita[pastaId], 3);

    // Il piatto resta nel menù finché ha disponibilità.
    final menu = await db.getMenuDiOggi(mensaId);
    expect(menu.map((pasto) => pasto.id), contains(pastaId));
  });

  test('Quando la quantità arriva a 0 il piatto esce dal menù giornaliero', () async {
    await salvaMenu(
      primi: {pastaId: 3},
      contorni: {insalataId: 10},
      bevande: {},
    );

    final ordineId = await creaOrdine([(pastaId, 3)]);
    await db.aggiornaStatoOrdine(ordineId, 'Ricevuto');

    // La riga del menù è stata eliminata: niente più disponibilità...
    final quantita = await db.getQuantitaMenuDiOggi(mensaId);
    expect(quantita.containsKey(pastaId), isFalse);

    // ...e il piatto non compare più nel menù di oggi.
    final menu = await db.getMenuDiOggi(mensaId);
    expect(menu.map((pasto) => pasto.id), isNot(contains(pastaId)));

    // Gli altri piatti del menù non sono toccati.
    expect(menu.map((pasto) => pasto.id), contains(insalataId));
  });

  test('Rifiutare un ordine non modifica le quantità', () async {
    await salvaMenu(primi: {pastaId: 5}, contorni: {}, bevande: {});

    final ordineId = await creaOrdine([(pastaId, 2)]);
    await db.aggiornaStatoOrdine(ordineId, 'Rifiutato');

    final quantita = await db.getQuantitaMenuDiOggi(mensaId);
    expect(quantita[pastaId], 5);
  });

  test('Un ordine già accettato non decrementa due volte', () async {
    await salvaMenu(primi: {pastaId: 5}, contorni: {}, bevande: {});

    final ordineId = await creaOrdine([(pastaId, 2)]);

    await db.aggiornaStatoOrdine(ordineId, 'Ricevuto');
    await db.aggiornaStatoOrdine(ordineId, 'Ricevuto');

    final quantita = await db.getQuantitaMenuDiOggi(mensaId);
    expect(quantita[pastaId], 3);
  });

  test('I piatti con disponibilità alta restano nel menù anche dopo l’accettazione', () async {
    await salvaMenu(primi: {}, contorni: {}, bevande: {acquaId: 20});

    final ordineId = await creaOrdine([(acquaId, 4)]);
    await db.aggiornaStatoOrdine(ordineId, 'Ricevuto');

    final quantita = await db.getQuantitaMenuDiOggi(mensaId);
    expect(quantita[acquaId], 16);

    final menu = await db.getMenuDiOggi(mensaId);
    expect(menu.map((pasto) => pasto.id), contains(acquaId));
  });

  test('Piatti multipli nello stesso ordine decrementano ciascuno la propria quantità', () async {
    await salvaMenu(
      primi: {pastaId: 4},
      contorni: {insalataId: 2},
      bevande: {acquaId: 10},
    );

    final ordineId = await creaOrdine([(pastaId, 2), (insalataId, 2)]);
    await db.aggiornaStatoOrdine(ordineId, 'Ricevuto');

    final quantita = await db.getQuantitaMenuDiOggi(mensaId);
    expect(quantita[pastaId], 2);
    // Insalata esaurita: rimossa dal menù.
    expect(quantita.containsKey(insalataId), isFalse);

    final menu = await db.getMenuDiOggi(mensaId);
    expect(menu.map((pasto) => pasto.id), contains(pastaId));
    expect(menu.map((pasto) => pasto.id), isNot(contains(insalataId)));
  });
}
