import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/database/database.dart';
import 'package:project/pages/mensa_gestioneordini_page.dart.dart';

/// Formatta la data nello stesso modo usato dalla pagina
/// (es. 'Lunedì 06/10/2026').
String testoData(DateTime giorno) {
  const giorni = [
    'Lunedì',
    'Martedì',
    'Mercoledì',
    'Giovedì',
    'Venerdì',
    'Sabato',
    'Domenica',
  ];
  return '${giorni[giorno.weekday - 1]} '
      '${giorno.day.toString().padLeft(2, '0')}/'
      '${giorno.month.toString().padLeft(2, '0')}/'
      '${giorno.year}';
}

void main() {
  late AppDatabase db;
  late int mensaId;

  final oggi = DateTime.now();
  final inizioOggi = DateTime(oggi.year, oggi.month, oggi.day);
  final ieri = inizioOggi.subtract(const Duration(days: 1));
  final domani = inizioOggi.add(const Duration(days: 1));

  setUpAll(() {
    // Evita caricamenti di font via rete durante i test.
    GoogleFonts.config.allowRuntimeFetching = false;
  });

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
          ),
        );

    Future<int> inserisciUtente(String nome, String cognome) {
      return db
          .into(db.utenti)
          .insert(
            UtentiCompanion.insert(
              nome: nome,
              cognome: cognome,
              indirizzo: 'Via X 1',
              comune: 'Roma',
              provincia: 'RM',
              email: '$nome.$cognome@x.it'.toLowerCase(),
              password: 'pw',
              dataNascita: DateTime(2000, 1, 1),
            ),
          );
    }

    Future<void> inserisciOrdine({
      required int utenteId,
      required DateTime giornoRitiro,
      required String stato,
    }) async {
      await db
          .into(db.ordini)
          .insert(
            OrdiniCompanion.insert(
              utenteId: utenteId,
              mensaId: mensaId,
              giornoRitiro: giornoRitiro,
              orarioRitiro: '12:00',
              stato: Value(stato),
            ),
          );
    }

    // Ordine di IERI, già ritirato: deve sparire.
    final utenteIeri = await inserisciUtente('Ieri', 'Rossi');
    await inserisciOrdine(
      utenteId: utenteIeri,
      giornoRitiro: ieri,
      stato: 'Ritirato',
    );

    // Ordine di OGGI, già ritirato: deve stare solo nella tendina.
    final utenteOggi = await inserisciUtente('Oggi', 'Verdi');
    await inserisciOrdine(
      utenteId: utenteOggi,
      giornoRitiro: inizioOggi,
      stato: 'Ritirato',
    );

    // Ordine di OGGI ancora da gestire: resta nell'elenco principale.
    final utenteAttivo = await inserisciUtente('Attivo', 'Bianchi');
    await inserisciOrdine(
      utenteId: utenteAttivo,
      giornoRitiro: inizioOggi,
      stato: 'In attesa',
    );

    // Ordine di DOMANI: sezione giornaliera futura.
    final utenteDomani = await inserisciUtente('Domani', 'Neri');
    await inserisciOrdine(
      utenteId: utenteDomani,
      giornoRitiro: domani,
      stato: 'Pronto',
    );
  });

  tearDown(() async {
    await db.close();
  });

  testWidgets(
    "La sezione 'Ordini ritirati' è unica, sta sotto gli ordini di oggi "
    'e mostra solo i ritirati di oggi (quelli di ieri spariscono)',
    (tester) async {
      // La pagina di gestione è pensata per schermi ampi (web/desktop):
      // nel test il font di default è molto più largo di quello reale.
      tester.view.physicalSize = const Size(1400, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        MaterialApp(
          home: GestioneOrdiniMensa(database: db, mensaId: mensaId),
        ),
      );
      await tester.pumpAndSettle();

      // -----------------------------------------------------------
      // 1) La sezione "Ordini ritirati" esiste una sola volta.
      // -----------------------------------------------------------
      expect(find.text('Ordini ritirati'), findsOneWidget);

      // -----------------------------------------------------------
      // 2) Si trova sotto la parte degli ordini della data di oggi.
      // -----------------------------------------------------------
      final intestazioneOggi = find.text(testoData(inizioOggi));
      expect(intestazioneOggi, findsOneWidget);

      final yOggi = tester.getTopLeft(intestazioneOggi).dy;
      final yTendina = tester.getTopLeft(find.text('Ordini ritirati')).dy;
      expect(yTendina, greaterThan(yOggi));

      // Anche sotto la riga dell'ordine attivo di oggi.
      final yAttivo = tester.getTopLeft(find.text('Attivo Bianchi')).dy;
      expect(yTendina, greaterThan(yAttivo));

      // È prima della sezione del giorno successivo.
      final intestazioneDomani = find.text(testoData(domani));
      expect(intestazioneDomani, findsOneWidget);
      expect(tester.getTopLeft(intestazioneDomani).dy, greaterThan(yTendina));

      // -----------------------------------------------------------
      // 3) Gli ordini di ieri (anche se ritirati) sono spariti.
      // -----------------------------------------------------------
      expect(find.text(testoData(ieri)), findsNothing);
      expect(find.text('Ieri Rossi'), findsNothing);

      // -----------------------------------------------------------
      // 4) Cliccandoci sopra si vedono SOLO i ritirati di oggi.
      // -----------------------------------------------------------
      expect(find.text('Oggi Verdi'), findsNothing);

      await tester.tap(find.text('Ordini ritirati'));
      await tester.pumpAndSettle();

      expect(find.text('Ordini ritirati'), findsOneWidget);
      expect(find.text('Oggi Verdi'), findsOneWidget);

      // Il ritirato di ieri non compare.
      expect(find.text('Ieri Rossi'), findsNothing);

      // L'ordine attivo di oggi resta comunque visibile.
      expect(find.text('Attivo Bianchi'), findsOneWidget);
    },
  );
}
