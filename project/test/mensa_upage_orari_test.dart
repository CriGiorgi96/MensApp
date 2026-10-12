import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/database/database.dart';
import 'package:project/pages/mensa_upage.dart';

void main() {
  late AppDatabase db;
  late MenseData mensa;

  setUpAll(() {
    // Evita caricamenti di font via rete durante i test.
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());

    final gestoreId = await db
        .into(db.gestori)
        .insert(GestoriCompanion.insert(email: 'g@x.it', password: 'pw'));

    final mensaId = await db
        .into(db.mense)
        .insert(
          MenseCompanion.insert(
            gestoreId: gestoreId,
            nomeMensa: 'Mensa Centrale',
            citta: 'RM',
            comune: 'Roma',
            indirizzo: 'Via Roma 1',
            telefono: const Value('333 1112222'),
          ),
        );

    mensa = (await db.getMensaPrincipale(mensaId))!;

    // Lunedì: un turno. Martedì: due turni. Gli altri giorni chiusi.
    await db
        .into(db.orariApertura)
        .insert(
          OrariAperturaCompanion.insert(
            mensaId: mensaId,
            giorno: 'Lunedì',
            aperturaMinuti: 12 * 60,
            chiusuraMinuti: 15 * 60,
          ),
        );
    await db
        .into(db.orariApertura)
        .insert(
          OrariAperturaCompanion.insert(
            mensaId: mensaId,
            giorno: 'Martedì',
            aperturaMinuti: 12 * 60,
            chiusuraMinuti: 15 * 60,
          ),
        );
    await db
        .into(db.orariApertura)
        .insert(
          OrariAperturaCompanion.insert(
            mensaId: mensaId,
            giorno: 'Martedì',
            aperturaMinuti: 19 * 60,
            chiusuraMinuti: 21 * 60 + 30,
          ),
        );
  });

  tearDown(() async {
    await db.close();
  });

  Future<void> pumpPagina(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MensaUpage(
          database: db,
          mensa: mensa,
          utenteId: 1,
          isFavorite: false,
          canToggleFavorite: true,
          onToggleFavorite: () async => true,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('Gli orari di apertura sono nel container, a destra', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await pumpPagina(tester);

    // Contenuto presente.
    expect(find.text('Orari di apertura'), findsOneWidget);
    expect(find.text('Lunedì: 12:00-15:00'), findsOneWidget);
    expect(find.text('Martedì: 12:00-15:00, 19:00-21:30'), findsOneWidget);
    expect(find.text('Domenica: chiuso'), findsOneWidget);

    // Dentro il container con foto/nome/via/città/numero.
    expect(
      find.ancestor(
        of: find.text('Orari di apertura'),
        matching: find.byType(Card),
      ),
      findsWidgets,
    );

    // Allineato a destra rispetto agli altri contenuti.
    final nome = find.text('Mensa Centrale');
    final titoloOrari = find.text('Orari di apertura');
    expect(
      tester.getTopLeft(titoloOrari).dx,
      greaterThan(tester.getTopLeft(nome).dx),
    );

    // Il bordo destro degli orari è vicino al bordo destro del container.
    final card = tester.getRect(find.byType(Card).first);
    final rigaGiorno = tester.getRect(find.text('Domenica: chiuso'));
    expect(card.right - rigaGiorno.right, lessThan(40));
  });

  testWidgets('Su schermi stretti gli orari restano nel container, a destra', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(400, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await pumpPagina(tester);

    expect(find.text('Orari di apertura'), findsOneWidget);
    expect(find.text('Lunedì: 12:00-15:00'), findsOneWidget);

    // Sotto i dettagli...
    final telefono = find.text('333 1112222');
    expect(telefono, findsOneWidget);
    expect(
      tester.getTopLeft(find.text('Orari di apertura')).dy,
      greaterThan(tester.getTopLeft(telefono).dy),
    );

    // ...ma comunque a destra.
    final card = tester.getRect(find.byType(Card).first);
    final rigaGiorno = tester.getRect(find.text('Domenica: chiuso'));
    expect(card.right - rigaGiorno.right, lessThan(40));
  });
}
