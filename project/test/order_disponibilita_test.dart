import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/database/database.dart';
import 'package:project/pages/order.dart';

/// Verifica che il cliente veda la disponibilità dei piatti e che il
/// contatore del carrello non superi mai la quantità massima.
void main() {
  late AppDatabase db;
  late int mensaId;
  late int utenteId;

  const iva = '22222222222';

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

    final pastoId = await db
        .into(db.pasti)
        .insert(
          PastiCompanion.insert(
            partitaIva: Value(iva),
            nome: 'Pasta al pomodoro',
            categoria: 'PRIMI',
            prezzo: const Value(3.5),
          ),
        );

    // Menù di oggi con disponibilità massima 2.
    await db.salvaMenuCategoriaOggi(
      mensaId: mensaId,
      categoria: 'PRIMI',
      pastiSelezionati: [pastoId],
      quantita: {pastoId: 2},
    );
  });

  tearDown(() async {
    await db.close();
  });

  testWidgets(
    'La disponibilità è visibile e il contatore non supera '
    'mai il massimo anche premendo + più volte',
    (tester) async {
      tester.view.physicalSize = const Size(1200, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      final mensa = await db.getMensaPrincipale(mensaId);

      await tester.pumpWidget(
        MaterialApp(
          home: OrderPage(database: db, mensa: mensa!, utenteId: utenteId),
        ),
      );
      await tester.pumpAndSettle();

      // ---------------------------------------------------------------
      // 1) La disponibilità è mostrata al cliente sotto il nome.
      // ---------------------------------------------------------------
      expect(find.text('Disponibile: 2'), findsOneWidget);

      // ---------------------------------------------------------------
      // 2) Il contatore parte da 0 e il '+' è attivo.
      // ---------------------------------------------------------------
      final pulsanteAggiungi = find.widgetWithIcon(IconButton, Icons.add);
      expect(find.text('0'), findsOneWidget);
      expect(
        tester.widget<IconButton>(pulsanteAggiungi).onPressed,
        isNotNull,
      );

      // ---------------------------------------------------------------
      // 3) Premendo + si raggiunge il massimo (2) e non si sale oltre.
      // ---------------------------------------------------------------
      await tester.tap(pulsanteAggiungi);
      await tester.pump();
      expect(find.text('1'), findsOneWidget);

      await tester.tap(pulsanteAggiungi);
      await tester.pump();
      expect(find.text('2'), findsOneWidget);

      // Al massimo il pulsante '+' viene disabilitato.
      expect(
        tester.widget<IconButton>(pulsanteAggiungi).onPressed,
        isNull,
      );

      // Anche premendo ripetutamente il contatore resta a 2.
      await tester.tap(pulsanteAggiungi);
      await tester.tap(pulsanteAggiungi);
      await tester.pump();

      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsNothing);

      // ---------------------------------------------------------------
      // 4) Il '-' riporta il contatore indietro e riattiva il '+'.
      // ---------------------------------------------------------------
      final togli = find.widgetWithIcon(IconButton, Icons.remove);
      await tester.tap(togli);
      await tester.pump();

      expect(find.text('1'), findsOneWidget);
      expect(
        tester.widget<IconButton>(pulsanteAggiungi).onPressed,
        isNotNull,
      );
    },
  );
}
