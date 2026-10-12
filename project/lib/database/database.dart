import 'dart:io';
import 'dart:typed_data';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

// ============================================================
// PASTI
// ============================================================

class Pasti extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get partitaIva => text().nullable()();

  TextColumn get nome => text()();

  TextColumn get categoria => text()();

  RealColumn get prezzo => real().withDefault(const Constant(0.0))();

  TextColumn get imagePath => text().nullable()();

  TextColumn get descrizione => text().withDefault(const Constant(''))();

  // Immagine del pasto salvata direttamente nel database.
  BlobColumn get immagine => blob().nullable()();
}

// ============================================================
// UTENTI
// ============================================================

class Utenti extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get nome => text().withLength(min: 1, max: 50)();

  TextColumn get cognome => text().withLength(min: 1, max: 50)();

  TextColumn get indirizzo => text()();

  TextColumn get comune => text()();

  TextColumn get provincia => text()();

  TextColumn get email => text().unique()();

  TextColumn get password => text()();

  DateTimeColumn get dataNascita => dateTime()();
}

// ============================================================
// ALLERGIE
// ============================================================

class Allergie extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get nome => text().unique()();
}

// ============================================================
// PREFERENZE
// ============================================================

class Preferenze extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get nome => text().unique()();
}

// ============================================================
// UTENTE - ALLERGIE
// ============================================================

class UtenteAllergie extends Table {
  IntColumn get utenteId => integer().references(Utenti, #id)();

  IntColumn get allergiaId => integer().references(Allergie, #id)();

  @override
  Set<Column> get primaryKey => {utenteId, allergiaId};
}

// ============================================================
// UTENTE - PREFERENZE
// ============================================================

class UtentePreferenze extends Table {
  IntColumn get utenteId => integer().references(Utenti, #id)();

  IntColumn get preferenzaId => integer().references(Preferenze, #id)();

  @override
  Set<Column> get primaryKey => {utenteId, preferenzaId};
}

class UtenteMensePreferite extends Table {
  IntColumn get utenteId => integer().references(Utenti, #id)();

  IntColumn get mensaId => integer().references(Mense, #id)();

  @override
  Set<Column> get primaryKey => {utenteId, mensaId};
}

// ============================================================
// PASTO - ALLERGIE
// ============================================================

class PastoAllergie extends Table {
  IntColumn get pastoId => integer().references(Pasti, #id)();

  IntColumn get allergiaId => integer().references(Allergie, #id)();

  @override
  Set<Column> get primaryKey => {pastoId, allergiaId};
}

// ============================================================
// PASTO - PREFERENZE
// ============================================================

class PastoPreferenze extends Table {
  IntColumn get pastoId => integer().references(Pasti, #id)();

  IntColumn get preferenzaId => integer().references(Preferenze, #id)();

  @override
  Set<Column> get primaryKey => {pastoId, preferenzaId};
}

// ============================================================
// GESTORI
// ============================================================

class Gestori extends Table {
  IntColumn get id => integer().autoIncrement()();

  // L'email identifica il profilo del gestore.
  // Un gestore può avere più mense/sedi.
  TextColumn get email => text().unique()();

  TextColumn get password => text()();
}

// ============================================================
// MENSE
// ============================================================

class Mense extends Table {
  IntColumn get id => integer().autoIncrement()();

  // Ogni mensa appartiene ad un gestore.
  // Un gestore può avere più mense.
  IntColumn get gestoreId => integer().references(Gestori, #id)();

  TextColumn get nomeMensa => text().withLength(min: 1, max: 100)();

  TextColumn get citta => text()();

  TextColumn get comune => text()();

  TextColumn get indirizzo => text()();

  TextColumn get telefono => text().nullable()();

  TextColumn get partitaIva => text().nullable()();

  // Foto della mensa salvata direttamente nel database.
  BlobColumn get immagine => blob().nullable()();
}

// ============================================================
// ORARI
// ============================================================

class OrariApertura extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get mensaId => integer().references(Mense, #id)();

  TextColumn get giorno => text()();

  IntColumn get aperturaMinuti => integer()();

  IntColumn get chiusuraMinuti => integer()();
}

// ============================================================
// MENU GIORNALIERI
// ============================================================

class MenuGiornalieri extends Table {
  IntColumn get mensaId => integer().references(Mense, #id)();

  IntColumn get pastoId => integer().references(Pasti, #id)();

  TextColumn get data => text()();

  // Quantità disponibile del piatto nel menù del giorno: obbligatoria
  // per i piatti selezionati dalla mensa. Quando arriva a 0 la riga
  // viene eliminata e il piatto esce dal menù giornaliero. Il valore
  // NULL resta ammesso solo per righe preesistenti (senza limite).
  IntColumn get quantitaDisponibile => integer().nullable()();

  @override
  Set<Column> get primaryKey => {mensaId, pastoId, data};
}

// ============================================================
// ORDINI
// ============================================================

class Ordini extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get utenteId => integer().references(Utenti, #id)();

  IntColumn get mensaId => integer().references(Mense, #id)();

  // Giorno scelto per il ritiro dell'ordine.
  DateTimeColumn get giornoRitiro => dateTime()();

  // Orario scelto per il ritiro, formato 'HH:mm'.
  TextColumn get orarioRitiro => text()();

  TextColumn get nota => text().withDefault(const Constant(''))();

  RealColumn get totale => real().withDefault(const Constant(0.0))();

  IntColumn get piattiTotali => integer().withDefault(const Constant(0))();

  DateTimeColumn get dataInvio => dateTime().withDefault(currentDateAndTime)();

  TextColumn get stato => text().withDefault(const Constant('In attesa'))();
}

// ============================================================
// ORDINE - PIATTI
// ============================================================

class OrdinePiatti extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get ordineId => integer().references(Ordini, #id)();

  IntColumn get pastoId => integer().references(Pasti, #id)();

  // Nome e prezzo sono copiati all'invio, così lo storico resta
  // corretto anche se il piatto viene modificato o rimosso.
  TextColumn get nomePasto => text()();

  RealColumn get prezzo => real().withDefault(const Constant(0.0))();

  IntColumn get quantita => integer().withDefault(const Constant(1))();
}

// ============================================================
// ORDINE COMPLETO (testata + mensa + piatti)
// ============================================================

class OrdineCompleto {
  const OrdineCompleto({
    required this.ordine,
    required this.mensa,
    required this.piatti,
    this.utente,
  });

  final OrdiniData ordine;
  final MenseData? mensa;
  final List<OrdinePiattiData> piatti;

  /// Cliente che ha effettuato l'ordine (caricato nei listati mensa).
  final UtentiData? utente;
}

// ============================================================
// DATABASE EXECUTOR
// ============================================================

QueryExecutor createDatabaseExecutor() {
  return LazyDatabase(() async {
    final directory = await getApplicationDocumentsDirectory();

    final file = File(p.join(directory.path, 'app.sqlite'));

    return NativeDatabase.createInBackground(file, logStatements: false);
  });
}

// ============================================================
// DATABASE
// ============================================================

@DriftDatabase(
  tables: [
    Pasti,
    Utenti,
    Allergie,
    Preferenze,
    UtenteAllergie,
    UtentePreferenze,
    UtenteMensePreferite,
    PastoAllergie,
    PastoPreferenze,
    Gestori,
    Mense,
    OrariApertura,
    MenuGiornalieri,
    Ordini,
    OrdinePiatti,
  ],
)
class AppDatabase extends _$AppDatabase {
  // ========================================================
  // DATI PREDEFINITI
  // ========================================================

  static const List<String> allergiePredefinite = [
    'Cereali contenenti glutine',
    'Crostacei',
    'Uova',
    'Pesce',
    'Arachidi',
    'Soia',
    'Latte',
    'Frutta a guscio',
    'Sedano',
    'Senape',
    'Semi di sesamo',
    'Anidride solforosa e solfiti',
    'Lupini',
    'Molluschi',
  ];

  static const List<String> preferenzePredefinite = [
    'Vegetariano',
    'Vegano',
    'Senza glutine',
    'Senza lattosio',
    'Halal',
    'Kosher',
  ];

  AppDatabase() : super(createDatabaseExecutor());

  /// Usato dai test: permette di passare un executor diverso
  /// (es. NativeDatabase.memory()) invece del file su disco.
  AppDatabase.forTesting(super.executor);

  // ========================================================
  // VERSIONE DATABASE
  // ========================================================

  @override
  int get schemaVersion => 6;

  // ========================================================
  // MIGRATION
  // ========================================================

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();

        // Inserimento allergie predefinite
        for (final nome in allergiePredefinite) {
          await into(allergie).insert(AllergieCompanion.insert(nome: nome));
        }

        // Inserimento preferenze predefinite
        for (final nome in preferenzePredefinite) {
          await into(preferenze).insert(PreferenzeCompanion.insert(nome: nome));
        }
      },

      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          final existingTables = await customSelect(
            "SELECT name FROM sqlite_master WHERE type = 'table'",
          ).get();
          final existingTableNames = existingTables
              .map((row) => row.read<String>('name'))
              .toSet();

          if (!existingTableNames.contains(gestori.actualTableName)) {
            await m.createTable(gestori);
          }
          if (!existingTableNames.contains(mense.actualTableName)) {
            await m.createTable(mense);
          }
        }

        if (from < 3) {
          await m.createTable(utenteMensePreferite);
        }

        if (from < 4) {
          await m.createTable(ordini);
          await m.createTable(ordinePiatti);
        }

        if (from < 5) {
          // Colonna con l'immagine (foto mensa e foto pasto)
          // salvata direttamente nel database.
          await m.addColumn(pasti, pasti.immagine);
          await m.addColumn(mense, mense.immagine);
        }

        if (from < 6) {
          // Quantità disponibile per ogni piatto del menù giornaliero.
          await m.addColumn(
            menuGiornalieri,
            menuGiornalieri.quantitaDisponibile,
          );
        }
      },
    );
  }

  // ========================================================
  // DATA OGGI
  // ========================================================

  /// Formatta una data come 'yyyy-MM-dd' (chiave del menù giornaliero).
  String _dataDi(DateTime giorno) {
    return '${giorno.year.toString().padLeft(4, '0')}-'
        '${giorno.month.toString().padLeft(2, '0')}-'
        '${giorno.day.toString().padLeft(2, '0')}';
  }

  String _dataOggi() => _dataDi(DateTime.now());

  // ========================================================
  // GESTORI
  // ========================================================

  // ========================================================
  // REGISTRA GESTORE + PRIMA MENSA
  // ========================================================
  Future<GestoriData?> getGestoreMensa(int mensaId) async {
    final query = select(gestori)
        .join([innerJoin(mense, mense.gestoreId.equalsExp(gestori.id))]);

    query.where(mense.id.equals(mensaId));

    final row = await query.getSingleOrNull();

    if (row == null) {
      return null;
    }

    return row.readTable(gestori);
  }

  Future<int> inserisciNuovaSede({
    required int gestoreId,
    required String nomeMensa,
    required String citta,
    required String comune,
    required String indirizzo,
    String? telefono,
    String? partitaIva,
  }) {
    return into(mense).insert(
      MenseCompanion.insert(
        gestoreId: gestoreId,
        nomeMensa: nomeMensa.trim(),
        citta: citta.trim(),
        comune: comune.trim(),
        indirizzo: indirizzo.trim(),
        telefono: Value(
          telefono?.trim().isEmpty == true ? null : telefono?.trim(),
        ),
        partitaIva: Value(
          partitaIva?.trim().isEmpty == true ? null : partitaIva?.trim(),
        ),
      ),
    );
  }

  Future<int> registerMensa({
    required String nomeMensa,
    required String email,
    required String password,
    required String indirizzo,
    required String citta,
    required String comune,
    String? telefono,
    String? partitaIva,
  }) async {
    return transaction(() async {
      final emailNormalizzata = email.trim();
      final gestoreEsistente = await (select(
        gestori,
      )..where((tbl) => tbl.email.equals(emailNormalizzata))).getSingleOrNull();

      if (gestoreEsistente != null) {
        throw Exception(
          'Questa email ha gia un profilo mensa. Accedi con quell\'account e aggiungi la nuova sede dalla homepage.',
        );
      }

      // ------------------------------------------------------
      // CREAZIONE GESTORE
      // ------------------------------------------------------

      final gestoreId = await into(gestori).insert(
        GestoriCompanion.insert(email: emailNormalizzata, password: password),
      );

      // ------------------------------------------------------
      // CREAZIONE PRIMA MENSA
      // ------------------------------------------------------

      final mensaId = await into(mense).insert(
        MenseCompanion.insert(
          gestoreId: gestoreId,
          nomeMensa: nomeMensa.trim(),
          citta: citta.trim(),
          comune: comune.trim(),
          indirizzo: indirizzo.trim(),
          telefono: Value(
            telefono?.trim().isEmpty == true ? null : telefono?.trim(),
          ),
          partitaIva: Value(
            partitaIva?.trim().isEmpty == true ? null : partitaIva?.trim(),
          ),
        ),
      );

      return mensaId;
    });
  }

  // ========================================================
  // LOGIN GESTORE
  // ========================================================

  Future<GestoriData?> loginGestore(String email, String password) {
    return (select(gestori)..where(
          (tbl) =>
              tbl.email.equals(email.trim()) & tbl.password.equals(password),
        ))
        .getSingleOrNull();
  }

  // ========================================================
  // RECUPERA TUTTE LE MENSE DI UN GESTORE
  // ========================================================

  Future<List<MenseData>> getMenseGestore(int gestoreId) {
    return (select(mense)
          ..where((tbl) => tbl.gestoreId.equals(gestoreId))
          ..orderBy([
            (tbl) =>
                OrderingTerm(expression: tbl.nomeMensa, mode: OrderingMode.asc),
          ]))
        .get();
  }

  Future<List<MenseData>> getMensePreferiteUtente(int utenteId) async {
    final query = select(mense).join([
      innerJoin(
        utenteMensePreferite,
        utenteMensePreferite.mensaId.equalsExp(mense.id),
      ),
    ]);

    query.where(utenteMensePreferite.utenteId.equals(utenteId));
    query.orderBy([
      OrderingTerm(expression: mense.nomeMensa, mode: OrderingMode.asc),
    ]);

    final rows = await query.get();
    return rows.map((row) => row.readTable(mense)).toList();
  }

  Future<List<MenseData>> getMenseNellaCittaUtente(int utenteId) async {
    final utente = await (select(
      utenti,
    )..where((tbl) => tbl.id.equals(utenteId))).getSingleOrNull();

    if (utente == null) return [];

    final provinciaUtente = utente.provincia.trim().toLowerCase();
    final tutteLeMense = await getTutteLeMense();

    return tutteLeMense
        .where((mensa) => mensa.citta.trim().toLowerCase() == provinciaUtente)
        .toList();
  }

  Future<void> aggiungiMensaPreferita({
    required int utenteId,
    required int mensaId,
  }) async {
    await into(utenteMensePreferite).insertOnConflictUpdate(
      UtenteMensePreferiteCompanion.insert(
        utenteId: utenteId,
        mensaId: mensaId,
      ),
    );
  }

  Future<void> rimuoviMensaPreferita({
    required int utenteId,
    required int mensaId,
  }) async {
    await (delete(utenteMensePreferite)..where(
          (tbl) => tbl.utenteId.equals(utenteId) & tbl.mensaId.equals(mensaId),
        ))
        .go();
  }

  Stream<List<MenseData>> watchMenseGestore(int gestoreId) {
    return (select(mense)
          ..where((tbl) => tbl.gestoreId.equals(gestoreId))
          ..orderBy([
            (tbl) =>
                OrderingTerm(expression: tbl.nomeMensa, mode: OrderingMode.asc),
          ]))
        .watch();
  }

  // ========================================================
  // AGGIUNGI NUOVA SEDE AD UN GESTORE
  // ========================================================

  Future<int> aggiungiMensa({
    required int gestoreId,
    required String nomeMensa,
    required String indirizzo,
    required String citta,
    required String comune,
    String? telefono,
    String? partitaIva,
  }) {
    return into(mense).insert(
      MenseCompanion.insert(
        gestoreId: gestoreId,
        nomeMensa: nomeMensa.trim(),
        indirizzo: indirizzo.trim(),
        citta: citta.trim(),
        comune: comune.trim(),
        telefono: Value(
          telefono?.trim().isEmpty == true ? null : telefono?.trim(),
        ),
        partitaIva: Value(
          partitaIva?.trim().isEmpty == true ? null : partitaIva?.trim(),
        ),
      ),
    );
  }

  // ========================================================
  // TUTTE LE MENSE
  // ========================================================

  Future<List<MenseData>> getTutteLeMense() {
    return (select(mense)..orderBy([
          (tbl) =>
              OrderingTerm(expression: tbl.nomeMensa, mode: OrderingMode.asc),
        ]))
        .get();
  }

  // ========================================================
  // MENSA PRINCIPALE / SINGOLA MENSA
  // ========================================================

  Future<MenseData?> getMensaPrincipale(int mensaId) {
    return (select(
      mense,
    )..where((tbl) => tbl.id.equals(mensaId))).getSingleOrNull();
  }

  // ========================================================
  // MODIFICA MENSA
  // ========================================================

  Future<void> modificaMensa({
    required int mensaId,
    required String nomeMensa,
    required String citta,
    required String comune,
    required String indirizzo,
    String? telefono,
  }) async {
    await (update(mense)..where((tbl) => tbl.id.equals(mensaId))).write(
      MenseCompanion(
        nomeMensa: Value(nomeMensa.trim()),
        citta: Value(citta.trim()),
        comune: Value(comune.trim()),
        indirizzo: Value(indirizzo.trim()),
        telefono: Value(
          telefono?.trim().isEmpty == true ? null : telefono?.trim(),
        ),
      ),
    );
  }

  // ========================================================
  // IMMAGINI MENSA E PASTI (SALVATE NEL DATABASE)
  // ========================================================

  /// Salva la foto della mensa. Passando [immagine] = null
  /// la foto esistente viene rimossa.
  Future<void> salvaImmagineMensa({
    required int mensaId,
    required Uint8List? immagine,
  }) async {
    await (update(mense)..where((tbl) => tbl.id.equals(mensaId))).write(
      MenseCompanion(immagine: Value(immagine)),
    );
  }

  /// Salva la foto di un pasto. Passando [immagine] = null
  /// la foto esistente viene rimossa.
  Future<void> salvaImmaginePasto({
    required int pastoId,
    required Uint8List? immagine,
  }) async {
    await (update(pasti)..where((tbl) => tbl.id.equals(pastoId))).write(
      PastiCompanion(immagine: Value(immagine)),
    );
  }

  // ========================================================
  // MENSE PER PARTITA IVA
  // ========================================================

  Stream<List<MenseData>> watchMensePerPartitaIva(String partitaIva) {
    return (select(
      mense,
    )..where((tbl) => tbl.partitaIva.equals(partitaIva.trim()))).watch();
  }

  // ========================================================
  // ALTRE SEDI DELLO STESSO GESTORE
  // ========================================================

  Stream<List<MenseData>> watchAltreSediGestore({
    required int gestoreId,
    required int mensaPrincipaleId,
  }) {
    return (select(mense)
          ..where(
            (tbl) =>
                tbl.gestoreId.equals(gestoreId) &
                tbl.id.isNotValue(mensaPrincipaleId),
          )
          ..orderBy([
            (tbl) =>
                OrderingTerm(expression: tbl.nomeMensa, mode: OrderingMode.asc),
          ]))
        .watch();
  }

  // ========================================================
  // ELIMINA MENSA
  // ========================================================

  Future<void> eliminaMensa(int mensaId) async {
    await transaction(() async {
      // Elimina gli orari
      await (delete(
        orariApertura,
      )..where((tbl) => tbl.mensaId.equals(mensaId))).go();

      // Elimina i menu giornalieri
      await (delete(
        menuGiornalieri,
      )..where((tbl) => tbl.mensaId.equals(mensaId))).go();

      await (delete(
        utenteMensePreferite,
      )..where((tbl) => tbl.mensaId.equals(mensaId))).go();

      // Elimina la mensa
      await (delete(mense)..where((tbl) => tbl.id.equals(mensaId))).go();
    });
  }

  // ========================================================
  // ORARI
  // ========================================================

  Future<List<OrariAperturaData>> getOrariMensa(int mensaId) {
    return (select(orariApertura)
          ..where((tbl) => tbl.mensaId.equals(mensaId))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.id)]))
        .get();
  }

  Stream<List<OrariAperturaData>> watchOrariMensa(int mensaId) {
    return (select(orariApertura)
          ..where((tbl) => tbl.mensaId.equals(mensaId))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.id)]))
        .watch();
  }

  Future<int> salvaOrario({
    required int mensaId,
    required String giorno,
    required int aperturaMinuti,
    required int chiusuraMinuti,
  }) {
    return into(orariApertura).insert(
      OrariAperturaCompanion.insert(
        mensaId: mensaId,
        giorno: giorno,
        aperturaMinuti: aperturaMinuti,
        chiusuraMinuti: chiusuraMinuti,
      ),
    );
  }

  Future<void> modificaOrario({
    required int id,
    required int aperturaMinuti,
    required int chiusuraMinuti,
  }) async {
    await (update(orariApertura)..where((tbl) => tbl.id.equals(id))).write(
      OrariAperturaCompanion(
        aperturaMinuti: Value(aperturaMinuti),
        chiusuraMinuti: Value(chiusuraMinuti),
      ),
    );
  }

  Future<void> eliminaOrario(int id) async {
    await (delete(orariApertura)..where((tbl) => tbl.id.equals(id))).go();
  }

  // ========================================================
  // CONTROLLA SE LA MENSA È APERTA
  // ========================================================

  Future<bool> isMensaAperta(int mensaId) async {
    final adesso = DateTime.now();

    const giorni = [
      'Lunedì',
      'Martedì',
      'Mercoledì',
      'Giovedì',
      'Venerdì',
      'Sabato',
      'Domenica',
    ];

    final giorno = giorni[adesso.weekday - 1];

    final minuti = adesso.hour * 60 + adesso.minute;

    final orari =
        await (select(orariApertura)..where(
              (tbl) => tbl.mensaId.equals(mensaId) & tbl.giorno.equals(giorno),
            ))
            .get();

    for (final orario in orari) {
      if (minuti >= orario.aperturaMinuti && minuti < orario.chiusuraMinuti) {
        return true;
      }
    }

    return false;
  }

  // ========================================================
  // PASTI
  // ========================================================

  Future<List<PastiData>> getPastiPerCategoria(
    int mensaId,
    String categoria,
  ) async {
    final mensa = await getMensaPrincipale(mensaId);

    if (mensa == null) {
      return [];
    }

    final iva = mensa.partitaIva?.trim();

    if (iva == null || iva.isEmpty) {
      return [];
    }

    return (select(pasti)
          ..where(
            (tbl) =>
                tbl.partitaIva.equals(iva) & tbl.categoria.equals(categoria),
          )
          ..orderBy([
            (tbl) => OrderingTerm(expression: tbl.nome, mode: OrderingMode.asc),
          ]))
        .get();
  }

  Stream<List<PastiData>> watchPastiPerCategoria(
    int mensaId,
    String categoria,
  ) {
    final query = select(pasti)
        .join([innerJoin(mense, mense.partitaIva.equalsExp(pasti.partitaIva))]);

    query.where(mense.id.equals(mensaId) & pasti.categoria.equals(categoria));

    query.orderBy([
      OrderingTerm(expression: pasti.nome, mode: OrderingMode.asc),
    ]);

    return query.watch().map(
      (rows) => rows.map((row) => row.readTable(pasti)).toList(),
    );
  }

  Future<int> inserisciPasto({
    required int mensaId,
    required String nome,
    required String categoria,
    required double prezzo,
    required String descrizione,
    required List<int> allergie,
    required List<int> preferenze,
    String? imagePath,
  }) async {
    return transaction(() async {
      final mensa = await getMensaPrincipale(mensaId);

      if (mensa == null) {
        throw Exception('Mensa non trovata.');
      }

      final iva = mensa.partitaIva?.trim();

      if (iva == null || iva.isEmpty) {
        throw Exception('La mensa non ha una partita IVA associata.');
      }

      final pastoId = await into(pasti).insert(
        PastiCompanion.insert(
          partitaIva: Value(iva),
          nome: nome.trim(),
          categoria: categoria.trim(),
          prezzo: Value(prezzo),
          imagePath: Value(
            imagePath?.trim().isEmpty == true ? null : imagePath?.trim(),
          ),
          descrizione: Value(descrizione.trim()),
        ),
      );

      for (final allergiaId in allergie) {
        await into(pastoAllergie).insert(
          PastoAllergieCompanion.insert(
            pastoId: pastoId,
            allergiaId: allergiaId,
          ),
        );
      }

      for (final preferenzaId in preferenze) {
        await into(pastoPreferenze).insert(
          PastoPreferenzeCompanion.insert(
            pastoId: pastoId,
            preferenzaId: preferenzaId,
          ),
        );
      }

      return pastoId;
    });
  }

  Future<void> modificaPasto({
    required int pastoId,
    required String nome,
    required double prezzo,
    required String descrizione,
    required List<int> allergie,
    required List<int> preferenze,
    String? imagePath,
  }) async {
    await transaction(() async {
      await (update(pasti)..where((tbl) => tbl.id.equals(pastoId))).write(
        PastiCompanion(
          nome: Value(nome.trim()),
          prezzo: Value(prezzo),
          descrizione: Value(descrizione.trim()),
          imagePath: Value(
            imagePath?.trim().isEmpty == true ? null : imagePath?.trim(),
          ),
        ),
      );

      await (delete(
        pastoAllergie,
      )..where((tbl) => tbl.pastoId.equals(pastoId))).go();

      for (final allergiaId in allergie) {
        await into(pastoAllergie).insert(
          PastoAllergieCompanion.insert(
            pastoId: pastoId,
            allergiaId: allergiaId,
          ),
        );
      }

      await (delete(
        pastoPreferenze,
      )..where((tbl) => tbl.pastoId.equals(pastoId))).go();

      for (final preferenzaId in preferenze) {
        await into(pastoPreferenze).insert(
          PastoPreferenzeCompanion.insert(
            pastoId: pastoId,
            preferenzaId: preferenzaId,
          ),
        );
      }
    });
  }

  Future<void> eliminaPasto(int pastoId) async {
    await transaction(() async {
      await (delete(
        menuGiornalieri,
      )..where((tbl) => tbl.pastoId.equals(pastoId))).go();

      await (delete(
        pastoAllergie,
      )..where((tbl) => tbl.pastoId.equals(pastoId))).go();

      await (delete(
        pastoPreferenze,
      )..where((tbl) => tbl.pastoId.equals(pastoId))).go();

      await (delete(pasti)..where((tbl) => tbl.id.equals(pastoId))).go();
    });
  }

  // ========================================================
  // ALLERGIE
  // ========================================================

  Future<List<AllergieData>> getTutteLeAllergie() {
    return select(allergie).get();
  }

  Future<List<AllergieData>> getAllergiePasto(int pastoId) async {
    final query = select(pastoAllergie).join([
      innerJoin(allergie, allergie.id.equalsExp(pastoAllergie.allergiaId)),
    ]);

    query.where(pastoAllergie.pastoId.equals(pastoId));

    final rows = await query.get();

    return rows.map((row) => row.readTable(allergie)).toList();
  }

  Future<Set<int>> getAllergiePastoIds(int pastoId) async {
    final rows = await (select(
      pastoAllergie,
    )..where((tbl) => tbl.pastoId.equals(pastoId))).get();
    return rows.map((row) => row.allergiaId).toSet();
  }

  // ========================================================
  // PREFERENZE
  // ========================================================

  Future<List<PreferenzeData>> getTutteLePreferenze() {
    return select(preferenze).get();
  }

  Future<List<PreferenzeData>> getPreferenzePasto(int pastoId) async {
    final query = select(pastoPreferenze).join([
      innerJoin(
        preferenze,
        preferenze.id.equalsExp(pastoPreferenze.preferenzaId),
      ),
    ]);

    query.where(pastoPreferenze.pastoId.equals(pastoId));

    final rows = await query.get();

    return rows.map((row) => row.readTable(preferenze)).toList();
  }

  Future<Set<int>> getPreferenzePastoIds(int pastoId) async {
    final rows = await (select(
      pastoPreferenze,
    )..where((tbl) => tbl.pastoId.equals(pastoId))).get();
    return rows.map((row) => row.preferenzaId).toSet();
  }

  // ========================================================
  // MENU
  // ========================================================

  Future<List<PastiData>> getMenuGiornaliero({
    required int mensaId,
    required String data,
  }) async {
    final query = select(menuGiornalieri)
        .join([innerJoin(pasti, pasti.id.equalsExp(menuGiornalieri.pastoId))]);

    query.where(
      menuGiornalieri.mensaId.equals(mensaId) &
          menuGiornalieri.data.equals(data),
    );

    query.orderBy([
      OrderingTerm(expression: pasti.categoria, mode: OrderingMode.asc),
      OrderingTerm(expression: pasti.nome, mode: OrderingMode.asc),
    ]);

    final rows = await query.get();

    return rows.map((row) => row.readTable(pasti)).toList();
  }

  Future<List<PastiData>> getMenuDiOggi(int mensaId) {
    return getMenuGiornaliero(mensaId: mensaId, data: _dataOggi());
  }

  Future<List<PastiData>> getMenuCategoriaOggi({
    required int mensaId,
    required String categoria,
  }) async {
    final query = select(menuGiornalieri)
        .join([innerJoin(pasti, pasti.id.equalsExp(menuGiornalieri.pastoId))]);

    query.where(
      menuGiornalieri.mensaId.equals(mensaId) &
          menuGiornalieri.data.equals(_dataOggi()) &
          pasti.categoria.equals(categoria),
    );

    query.orderBy([
      OrderingTerm(expression: pasti.nome, mode: OrderingMode.asc),
    ]);

    final rows = await query.get();

    return rows.map((row) => row.readTable(pasti)).toList();
  }

  /// Salva il menù di oggi per una categoria: i piatti selezionati
  /// vengono inseriti nel menù giornaliero, gli altri rimossi.
  ///
  /// [quantita] associa a ogni pastoId la quantità disponibile impostata
  /// dalla mensa: è obbligatoria (>= 1) per ogni piatto selezionato.
  Future<void> salvaMenuCategoriaOggi({
    required int mensaId,
    required String categoria,
    required List<int> pastiSelezionati,
    Map<int, int> quantita = const {},
  }) async {
    final data = _dataOggi();

    await transaction(() async {
      final mensa = await getMensaPrincipale(mensaId);

      if (mensa == null) {
        throw Exception('Mensa non trovata.');
      }

      final iva = mensa.partitaIva?.trim();

      if (iva == null || iva.isEmpty) {
        throw Exception('La mensa non ha una partita IVA associata.');
      }

      final pastiCategoria =
          await (select(pasti)..where(
                (tbl) =>
                    tbl.partitaIva.equals(iva) &
                    tbl.categoria.equals(categoria),
              ))
              .get();

      final ids = pastiCategoria.map((pasto) => pasto.id).toSet();

      for (final pastoId in pastiSelezionati) {
        if (!ids.contains(pastoId)) {
          throw Exception(
            'Il pasto $pastoId non appartiene '
            'al gestore della mensa.',
          );
        }
      }

      await (delete(menuGiornalieri)..where(
            (tbl) =>
                tbl.mensaId.equals(mensaId) &
                tbl.data.equals(data) &
                tbl.pastoId.isIn(ids.toList()),
          ))
          .go();

      for (final pastoId in pastiSelezionati) {
        final disponibilita = quantita[pastoId];

        // La disponibilità è obbligatoria per ogni piatto selezionato:
        // se manca o non è valida la transazione va in rollback.
        if (disponibilita == null || disponibilita < 1) {
          throw Exception(
            'Disponibilità obbligatoria per ogni piatto del menù '
            '(pasto $pastoId).',
          );
        }

        await into(menuGiornalieri).insert(
          MenuGiornalieriCompanion.insert(
            mensaId: mensaId,
            pastoId: pastoId,
            data: data,
            quantitaDisponibile: Value(disponibilita),
          ),
        );
      }
    });
  }

  /// Quantità disponibili dei piatti nel menù di oggi, per pastoId.
  /// Un pasto assente dalla mappa non è nel menù; il valore null
  /// indica una riga creata prima che la disponibilità diventasse
  /// obbligatoria (trattata come "senza limite").
  Future<Map<int, int?>> getQuantitaMenuDiOggi(int mensaId) async {
    final righe =
        await (select(menuGiornalieri)
              ..where(
                (tbl) =>
                    tbl.mensaId.equals(mensaId) &
                    tbl.data.equals(_dataOggi()),
              ))
            .get();

    return {for (final riga in righe) riga.pastoId: riga.quantitaDisponibile};
  }

  /// Diminuisce la quantità disponibile di un piatto nel menù giornaliero
  /// in seguito all'accettazione di un ordine.
  ///
  /// Cerca prima la riga del menù di oggi, altrimenti quella del giorno
  /// di ritiro. Se la quantità non è gestita (null) non fa nulla; se
  /// arriva a 0 la riga viene eliminata e il piatto esce dal menù.
  Future<void> _diminuisciQuantitaDisponibile({
    required int mensaId,
    required int pastoId,
    required int quantitaOrdinata,
    required List<String> dateCandidate,
  }) async {
    for (final data in dateCandidate) {
      final riga =
          await (select(menuGiornalieri)
                ..where(
                  (tbl) =>
                      tbl.mensaId.equals(mensaId) &
                      tbl.pastoId.equals(pastoId) &
                      tbl.data.equals(data),
                ))
              .getSingleOrNull();

      // Nessuna riga per questa data: prova la successiva.
      if (riga == null) continue;

      // Quantità non gestita: nessun decremento.
      if (riga.quantitaDisponibile == null) return;

      final nuovaQuantita = riga.quantitaDisponibile! - quantitaOrdinata;

      if (nuovaQuantita <= 0) {
        // Fine disponibilità: il piatto viene tolto dal menù giornaliero.
        await (delete(menuGiornalieri)
              ..where(
                (tbl) =>
                    tbl.mensaId.equals(riga.mensaId) &
                    tbl.pastoId.equals(riga.pastoId) &
                    tbl.data.equals(riga.data),
              ))
            .go();
      } else {
        await (update(menuGiornalieri)
              ..where(
                (tbl) =>
                    tbl.mensaId.equals(riga.mensaId) &
                    tbl.pastoId.equals(riga.pastoId) &
                    tbl.data.equals(riga.data),
              ))
            .write(
              MenuGiornalieriCompanion(
                quantitaDisponibile: Value(nuovaQuantita),
              ),
            );
      }

      return;
    }
  }

  // ========================================================
  // ORDINI
  // ========================================================

  /// Salva un ordine completo (testata + piatti) in una transazione.
  /// Restituisce l'id dell'ordine creato.
  Future<int> salvaOrdine({
    required int utenteId,
    required int mensaId,
    required DateTime giornoRitiro,
    required String orarioRitiro,
    required String nota,
    required double totale,
    required int piattiTotali,
    required List<(PastiData pasto, int quantita)> piatti,
  }) async {
    return transaction(() async {
      final ordineId = await into(ordini).insert(
        OrdiniCompanion.insert(
          utenteId: utenteId,
          mensaId: mensaId,
          giornoRitiro: giornoRitiro,
          orarioRitiro: orarioRitiro,
          nota: Value(nota),
          totale: Value(totale),
          piattiTotali: Value(piattiTotali),
        ),
      );

      for (final (pasto, quantita) in piatti) {
        await into(ordinePiatti).insert(
          OrdinePiattiCompanion.insert(
            ordineId: ordineId,
            pastoId: pasto.id,
            nomePasto: pasto.nome,
            prezzo: Value(pasto.prezzo),
            quantita: Value(quantita),
          ),
        );
      }

      return ordineId;
    });
  }

  /// Riuso di un ordine precedente ("Ordina ancora"): salva un nuovo
  /// ordine copiando i piatti memorizzati nello storico (pastoId, nome
  /// e prezzo), così il riepilogo resta identico a quello mostrato.
  /// I piatti di cui il pasto non esiste più vengono scartati: se non
  /// ne resta nessuno viene lanciato un errore.
  Future<int> salvaOrdineRipetuto({
    required int utenteId,
    required int mensaId,
    required DateTime giornoRitiro,
    required String orarioRitiro,
    required String nota,
    required List<OrdinePiattiData> piatti,
  }) async {
    final idDisponibili = piatti.map((piatto) => piatto.pastoId).toSet();
    final pastiTrovati = await (select(
      pasti,
    )..where((tabella) => tabella.id.isIn(idDisponibili))).get();
    final perId = {for (final pasto in pastiTrovati) pasto.id: pasto};

    final piattiValidi = [
      for (final piatto in piatti)
        if (perId.containsKey(piatto.pastoId)) piatto,
    ];
    if (piattiValidi.isEmpty) {
      throw StateError('I piatti di questo ordine non sono più disponibili.');
    }

    final totale = piattiValidi.fold<double>(
      0,
      (somma, piatto) => somma + piatto.prezzo * piatto.quantita,
    );
    final piattiTotali = piattiValidi.fold<int>(
      0,
      (somma, piatto) => somma + piatto.quantita,
    );

    return transaction(() async {
      final ordineId = await into(ordini).insert(
        OrdiniCompanion.insert(
          utenteId: utenteId,
          mensaId: mensaId,
          giornoRitiro: giornoRitiro,
          orarioRitiro: orarioRitiro,
          nota: Value(nota),
          totale: Value(totale),
          piattiTotali: Value(piattiTotali),
        ),
      );

      for (final piatto in piattiValidi) {
        await into(ordinePiatti).insert(
          OrdinePiattiCompanion.insert(
            ordineId: ordineId,
            pastoId: piatto.pastoId,
            nomePasto: piatto.nomePasto,
            prezzo: Value(piatto.prezzo),
            quantita: Value(piatto.quantita),
          ),
        );
      }

      return ordineId;
    });
  }

  /// Ordini inviati dall'utente, dal più recente al più vecchio,
  /// con mensa e piatti già caricati.
  Future<List<OrdineCompleto>> getOrdiniUtente(int utenteId) async {
    final ordiniList =
        await (select(ordini)
              // Gli ordini con stato 'Ricevuto' spariscono dalla lista,
              // così come quelli eliminati dall'utente.
              ..where(
                (tbl) =>
                    tbl.utenteId.equals(utenteId) &
                    tbl.stato.equals('Ricevuto').not() &
                    tbl.stato.equals('Eliminato').not(),
              )
              ..orderBy([
                (tbl) => OrderingTerm.desc(tbl.dataInvio),
                (tbl) => OrderingTerm.desc(tbl.id),
              ]))
            .get();

    final risultati = <OrdineCompleto>[];

    for (final ordine in ordiniList) {
      final piatti =
          await (select(ordinePiatti)
                ..where((tbl) => tbl.ordineId.equals(ordine.id))
                ..orderBy([(tbl) => OrderingTerm.asc(tbl.id)]))
              .get();

      final mensa = await (select(
        mense,
      )..where((tbl) => tbl.id.equals(ordine.mensaId))).getSingleOrNull();

      risultati.add(
        OrdineCompleto(ordine: ordine, mensa: mensa, piatti: piatti),
      );
    }

    return risultati;
  }

  /// Storico completo degli ordini dell'utente: mostra TUTTI gli
  /// ordini (anche i più vecchi e in qualunque stato), dal più
  /// recente al meno recente, con mensa e piatti già caricati.
  Future<List<OrdineCompleto>> getStoricoOrdiniUtente(int utenteId) async {
    final ordiniList =
        await (select(ordini)
              ..where((tbl) => tbl.utenteId.equals(utenteId))
              ..orderBy([
                (tbl) => OrderingTerm.desc(tbl.giornoRitiro),
                (tbl) => OrderingTerm.desc(tbl.orarioRitiro),
                (tbl) => OrderingTerm.desc(tbl.id),
              ]))
            .get();

    final risultati = <OrdineCompleto>[];

    for (final ordine in ordiniList) {
      final piatti =
          await (select(ordinePiatti)
                ..where((tbl) => tbl.ordineId.equals(ordine.id))
                ..orderBy([(tbl) => OrderingTerm.asc(tbl.id)]))
              .get();

      final mensa = await (select(
        mense,
      )..where((tbl) => tbl.id.equals(ordine.mensaId))).getSingleOrNull();

      risultati.add(
        OrdineCompleto(ordine: ordine, mensa: mensa, piatti: piatti),
      );
    }

    return risultati;
  }

  /// Ordini ricevuti da una mensa, dal ritiro più vicino al più lontano
  /// (prima per giorno, poi per orario). Per ogni ordine carica anche
  /// il cliente che lo ha effettuato e i piatti ordinati.
  Future<List<OrdineCompleto>> getOrdiniMensa(int mensaId) async {
    final ordiniList =
        await (select(ordini)
              // Gli ordini rifiutati spariscono dall'elenco.
              ..where(
                (tbl) =>
                    tbl.mensaId.equals(mensaId) &
                    tbl.stato.equals('Rifiutato').not(),
              )
              ..orderBy([
                (tbl) => OrderingTerm.asc(tbl.giornoRitiro),
                (tbl) => OrderingTerm.asc(tbl.orarioRitiro),
                (tbl) => OrderingTerm.asc(tbl.id),
              ]))
            .get();

    final risultati = <OrdineCompleto>[];

    for (final ordine in ordiniList) {
      final piatti =
          await (select(ordinePiatti)
                ..where((tbl) => tbl.ordineId.equals(ordine.id))
                ..orderBy([(tbl) => OrderingTerm.asc(tbl.id)]))
              .get();

      final utente = await (select(
        utenti,
      )..where((tbl) => tbl.id.equals(ordine.utenteId))).getSingleOrNull();

      risultati.add(
        OrdineCompleto(
          ordine: ordine,
          mensa: null,
          piatti: piatti,
          utente: utente,
        ),
      );
    }

    return risultati;
  }

  /// Aggiorna lo stato di un ordine ('Ricevuto' / 'Rifiutato' / ...).
  ///
  /// Quando l'ordine viene accettato per la prima volta (passa a
  /// 'Ricevuto'), le quantità disponibili dei piatti nel menù
  /// giornaliero vengono diminuite delle quantità ordinate: se una
  /// quantità arriva a 0 il piatto viene rimosso dal menù.
  Future<void> aggiornaStatoOrdine(int ordineId, String stato) async {
    await transaction(() async {
      final ordine =
          await (select(ordini)..where((tbl) => tbl.id.equals(ordineId)))
              .getSingleOrNull();

      if (ordine == null) return;

      // Decrementa solo al primo passaggio a 'Ricevuto' (accettazione),
      // così un aggiornamento ripetuto non sottrae due volte.
      if (stato == 'Ricevuto' && ordine.stato != 'Ricevuto') {
        final piatti =
            await (select(ordinePiatti)
                  ..where((tbl) => tbl.ordineId.equals(ordineId)))
                .get();

        for (final piatto in piatti) {
          await _diminuisciQuantitaDisponibile(
            mensaId: ordine.mensaId,
            pastoId: piatto.pastoId,
            quantitaOrdinata: piatto.quantita,
            dateCandidate: [_dataOggi(), _dataDi(ordine.giornoRitiro)],
          );
        }
      }

      await (update(ordini)..where((tbl) => tbl.id.equals(ordineId))).write(
        OrdiniCompanion(stato: Value(stato)),
      );
    });
  }

  /// Elimina definitivamente un ordine (testata + piatti associati).
  ///
  /// Usato dalla mensa quando l'utente ha già eliminato l'ordine
  /// dalla propria lista e la mensa conferma la cancellazione.
  Future<void> eliminaOrdine(int ordineId) async {
    await (delete(
      ordinePiatti,
    )..where((tbl) => tbl.ordineId.equals(ordineId))).go();

    await (delete(ordini)..where((tbl) => tbl.id.equals(ordineId))).go();
  }

  // ========================================================
  // UTENTI
  // ========================================================

  Future<UtentiData?> getUtenteById(int utenteId) {
    return (select(
      utenti,
    )..where((tbl) => tbl.id.equals(utenteId))).getSingleOrNull();
  }

  Future<void> aggiornaUtente({
    required int utenteId,
    required String nome,
    required String cognome,
    required String email,
    required String indirizzo,
    required String comune,
    required String provincia,
    required String password,
    required DateTime dataNascita,
  }) async {
    await (update(utenti)..where((tbl) => tbl.id.equals(utenteId))).write(
      UtentiCompanion(
        nome: Value(nome.trim()),
        cognome: Value(cognome.trim()),
        email: Value(email.trim()),
        indirizzo: Value(indirizzo.trim()),
        comune: Value(comune.trim()),
        provincia: Value(provincia.trim().toUpperCase()),
        password: Value(password),
        dataNascita: Value(dataNascita),
      ),
    );
  }

  Future<List<String>> getPreferenzeUtente(int utenteId) async {
    final query = select(preferenze).join([
      innerJoin(
        utentePreferenze,
        utentePreferenze.preferenzaId.equalsExp(preferenze.id),
      ),
    ]);

    query.where(utentePreferenze.utenteId.equals(utenteId));
    query.orderBy([
      OrderingTerm(expression: preferenze.nome, mode: OrderingMode.asc),
    ]);

    final rows = await query.get();
    return rows.map((row) => row.readTable(preferenze).nome).toList();
  }

  Future<Set<int>> getPreferenzeUtenteIds(int utenteId) async {
    final rows = await (select(
      utentePreferenze,
    )..where((tbl) => tbl.utenteId.equals(utenteId))).get();
    return rows.map((row) => row.preferenzaId).toSet();
  }

  Future<void> aggiornaPreferenzeUtente({
    required int utenteId,
    required Iterable<int> preferenzeIds,
  }) async {
    final idsSelezionati = preferenzeIds.toSet();
    if (idsSelezionati.length > preferenzePredefinite.length) {
      throw Exception('Puoi selezionare al massimo 6 preferenze.');
    }

    await transaction(() async {
      await (delete(
        utentePreferenze,
      )..where((tbl) => tbl.utenteId.equals(utenteId))).go();

      for (final preferenzaId in idsSelezionati) {
        await into(utentePreferenze).insert(
          UtentePreferenzeCompanion.insert(
            utenteId: utenteId,
            preferenzaId: preferenzaId,
          ),
        );
      }
    });
  }

  Future<List<String>> getAllergieUtente(int utenteId) async {
    final query = select(allergie).join([
      innerJoin(
        utenteAllergie,
        utenteAllergie.allergiaId.equalsExp(allergie.id),
      ),
    ]);

    query.where(utenteAllergie.utenteId.equals(utenteId));
    query.orderBy([
      OrderingTerm(expression: allergie.nome, mode: OrderingMode.asc),
    ]);

    final rows = await query.get();
    return rows.map((row) => row.readTable(allergie).nome).toList();
  }

  Future<Set<int>> getAllergieUtenteIds(int utenteId) async {
    final rows = await (select(
      utenteAllergie,
    )..where((tbl) => tbl.utenteId.equals(utenteId))).get();
    return rows.map((row) => row.allergiaId).toSet();
  }

  Future<void> aggiornaAllergieUtente({
    required int utenteId,
    required Iterable<int> allergieIds,
  }) async {
    final idsSelezionati = allergieIds.toSet();
    if (idsSelezionati.length > allergiePredefinite.length) {
      throw Exception('Puoi selezionare al massimo 14 allergie.');
    }

    await transaction(() async {
      await (delete(
        utenteAllergie,
      )..where((tbl) => tbl.utenteId.equals(utenteId))).go();

      for (final allergiaId in idsSelezionati) {
        await into(utenteAllergie).insert(
          UtenteAllergieCompanion.insert(
            utenteId: utenteId,
            allergiaId: allergiaId,
          ),
        );
      }
    });
  }

  Future<int> registerUser({
    required String nome,
    required String cognome,
    required String email,
    required String indirizzo,
    required String comune,
    required String provincia,
    required String password,
    required DateTime dataNascita,
    required List<String> allergieSelezionate,
    required List<String> preferenzeSelezionate,
  }) async {
    final allergieUniche = allergieSelezionate.toSet().toList();

    final preferenzeUniche = preferenzeSelezionate.toSet().toList();

    if (allergieUniche.length > 14) {
      throw Exception('Puoi selezionare al massimo 14 allergie.');
    }

    if (preferenzeUniche.length > 6) {
      throw Exception('Puoi selezionare al massimo 6 preferenze.');
    }

    return transaction(() async {
      final utenteId = await into(utenti).insert(
        UtentiCompanion.insert(
          nome: nome.trim(),
          cognome: cognome.trim(),
          indirizzo: indirizzo.trim(),
          comune: comune.trim(),
          provincia: provincia.trim(),
          email: email.trim(),
          password: password,
          dataNascita: dataNascita,
        ),
      );

      for (final nomeAllergia in allergieUniche) {
        final allergia = await (select(
          allergie,
        )..where((tbl) => tbl.nome.equals(nomeAllergia))).getSingleOrNull();

        if (allergia != null) {
          await into(utenteAllergie).insert(
            UtenteAllergieCompanion.insert(
              utenteId: utenteId,
              allergiaId: allergia.id,
            ),
          );
        }
      }

      for (final nomePreferenza in preferenzeUniche) {
        final preferenza = await (select(
          preferenze,
        )..where((tbl) => tbl.nome.equals(nomePreferenza))).getSingleOrNull();

        if (preferenza != null) {
          await into(utentePreferenze).insert(
            UtentePreferenzeCompanion.insert(
              utenteId: utenteId,
              preferenzaId: preferenza.id,
            ),
          );
        }
      }

      return utenteId;
    });
  }

  // ========================================================
  // LOGIN UTENTE
  // ========================================================

  Future<UtentiData?> loginUser(String email, String password) {
    return (select(utenti)..where(
          (tbl) =>
              tbl.email.equals(email.trim()) & tbl.password.equals(password),
        ))
        .getSingleOrNull();
  }
}
