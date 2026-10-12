// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PastiTable extends Pasti with TableInfo<$PastiTable, PastiData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PastiTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _partitaIvaMeta = const VerificationMeta(
    'partitaIva',
  );
  @override
  late final GeneratedColumn<String> partitaIva = GeneratedColumn<String>(
    'partita_iva',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
    'nome',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoriaMeta = const VerificationMeta(
    'categoria',
  );
  @override
  late final GeneratedColumn<String> categoria = GeneratedColumn<String>(
    'categoria',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _prezzoMeta = const VerificationMeta('prezzo');
  @override
  late final GeneratedColumn<double> prezzo = GeneratedColumn<double>(
    'prezzo',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descrizioneMeta = const VerificationMeta(
    'descrizione',
  );
  @override
  late final GeneratedColumn<String> descrizione = GeneratedColumn<String>(
    'descrizione',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _immagineMeta = const VerificationMeta(
    'immagine',
  );
  @override
  late final GeneratedColumn<Uint8List> immagine = GeneratedColumn<Uint8List>(
    'immagine',
    aliasedName,
    true,
    type: DriftSqlType.blob,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    partitaIva,
    nome,
    categoria,
    prezzo,
    imagePath,
    descrizione,
    immagine,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pasti';
  @override
  VerificationContext validateIntegrity(
    Insertable<PastiData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('partita_iva')) {
      context.handle(
        _partitaIvaMeta,
        partitaIva.isAcceptableOrUnknown(data['partita_iva']!, _partitaIvaMeta),
      );
    }
    if (data.containsKey('nome')) {
      context.handle(
        _nomeMeta,
        nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta),
      );
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('categoria')) {
      context.handle(
        _categoriaMeta,
        categoria.isAcceptableOrUnknown(data['categoria']!, _categoriaMeta),
      );
    } else if (isInserting) {
      context.missing(_categoriaMeta);
    }
    if (data.containsKey('prezzo')) {
      context.handle(
        _prezzoMeta,
        prezzo.isAcceptableOrUnknown(data['prezzo']!, _prezzoMeta),
      );
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    }
    if (data.containsKey('descrizione')) {
      context.handle(
        _descrizioneMeta,
        descrizione.isAcceptableOrUnknown(
          data['descrizione']!,
          _descrizioneMeta,
        ),
      );
    }
    if (data.containsKey('immagine')) {
      context.handle(
        _immagineMeta,
        immagine.isAcceptableOrUnknown(data['immagine']!, _immagineMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PastiData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PastiData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      partitaIva: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}partita_iva'],
      ),
      nome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nome'],
      )!,
      categoria: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}categoria'],
      )!,
      prezzo: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}prezzo'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      ),
      descrizione: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descrizione'],
      )!,
      immagine: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}immagine'],
      ),
    );
  }

  @override
  $PastiTable createAlias(String alias) {
    return $PastiTable(attachedDatabase, alias);
  }
}

class PastiData extends DataClass implements Insertable<PastiData> {
  final int id;
  final String? partitaIva;
  final String nome;
  final String categoria;
  final double prezzo;
  final String? imagePath;
  final String descrizione;
  final Uint8List? immagine;
  const PastiData({
    required this.id,
    this.partitaIva,
    required this.nome,
    required this.categoria,
    required this.prezzo,
    this.imagePath,
    required this.descrizione,
    this.immagine,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || partitaIva != null) {
      map['partita_iva'] = Variable<String>(partitaIva);
    }
    map['nome'] = Variable<String>(nome);
    map['categoria'] = Variable<String>(categoria);
    map['prezzo'] = Variable<double>(prezzo);
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    map['descrizione'] = Variable<String>(descrizione);
    if (!nullToAbsent || immagine != null) {
      map['immagine'] = Variable<Uint8List>(immagine);
    }
    return map;
  }

  PastiCompanion toCompanion(bool nullToAbsent) {
    return PastiCompanion(
      id: Value(id),
      partitaIva: partitaIva == null && nullToAbsent
          ? const Value.absent()
          : Value(partitaIva),
      nome: Value(nome),
      categoria: Value(categoria),
      prezzo: Value(prezzo),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      descrizione: Value(descrizione),
      immagine: immagine == null && nullToAbsent
          ? const Value.absent()
          : Value(immagine),
    );
  }

  factory PastiData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PastiData(
      id: serializer.fromJson<int>(json['id']),
      partitaIva: serializer.fromJson<String?>(json['partitaIva']),
      nome: serializer.fromJson<String>(json['nome']),
      categoria: serializer.fromJson<String>(json['categoria']),
      prezzo: serializer.fromJson<double>(json['prezzo']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      descrizione: serializer.fromJson<String>(json['descrizione']),
      immagine: serializer.fromJson<Uint8List?>(json['immagine']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'partitaIva': serializer.toJson<String?>(partitaIva),
      'nome': serializer.toJson<String>(nome),
      'categoria': serializer.toJson<String>(categoria),
      'prezzo': serializer.toJson<double>(prezzo),
      'imagePath': serializer.toJson<String?>(imagePath),
      'descrizione': serializer.toJson<String>(descrizione),
      'immagine': serializer.toJson<Uint8List?>(immagine),
    };
  }

  PastiData copyWith({
    int? id,
    Value<String?> partitaIva = const Value.absent(),
    String? nome,
    String? categoria,
    double? prezzo,
    Value<String?> imagePath = const Value.absent(),
    String? descrizione,
    Value<Uint8List?> immagine = const Value.absent(),
  }) => PastiData(
    id: id ?? this.id,
    partitaIva: partitaIva.present ? partitaIva.value : this.partitaIva,
    nome: nome ?? this.nome,
    categoria: categoria ?? this.categoria,
    prezzo: prezzo ?? this.prezzo,
    imagePath: imagePath.present ? imagePath.value : this.imagePath,
    descrizione: descrizione ?? this.descrizione,
    immagine: immagine.present ? immagine.value : this.immagine,
  );
  PastiData copyWithCompanion(PastiCompanion data) {
    return PastiData(
      id: data.id.present ? data.id.value : this.id,
      partitaIva: data.partitaIva.present
          ? data.partitaIva.value
          : this.partitaIva,
      nome: data.nome.present ? data.nome.value : this.nome,
      categoria: data.categoria.present ? data.categoria.value : this.categoria,
      prezzo: data.prezzo.present ? data.prezzo.value : this.prezzo,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      descrizione: data.descrizione.present
          ? data.descrizione.value
          : this.descrizione,
      immagine: data.immagine.present ? data.immagine.value : this.immagine,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PastiData(')
          ..write('id: $id, ')
          ..write('partitaIva: $partitaIva, ')
          ..write('nome: $nome, ')
          ..write('categoria: $categoria, ')
          ..write('prezzo: $prezzo, ')
          ..write('imagePath: $imagePath, ')
          ..write('descrizione: $descrizione, ')
          ..write('immagine: $immagine')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    partitaIva,
    nome,
    categoria,
    prezzo,
    imagePath,
    descrizione,
    $driftBlobEquality.hash(immagine),
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PastiData &&
          other.id == this.id &&
          other.partitaIva == this.partitaIva &&
          other.nome == this.nome &&
          other.categoria == this.categoria &&
          other.prezzo == this.prezzo &&
          other.imagePath == this.imagePath &&
          other.descrizione == this.descrizione &&
          $driftBlobEquality.equals(other.immagine, this.immagine));
}

class PastiCompanion extends UpdateCompanion<PastiData> {
  final Value<int> id;
  final Value<String?> partitaIva;
  final Value<String> nome;
  final Value<String> categoria;
  final Value<double> prezzo;
  final Value<String?> imagePath;
  final Value<String> descrizione;
  final Value<Uint8List?> immagine;
  const PastiCompanion({
    this.id = const Value.absent(),
    this.partitaIva = const Value.absent(),
    this.nome = const Value.absent(),
    this.categoria = const Value.absent(),
    this.prezzo = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.descrizione = const Value.absent(),
    this.immagine = const Value.absent(),
  });
  PastiCompanion.insert({
    this.id = const Value.absent(),
    this.partitaIva = const Value.absent(),
    required String nome,
    required String categoria,
    this.prezzo = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.descrizione = const Value.absent(),
    this.immagine = const Value.absent(),
  }) : nome = Value(nome),
       categoria = Value(categoria);
  static Insertable<PastiData> custom({
    Expression<int>? id,
    Expression<String>? partitaIva,
    Expression<String>? nome,
    Expression<String>? categoria,
    Expression<double>? prezzo,
    Expression<String>? imagePath,
    Expression<String>? descrizione,
    Expression<Uint8List>? immagine,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (partitaIva != null) 'partita_iva': partitaIva,
      if (nome != null) 'nome': nome,
      if (categoria != null) 'categoria': categoria,
      if (prezzo != null) 'prezzo': prezzo,
      if (imagePath != null) 'image_path': imagePath,
      if (descrizione != null) 'descrizione': descrizione,
      if (immagine != null) 'immagine': immagine,
    });
  }

  PastiCompanion copyWith({
    Value<int>? id,
    Value<String?>? partitaIva,
    Value<String>? nome,
    Value<String>? categoria,
    Value<double>? prezzo,
    Value<String?>? imagePath,
    Value<String>? descrizione,
    Value<Uint8List?>? immagine,
  }) {
    return PastiCompanion(
      id: id ?? this.id,
      partitaIva: partitaIva ?? this.partitaIva,
      nome: nome ?? this.nome,
      categoria: categoria ?? this.categoria,
      prezzo: prezzo ?? this.prezzo,
      imagePath: imagePath ?? this.imagePath,
      descrizione: descrizione ?? this.descrizione,
      immagine: immagine ?? this.immagine,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (partitaIva.present) {
      map['partita_iva'] = Variable<String>(partitaIva.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (categoria.present) {
      map['categoria'] = Variable<String>(categoria.value);
    }
    if (prezzo.present) {
      map['prezzo'] = Variable<double>(prezzo.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (descrizione.present) {
      map['descrizione'] = Variable<String>(descrizione.value);
    }
    if (immagine.present) {
      map['immagine'] = Variable<Uint8List>(immagine.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PastiCompanion(')
          ..write('id: $id, ')
          ..write('partitaIva: $partitaIva, ')
          ..write('nome: $nome, ')
          ..write('categoria: $categoria, ')
          ..write('prezzo: $prezzo, ')
          ..write('imagePath: $imagePath, ')
          ..write('descrizione: $descrizione, ')
          ..write('immagine: $immagine')
          ..write(')'))
        .toString();
  }
}

class $UtentiTable extends Utenti with TableInfo<$UtentiTable, UtentiData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UtentiTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
    'nome',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cognomeMeta = const VerificationMeta(
    'cognome',
  );
  @override
  late final GeneratedColumn<String> cognome = GeneratedColumn<String>(
    'cognome',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _indirizzoMeta = const VerificationMeta(
    'indirizzo',
  );
  @override
  late final GeneratedColumn<String> indirizzo = GeneratedColumn<String>(
    'indirizzo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _comuneMeta = const VerificationMeta('comune');
  @override
  late final GeneratedColumn<String> comune = GeneratedColumn<String>(
    'comune',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _provinciaMeta = const VerificationMeta(
    'provincia',
  );
  @override
  late final GeneratedColumn<String> provincia = GeneratedColumn<String>(
    'provincia',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _passwordMeta = const VerificationMeta(
    'password',
  );
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
    'password',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dataNascitaMeta = const VerificationMeta(
    'dataNascita',
  );
  @override
  late final GeneratedColumn<DateTime> dataNascita = GeneratedColumn<DateTime>(
    'data_nascita',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nome,
    cognome,
    indirizzo,
    comune,
    provincia,
    email,
    password,
    dataNascita,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'utenti';
  @override
  VerificationContext validateIntegrity(
    Insertable<UtentiData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
        _nomeMeta,
        nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta),
      );
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('cognome')) {
      context.handle(
        _cognomeMeta,
        cognome.isAcceptableOrUnknown(data['cognome']!, _cognomeMeta),
      );
    } else if (isInserting) {
      context.missing(_cognomeMeta);
    }
    if (data.containsKey('indirizzo')) {
      context.handle(
        _indirizzoMeta,
        indirizzo.isAcceptableOrUnknown(data['indirizzo']!, _indirizzoMeta),
      );
    } else if (isInserting) {
      context.missing(_indirizzoMeta);
    }
    if (data.containsKey('comune')) {
      context.handle(
        _comuneMeta,
        comune.isAcceptableOrUnknown(data['comune']!, _comuneMeta),
      );
    } else if (isInserting) {
      context.missing(_comuneMeta);
    }
    if (data.containsKey('provincia')) {
      context.handle(
        _provinciaMeta,
        provincia.isAcceptableOrUnknown(data['provincia']!, _provinciaMeta),
      );
    } else if (isInserting) {
      context.missing(_provinciaMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password')) {
      context.handle(
        _passwordMeta,
        password.isAcceptableOrUnknown(data['password']!, _passwordMeta),
      );
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('data_nascita')) {
      context.handle(
        _dataNascitaMeta,
        dataNascita.isAcceptableOrUnknown(
          data['data_nascita']!,
          _dataNascitaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dataNascitaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UtentiData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UtentiData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nome'],
      )!,
      cognome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cognome'],
      )!,
      indirizzo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}indirizzo'],
      )!,
      comune: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comune'],
      )!,
      provincia: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provincia'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      password: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password'],
      )!,
      dataNascita: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}data_nascita'],
      )!,
    );
  }

  @override
  $UtentiTable createAlias(String alias) {
    return $UtentiTable(attachedDatabase, alias);
  }
}

class UtentiData extends DataClass implements Insertable<UtentiData> {
  final int id;
  final String nome;
  final String cognome;
  final String indirizzo;
  final String comune;
  final String provincia;
  final String email;
  final String password;
  final DateTime dataNascita;
  const UtentiData({
    required this.id,
    required this.nome,
    required this.cognome,
    required this.indirizzo,
    required this.comune,
    required this.provincia,
    required this.email,
    required this.password,
    required this.dataNascita,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nome'] = Variable<String>(nome);
    map['cognome'] = Variable<String>(cognome);
    map['indirizzo'] = Variable<String>(indirizzo);
    map['comune'] = Variable<String>(comune);
    map['provincia'] = Variable<String>(provincia);
    map['email'] = Variable<String>(email);
    map['password'] = Variable<String>(password);
    map['data_nascita'] = Variable<DateTime>(dataNascita);
    return map;
  }

  UtentiCompanion toCompanion(bool nullToAbsent) {
    return UtentiCompanion(
      id: Value(id),
      nome: Value(nome),
      cognome: Value(cognome),
      indirizzo: Value(indirizzo),
      comune: Value(comune),
      provincia: Value(provincia),
      email: Value(email),
      password: Value(password),
      dataNascita: Value(dataNascita),
    );
  }

  factory UtentiData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UtentiData(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      cognome: serializer.fromJson<String>(json['cognome']),
      indirizzo: serializer.fromJson<String>(json['indirizzo']),
      comune: serializer.fromJson<String>(json['comune']),
      provincia: serializer.fromJson<String>(json['provincia']),
      email: serializer.fromJson<String>(json['email']),
      password: serializer.fromJson<String>(json['password']),
      dataNascita: serializer.fromJson<DateTime>(json['dataNascita']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nome': serializer.toJson<String>(nome),
      'cognome': serializer.toJson<String>(cognome),
      'indirizzo': serializer.toJson<String>(indirizzo),
      'comune': serializer.toJson<String>(comune),
      'provincia': serializer.toJson<String>(provincia),
      'email': serializer.toJson<String>(email),
      'password': serializer.toJson<String>(password),
      'dataNascita': serializer.toJson<DateTime>(dataNascita),
    };
  }

  UtentiData copyWith({
    int? id,
    String? nome,
    String? cognome,
    String? indirizzo,
    String? comune,
    String? provincia,
    String? email,
    String? password,
    DateTime? dataNascita,
  }) => UtentiData(
    id: id ?? this.id,
    nome: nome ?? this.nome,
    cognome: cognome ?? this.cognome,
    indirizzo: indirizzo ?? this.indirizzo,
    comune: comune ?? this.comune,
    provincia: provincia ?? this.provincia,
    email: email ?? this.email,
    password: password ?? this.password,
    dataNascita: dataNascita ?? this.dataNascita,
  );
  UtentiData copyWithCompanion(UtentiCompanion data) {
    return UtentiData(
      id: data.id.present ? data.id.value : this.id,
      nome: data.nome.present ? data.nome.value : this.nome,
      cognome: data.cognome.present ? data.cognome.value : this.cognome,
      indirizzo: data.indirizzo.present ? data.indirizzo.value : this.indirizzo,
      comune: data.comune.present ? data.comune.value : this.comune,
      provincia: data.provincia.present ? data.provincia.value : this.provincia,
      email: data.email.present ? data.email.value : this.email,
      password: data.password.present ? data.password.value : this.password,
      dataNascita: data.dataNascita.present
          ? data.dataNascita.value
          : this.dataNascita,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UtentiData(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('cognome: $cognome, ')
          ..write('indirizzo: $indirizzo, ')
          ..write('comune: $comune, ')
          ..write('provincia: $provincia, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('dataNascita: $dataNascita')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nome,
    cognome,
    indirizzo,
    comune,
    provincia,
    email,
    password,
    dataNascita,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UtentiData &&
          other.id == this.id &&
          other.nome == this.nome &&
          other.cognome == this.cognome &&
          other.indirizzo == this.indirizzo &&
          other.comune == this.comune &&
          other.provincia == this.provincia &&
          other.email == this.email &&
          other.password == this.password &&
          other.dataNascita == this.dataNascita);
}

class UtentiCompanion extends UpdateCompanion<UtentiData> {
  final Value<int> id;
  final Value<String> nome;
  final Value<String> cognome;
  final Value<String> indirizzo;
  final Value<String> comune;
  final Value<String> provincia;
  final Value<String> email;
  final Value<String> password;
  final Value<DateTime> dataNascita;
  const UtentiCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.cognome = const Value.absent(),
    this.indirizzo = const Value.absent(),
    this.comune = const Value.absent(),
    this.provincia = const Value.absent(),
    this.email = const Value.absent(),
    this.password = const Value.absent(),
    this.dataNascita = const Value.absent(),
  });
  UtentiCompanion.insert({
    this.id = const Value.absent(),
    required String nome,
    required String cognome,
    required String indirizzo,
    required String comune,
    required String provincia,
    required String email,
    required String password,
    required DateTime dataNascita,
  }) : nome = Value(nome),
       cognome = Value(cognome),
       indirizzo = Value(indirizzo),
       comune = Value(comune),
       provincia = Value(provincia),
       email = Value(email),
       password = Value(password),
       dataNascita = Value(dataNascita);
  static Insertable<UtentiData> custom({
    Expression<int>? id,
    Expression<String>? nome,
    Expression<String>? cognome,
    Expression<String>? indirizzo,
    Expression<String>? comune,
    Expression<String>? provincia,
    Expression<String>? email,
    Expression<String>? password,
    Expression<DateTime>? dataNascita,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nome != null) 'nome': nome,
      if (cognome != null) 'cognome': cognome,
      if (indirizzo != null) 'indirizzo': indirizzo,
      if (comune != null) 'comune': comune,
      if (provincia != null) 'provincia': provincia,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (dataNascita != null) 'data_nascita': dataNascita,
    });
  }

  UtentiCompanion copyWith({
    Value<int>? id,
    Value<String>? nome,
    Value<String>? cognome,
    Value<String>? indirizzo,
    Value<String>? comune,
    Value<String>? provincia,
    Value<String>? email,
    Value<String>? password,
    Value<DateTime>? dataNascita,
  }) {
    return UtentiCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      cognome: cognome ?? this.cognome,
      indirizzo: indirizzo ?? this.indirizzo,
      comune: comune ?? this.comune,
      provincia: provincia ?? this.provincia,
      email: email ?? this.email,
      password: password ?? this.password,
      dataNascita: dataNascita ?? this.dataNascita,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (cognome.present) {
      map['cognome'] = Variable<String>(cognome.value);
    }
    if (indirizzo.present) {
      map['indirizzo'] = Variable<String>(indirizzo.value);
    }
    if (comune.present) {
      map['comune'] = Variable<String>(comune.value);
    }
    if (provincia.present) {
      map['provincia'] = Variable<String>(provincia.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (dataNascita.present) {
      map['data_nascita'] = Variable<DateTime>(dataNascita.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UtentiCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('cognome: $cognome, ')
          ..write('indirizzo: $indirizzo, ')
          ..write('comune: $comune, ')
          ..write('provincia: $provincia, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('dataNascita: $dataNascita')
          ..write(')'))
        .toString();
  }
}

class $AllergieTable extends Allergie
    with TableInfo<$AllergieTable, AllergieData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AllergieTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
    'nome',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, nome];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'allergie';
  @override
  VerificationContext validateIntegrity(
    Insertable<AllergieData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
        _nomeMeta,
        nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta),
      );
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AllergieData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AllergieData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nome'],
      )!,
    );
  }

  @override
  $AllergieTable createAlias(String alias) {
    return $AllergieTable(attachedDatabase, alias);
  }
}

class AllergieData extends DataClass implements Insertable<AllergieData> {
  final int id;
  final String nome;
  const AllergieData({required this.id, required this.nome});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nome'] = Variable<String>(nome);
    return map;
  }

  AllergieCompanion toCompanion(bool nullToAbsent) {
    return AllergieCompanion(id: Value(id), nome: Value(nome));
  }

  factory AllergieData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AllergieData(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nome': serializer.toJson<String>(nome),
    };
  }

  AllergieData copyWith({int? id, String? nome}) =>
      AllergieData(id: id ?? this.id, nome: nome ?? this.nome);
  AllergieData copyWithCompanion(AllergieCompanion data) {
    return AllergieData(
      id: data.id.present ? data.id.value : this.id,
      nome: data.nome.present ? data.nome.value : this.nome,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AllergieData(')
          ..write('id: $id, ')
          ..write('nome: $nome')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nome);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AllergieData && other.id == this.id && other.nome == this.nome);
}

class AllergieCompanion extends UpdateCompanion<AllergieData> {
  final Value<int> id;
  final Value<String> nome;
  const AllergieCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
  });
  AllergieCompanion.insert({
    this.id = const Value.absent(),
    required String nome,
  }) : nome = Value(nome);
  static Insertable<AllergieData> custom({
    Expression<int>? id,
    Expression<String>? nome,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nome != null) 'nome': nome,
    });
  }

  AllergieCompanion copyWith({Value<int>? id, Value<String>? nome}) {
    return AllergieCompanion(id: id ?? this.id, nome: nome ?? this.nome);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AllergieCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome')
          ..write(')'))
        .toString();
  }
}

class $PreferenzeTable extends Preferenze
    with TableInfo<$PreferenzeTable, PreferenzeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PreferenzeTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
    'nome',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, nome];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'preferenze';
  @override
  VerificationContext validateIntegrity(
    Insertable<PreferenzeData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
        _nomeMeta,
        nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta),
      );
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PreferenzeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PreferenzeData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nome'],
      )!,
    );
  }

  @override
  $PreferenzeTable createAlias(String alias) {
    return $PreferenzeTable(attachedDatabase, alias);
  }
}

class PreferenzeData extends DataClass implements Insertable<PreferenzeData> {
  final int id;
  final String nome;
  const PreferenzeData({required this.id, required this.nome});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nome'] = Variable<String>(nome);
    return map;
  }

  PreferenzeCompanion toCompanion(bool nullToAbsent) {
    return PreferenzeCompanion(id: Value(id), nome: Value(nome));
  }

  factory PreferenzeData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PreferenzeData(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nome': serializer.toJson<String>(nome),
    };
  }

  PreferenzeData copyWith({int? id, String? nome}) =>
      PreferenzeData(id: id ?? this.id, nome: nome ?? this.nome);
  PreferenzeData copyWithCompanion(PreferenzeCompanion data) {
    return PreferenzeData(
      id: data.id.present ? data.id.value : this.id,
      nome: data.nome.present ? data.nome.value : this.nome,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PreferenzeData(')
          ..write('id: $id, ')
          ..write('nome: $nome')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nome);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PreferenzeData &&
          other.id == this.id &&
          other.nome == this.nome);
}

class PreferenzeCompanion extends UpdateCompanion<PreferenzeData> {
  final Value<int> id;
  final Value<String> nome;
  const PreferenzeCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
  });
  PreferenzeCompanion.insert({
    this.id = const Value.absent(),
    required String nome,
  }) : nome = Value(nome);
  static Insertable<PreferenzeData> custom({
    Expression<int>? id,
    Expression<String>? nome,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nome != null) 'nome': nome,
    });
  }

  PreferenzeCompanion copyWith({Value<int>? id, Value<String>? nome}) {
    return PreferenzeCompanion(id: id ?? this.id, nome: nome ?? this.nome);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PreferenzeCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome')
          ..write(')'))
        .toString();
  }
}

class $UtenteAllergieTable extends UtenteAllergie
    with TableInfo<$UtenteAllergieTable, UtenteAllergieData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UtenteAllergieTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _utenteIdMeta = const VerificationMeta(
    'utenteId',
  );
  @override
  late final GeneratedColumn<int> utenteId = GeneratedColumn<int>(
    'utente_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES utenti (id)',
    ),
  );
  static const VerificationMeta _allergiaIdMeta = const VerificationMeta(
    'allergiaId',
  );
  @override
  late final GeneratedColumn<int> allergiaId = GeneratedColumn<int>(
    'allergia_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES allergie (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [utenteId, allergiaId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'utente_allergie';
  @override
  VerificationContext validateIntegrity(
    Insertable<UtenteAllergieData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('utente_id')) {
      context.handle(
        _utenteIdMeta,
        utenteId.isAcceptableOrUnknown(data['utente_id']!, _utenteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_utenteIdMeta);
    }
    if (data.containsKey('allergia_id')) {
      context.handle(
        _allergiaIdMeta,
        allergiaId.isAcceptableOrUnknown(data['allergia_id']!, _allergiaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_allergiaIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {utenteId, allergiaId};
  @override
  UtenteAllergieData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UtenteAllergieData(
      utenteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}utente_id'],
      )!,
      allergiaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}allergia_id'],
      )!,
    );
  }

  @override
  $UtenteAllergieTable createAlias(String alias) {
    return $UtenteAllergieTable(attachedDatabase, alias);
  }
}

class UtenteAllergieData extends DataClass
    implements Insertable<UtenteAllergieData> {
  final int utenteId;
  final int allergiaId;
  const UtenteAllergieData({required this.utenteId, required this.allergiaId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['utente_id'] = Variable<int>(utenteId);
    map['allergia_id'] = Variable<int>(allergiaId);
    return map;
  }

  UtenteAllergieCompanion toCompanion(bool nullToAbsent) {
    return UtenteAllergieCompanion(
      utenteId: Value(utenteId),
      allergiaId: Value(allergiaId),
    );
  }

  factory UtenteAllergieData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UtenteAllergieData(
      utenteId: serializer.fromJson<int>(json['utenteId']),
      allergiaId: serializer.fromJson<int>(json['allergiaId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'utenteId': serializer.toJson<int>(utenteId),
      'allergiaId': serializer.toJson<int>(allergiaId),
    };
  }

  UtenteAllergieData copyWith({int? utenteId, int? allergiaId}) =>
      UtenteAllergieData(
        utenteId: utenteId ?? this.utenteId,
        allergiaId: allergiaId ?? this.allergiaId,
      );
  UtenteAllergieData copyWithCompanion(UtenteAllergieCompanion data) {
    return UtenteAllergieData(
      utenteId: data.utenteId.present ? data.utenteId.value : this.utenteId,
      allergiaId: data.allergiaId.present
          ? data.allergiaId.value
          : this.allergiaId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UtenteAllergieData(')
          ..write('utenteId: $utenteId, ')
          ..write('allergiaId: $allergiaId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(utenteId, allergiaId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UtenteAllergieData &&
          other.utenteId == this.utenteId &&
          other.allergiaId == this.allergiaId);
}

class UtenteAllergieCompanion extends UpdateCompanion<UtenteAllergieData> {
  final Value<int> utenteId;
  final Value<int> allergiaId;
  final Value<int> rowid;
  const UtenteAllergieCompanion({
    this.utenteId = const Value.absent(),
    this.allergiaId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UtenteAllergieCompanion.insert({
    required int utenteId,
    required int allergiaId,
    this.rowid = const Value.absent(),
  }) : utenteId = Value(utenteId),
       allergiaId = Value(allergiaId);
  static Insertable<UtenteAllergieData> custom({
    Expression<int>? utenteId,
    Expression<int>? allergiaId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (utenteId != null) 'utente_id': utenteId,
      if (allergiaId != null) 'allergia_id': allergiaId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UtenteAllergieCompanion copyWith({
    Value<int>? utenteId,
    Value<int>? allergiaId,
    Value<int>? rowid,
  }) {
    return UtenteAllergieCompanion(
      utenteId: utenteId ?? this.utenteId,
      allergiaId: allergiaId ?? this.allergiaId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (utenteId.present) {
      map['utente_id'] = Variable<int>(utenteId.value);
    }
    if (allergiaId.present) {
      map['allergia_id'] = Variable<int>(allergiaId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UtenteAllergieCompanion(')
          ..write('utenteId: $utenteId, ')
          ..write('allergiaId: $allergiaId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UtentePreferenzeTable extends UtentePreferenze
    with TableInfo<$UtentePreferenzeTable, UtentePreferenzeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UtentePreferenzeTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _utenteIdMeta = const VerificationMeta(
    'utenteId',
  );
  @override
  late final GeneratedColumn<int> utenteId = GeneratedColumn<int>(
    'utente_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES utenti (id)',
    ),
  );
  static const VerificationMeta _preferenzaIdMeta = const VerificationMeta(
    'preferenzaId',
  );
  @override
  late final GeneratedColumn<int> preferenzaId = GeneratedColumn<int>(
    'preferenza_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES preferenze (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [utenteId, preferenzaId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'utente_preferenze';
  @override
  VerificationContext validateIntegrity(
    Insertable<UtentePreferenzeData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('utente_id')) {
      context.handle(
        _utenteIdMeta,
        utenteId.isAcceptableOrUnknown(data['utente_id']!, _utenteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_utenteIdMeta);
    }
    if (data.containsKey('preferenza_id')) {
      context.handle(
        _preferenzaIdMeta,
        preferenzaId.isAcceptableOrUnknown(
          data['preferenza_id']!,
          _preferenzaIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_preferenzaIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {utenteId, preferenzaId};
  @override
  UtentePreferenzeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UtentePreferenzeData(
      utenteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}utente_id'],
      )!,
      preferenzaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}preferenza_id'],
      )!,
    );
  }

  @override
  $UtentePreferenzeTable createAlias(String alias) {
    return $UtentePreferenzeTable(attachedDatabase, alias);
  }
}

class UtentePreferenzeData extends DataClass
    implements Insertable<UtentePreferenzeData> {
  final int utenteId;
  final int preferenzaId;
  const UtentePreferenzeData({
    required this.utenteId,
    required this.preferenzaId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['utente_id'] = Variable<int>(utenteId);
    map['preferenza_id'] = Variable<int>(preferenzaId);
    return map;
  }

  UtentePreferenzeCompanion toCompanion(bool nullToAbsent) {
    return UtentePreferenzeCompanion(
      utenteId: Value(utenteId),
      preferenzaId: Value(preferenzaId),
    );
  }

  factory UtentePreferenzeData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UtentePreferenzeData(
      utenteId: serializer.fromJson<int>(json['utenteId']),
      preferenzaId: serializer.fromJson<int>(json['preferenzaId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'utenteId': serializer.toJson<int>(utenteId),
      'preferenzaId': serializer.toJson<int>(preferenzaId),
    };
  }

  UtentePreferenzeData copyWith({int? utenteId, int? preferenzaId}) =>
      UtentePreferenzeData(
        utenteId: utenteId ?? this.utenteId,
        preferenzaId: preferenzaId ?? this.preferenzaId,
      );
  UtentePreferenzeData copyWithCompanion(UtentePreferenzeCompanion data) {
    return UtentePreferenzeData(
      utenteId: data.utenteId.present ? data.utenteId.value : this.utenteId,
      preferenzaId: data.preferenzaId.present
          ? data.preferenzaId.value
          : this.preferenzaId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UtentePreferenzeData(')
          ..write('utenteId: $utenteId, ')
          ..write('preferenzaId: $preferenzaId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(utenteId, preferenzaId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UtentePreferenzeData &&
          other.utenteId == this.utenteId &&
          other.preferenzaId == this.preferenzaId);
}

class UtentePreferenzeCompanion extends UpdateCompanion<UtentePreferenzeData> {
  final Value<int> utenteId;
  final Value<int> preferenzaId;
  final Value<int> rowid;
  const UtentePreferenzeCompanion({
    this.utenteId = const Value.absent(),
    this.preferenzaId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UtentePreferenzeCompanion.insert({
    required int utenteId,
    required int preferenzaId,
    this.rowid = const Value.absent(),
  }) : utenteId = Value(utenteId),
       preferenzaId = Value(preferenzaId);
  static Insertable<UtentePreferenzeData> custom({
    Expression<int>? utenteId,
    Expression<int>? preferenzaId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (utenteId != null) 'utente_id': utenteId,
      if (preferenzaId != null) 'preferenza_id': preferenzaId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UtentePreferenzeCompanion copyWith({
    Value<int>? utenteId,
    Value<int>? preferenzaId,
    Value<int>? rowid,
  }) {
    return UtentePreferenzeCompanion(
      utenteId: utenteId ?? this.utenteId,
      preferenzaId: preferenzaId ?? this.preferenzaId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (utenteId.present) {
      map['utente_id'] = Variable<int>(utenteId.value);
    }
    if (preferenzaId.present) {
      map['preferenza_id'] = Variable<int>(preferenzaId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UtentePreferenzeCompanion(')
          ..write('utenteId: $utenteId, ')
          ..write('preferenzaId: $preferenzaId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GestoriTable extends Gestori with TableInfo<$GestoriTable, GestoriData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GestoriTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _passwordMeta = const VerificationMeta(
    'password',
  );
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
    'password',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, email, password];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gestori';
  @override
  VerificationContext validateIntegrity(
    Insertable<GestoriData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password')) {
      context.handle(
        _passwordMeta,
        password.isAcceptableOrUnknown(data['password']!, _passwordMeta),
      );
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GestoriData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GestoriData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      password: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password'],
      )!,
    );
  }

  @override
  $GestoriTable createAlias(String alias) {
    return $GestoriTable(attachedDatabase, alias);
  }
}

class GestoriData extends DataClass implements Insertable<GestoriData> {
  final int id;
  final String email;
  final String password;
  const GestoriData({
    required this.id,
    required this.email,
    required this.password,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['email'] = Variable<String>(email);
    map['password'] = Variable<String>(password);
    return map;
  }

  GestoriCompanion toCompanion(bool nullToAbsent) {
    return GestoriCompanion(
      id: Value(id),
      email: Value(email),
      password: Value(password),
    );
  }

  factory GestoriData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GestoriData(
      id: serializer.fromJson<int>(json['id']),
      email: serializer.fromJson<String>(json['email']),
      password: serializer.fromJson<String>(json['password']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'email': serializer.toJson<String>(email),
      'password': serializer.toJson<String>(password),
    };
  }

  GestoriData copyWith({int? id, String? email, String? password}) =>
      GestoriData(
        id: id ?? this.id,
        email: email ?? this.email,
        password: password ?? this.password,
      );
  GestoriData copyWithCompanion(GestoriCompanion data) {
    return GestoriData(
      id: data.id.present ? data.id.value : this.id,
      email: data.email.present ? data.email.value : this.email,
      password: data.password.present ? data.password.value : this.password,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GestoriData(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, email, password);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GestoriData &&
          other.id == this.id &&
          other.email == this.email &&
          other.password == this.password);
}

class GestoriCompanion extends UpdateCompanion<GestoriData> {
  final Value<int> id;
  final Value<String> email;
  final Value<String> password;
  const GestoriCompanion({
    this.id = const Value.absent(),
    this.email = const Value.absent(),
    this.password = const Value.absent(),
  });
  GestoriCompanion.insert({
    this.id = const Value.absent(),
    required String email,
    required String password,
  }) : email = Value(email),
       password = Value(password);
  static Insertable<GestoriData> custom({
    Expression<int>? id,
    Expression<String>? email,
    Expression<String>? password,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
    });
  }

  GestoriCompanion copyWith({
    Value<int>? id,
    Value<String>? email,
    Value<String>? password,
  }) {
    return GestoriCompanion(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GestoriCompanion(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }
}

class $MenseTable extends Mense with TableInfo<$MenseTable, MenseData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MenseTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _gestoreIdMeta = const VerificationMeta(
    'gestoreId',
  );
  @override
  late final GeneratedColumn<int> gestoreId = GeneratedColumn<int>(
    'gestore_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES gestori (id)',
    ),
  );
  static const VerificationMeta _nomeMensaMeta = const VerificationMeta(
    'nomeMensa',
  );
  @override
  late final GeneratedColumn<String> nomeMensa = GeneratedColumn<String>(
    'nome_mensa',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cittaMeta = const VerificationMeta('citta');
  @override
  late final GeneratedColumn<String> citta = GeneratedColumn<String>(
    'citta',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _comuneMeta = const VerificationMeta('comune');
  @override
  late final GeneratedColumn<String> comune = GeneratedColumn<String>(
    'comune',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _indirizzoMeta = const VerificationMeta(
    'indirizzo',
  );
  @override
  late final GeneratedColumn<String> indirizzo = GeneratedColumn<String>(
    'indirizzo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _telefonoMeta = const VerificationMeta(
    'telefono',
  );
  @override
  late final GeneratedColumn<String> telefono = GeneratedColumn<String>(
    'telefono',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _partitaIvaMeta = const VerificationMeta(
    'partitaIva',
  );
  @override
  late final GeneratedColumn<String> partitaIva = GeneratedColumn<String>(
    'partita_iva',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _immagineMeta = const VerificationMeta(
    'immagine',
  );
  @override
  late final GeneratedColumn<Uint8List> immagine = GeneratedColumn<Uint8List>(
    'immagine',
    aliasedName,
    true,
    type: DriftSqlType.blob,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    gestoreId,
    nomeMensa,
    citta,
    comune,
    indirizzo,
    telefono,
    partitaIva,
    immagine,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mense';
  @override
  VerificationContext validateIntegrity(
    Insertable<MenseData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('gestore_id')) {
      context.handle(
        _gestoreIdMeta,
        gestoreId.isAcceptableOrUnknown(data['gestore_id']!, _gestoreIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gestoreIdMeta);
    }
    if (data.containsKey('nome_mensa')) {
      context.handle(
        _nomeMensaMeta,
        nomeMensa.isAcceptableOrUnknown(data['nome_mensa']!, _nomeMensaMeta),
      );
    } else if (isInserting) {
      context.missing(_nomeMensaMeta);
    }
    if (data.containsKey('citta')) {
      context.handle(
        _cittaMeta,
        citta.isAcceptableOrUnknown(data['citta']!, _cittaMeta),
      );
    } else if (isInserting) {
      context.missing(_cittaMeta);
    }
    if (data.containsKey('comune')) {
      context.handle(
        _comuneMeta,
        comune.isAcceptableOrUnknown(data['comune']!, _comuneMeta),
      );
    } else if (isInserting) {
      context.missing(_comuneMeta);
    }
    if (data.containsKey('indirizzo')) {
      context.handle(
        _indirizzoMeta,
        indirizzo.isAcceptableOrUnknown(data['indirizzo']!, _indirizzoMeta),
      );
    } else if (isInserting) {
      context.missing(_indirizzoMeta);
    }
    if (data.containsKey('telefono')) {
      context.handle(
        _telefonoMeta,
        telefono.isAcceptableOrUnknown(data['telefono']!, _telefonoMeta),
      );
    }
    if (data.containsKey('partita_iva')) {
      context.handle(
        _partitaIvaMeta,
        partitaIva.isAcceptableOrUnknown(data['partita_iva']!, _partitaIvaMeta),
      );
    }
    if (data.containsKey('immagine')) {
      context.handle(
        _immagineMeta,
        immagine.isAcceptableOrUnknown(data['immagine']!, _immagineMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MenseData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MenseData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      gestoreId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gestore_id'],
      )!,
      nomeMensa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nome_mensa'],
      )!,
      citta: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}citta'],
      )!,
      comune: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comune'],
      )!,
      indirizzo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}indirizzo'],
      )!,
      telefono: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}telefono'],
      ),
      partitaIva: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}partita_iva'],
      ),
      immagine: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}immagine'],
      ),
    );
  }

  @override
  $MenseTable createAlias(String alias) {
    return $MenseTable(attachedDatabase, alias);
  }
}

class MenseData extends DataClass implements Insertable<MenseData> {
  final int id;
  final int gestoreId;
  final String nomeMensa;
  final String citta;
  final String comune;
  final String indirizzo;
  final String? telefono;
  final String? partitaIva;
  final Uint8List? immagine;
  const MenseData({
    required this.id,
    required this.gestoreId,
    required this.nomeMensa,
    required this.citta,
    required this.comune,
    required this.indirizzo,
    this.telefono,
    this.partitaIva,
    this.immagine,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['gestore_id'] = Variable<int>(gestoreId);
    map['nome_mensa'] = Variable<String>(nomeMensa);
    map['citta'] = Variable<String>(citta);
    map['comune'] = Variable<String>(comune);
    map['indirizzo'] = Variable<String>(indirizzo);
    if (!nullToAbsent || telefono != null) {
      map['telefono'] = Variable<String>(telefono);
    }
    if (!nullToAbsent || partitaIva != null) {
      map['partita_iva'] = Variable<String>(partitaIva);
    }
    if (!nullToAbsent || immagine != null) {
      map['immagine'] = Variable<Uint8List>(immagine);
    }
    return map;
  }

  MenseCompanion toCompanion(bool nullToAbsent) {
    return MenseCompanion(
      id: Value(id),
      gestoreId: Value(gestoreId),
      nomeMensa: Value(nomeMensa),
      citta: Value(citta),
      comune: Value(comune),
      indirizzo: Value(indirizzo),
      telefono: telefono == null && nullToAbsent
          ? const Value.absent()
          : Value(telefono),
      partitaIva: partitaIva == null && nullToAbsent
          ? const Value.absent()
          : Value(partitaIva),
      immagine: immagine == null && nullToAbsent
          ? const Value.absent()
          : Value(immagine),
    );
  }

  factory MenseData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MenseData(
      id: serializer.fromJson<int>(json['id']),
      gestoreId: serializer.fromJson<int>(json['gestoreId']),
      nomeMensa: serializer.fromJson<String>(json['nomeMensa']),
      citta: serializer.fromJson<String>(json['citta']),
      comune: serializer.fromJson<String>(json['comune']),
      indirizzo: serializer.fromJson<String>(json['indirizzo']),
      telefono: serializer.fromJson<String?>(json['telefono']),
      partitaIva: serializer.fromJson<String?>(json['partitaIva']),
      immagine: serializer.fromJson<Uint8List?>(json['immagine']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'gestoreId': serializer.toJson<int>(gestoreId),
      'nomeMensa': serializer.toJson<String>(nomeMensa),
      'citta': serializer.toJson<String>(citta),
      'comune': serializer.toJson<String>(comune),
      'indirizzo': serializer.toJson<String>(indirizzo),
      'telefono': serializer.toJson<String?>(telefono),
      'partitaIva': serializer.toJson<String?>(partitaIva),
      'immagine': serializer.toJson<Uint8List?>(immagine),
    };
  }

  MenseData copyWith({
    int? id,
    int? gestoreId,
    String? nomeMensa,
    String? citta,
    String? comune,
    String? indirizzo,
    Value<String?> telefono = const Value.absent(),
    Value<String?> partitaIva = const Value.absent(),
    Value<Uint8List?> immagine = const Value.absent(),
  }) => MenseData(
    id: id ?? this.id,
    gestoreId: gestoreId ?? this.gestoreId,
    nomeMensa: nomeMensa ?? this.nomeMensa,
    citta: citta ?? this.citta,
    comune: comune ?? this.comune,
    indirizzo: indirizzo ?? this.indirizzo,
    telefono: telefono.present ? telefono.value : this.telefono,
    partitaIva: partitaIva.present ? partitaIva.value : this.partitaIva,
    immagine: immagine.present ? immagine.value : this.immagine,
  );
  MenseData copyWithCompanion(MenseCompanion data) {
    return MenseData(
      id: data.id.present ? data.id.value : this.id,
      gestoreId: data.gestoreId.present ? data.gestoreId.value : this.gestoreId,
      nomeMensa: data.nomeMensa.present ? data.nomeMensa.value : this.nomeMensa,
      citta: data.citta.present ? data.citta.value : this.citta,
      comune: data.comune.present ? data.comune.value : this.comune,
      indirizzo: data.indirizzo.present ? data.indirizzo.value : this.indirizzo,
      telefono: data.telefono.present ? data.telefono.value : this.telefono,
      partitaIva: data.partitaIva.present
          ? data.partitaIva.value
          : this.partitaIva,
      immagine: data.immagine.present ? data.immagine.value : this.immagine,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MenseData(')
          ..write('id: $id, ')
          ..write('gestoreId: $gestoreId, ')
          ..write('nomeMensa: $nomeMensa, ')
          ..write('citta: $citta, ')
          ..write('comune: $comune, ')
          ..write('indirizzo: $indirizzo, ')
          ..write('telefono: $telefono, ')
          ..write('partitaIva: $partitaIva, ')
          ..write('immagine: $immagine')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    gestoreId,
    nomeMensa,
    citta,
    comune,
    indirizzo,
    telefono,
    partitaIva,
    $driftBlobEquality.hash(immagine),
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MenseData &&
          other.id == this.id &&
          other.gestoreId == this.gestoreId &&
          other.nomeMensa == this.nomeMensa &&
          other.citta == this.citta &&
          other.comune == this.comune &&
          other.indirizzo == this.indirizzo &&
          other.telefono == this.telefono &&
          other.partitaIva == this.partitaIva &&
          $driftBlobEquality.equals(other.immagine, this.immagine));
}

class MenseCompanion extends UpdateCompanion<MenseData> {
  final Value<int> id;
  final Value<int> gestoreId;
  final Value<String> nomeMensa;
  final Value<String> citta;
  final Value<String> comune;
  final Value<String> indirizzo;
  final Value<String?> telefono;
  final Value<String?> partitaIva;
  final Value<Uint8List?> immagine;
  const MenseCompanion({
    this.id = const Value.absent(),
    this.gestoreId = const Value.absent(),
    this.nomeMensa = const Value.absent(),
    this.citta = const Value.absent(),
    this.comune = const Value.absent(),
    this.indirizzo = const Value.absent(),
    this.telefono = const Value.absent(),
    this.partitaIva = const Value.absent(),
    this.immagine = const Value.absent(),
  });
  MenseCompanion.insert({
    this.id = const Value.absent(),
    required int gestoreId,
    required String nomeMensa,
    required String citta,
    required String comune,
    required String indirizzo,
    this.telefono = const Value.absent(),
    this.partitaIva = const Value.absent(),
    this.immagine = const Value.absent(),
  }) : gestoreId = Value(gestoreId),
       nomeMensa = Value(nomeMensa),
       citta = Value(citta),
       comune = Value(comune),
       indirizzo = Value(indirizzo);
  static Insertable<MenseData> custom({
    Expression<int>? id,
    Expression<int>? gestoreId,
    Expression<String>? nomeMensa,
    Expression<String>? citta,
    Expression<String>? comune,
    Expression<String>? indirizzo,
    Expression<String>? telefono,
    Expression<String>? partitaIva,
    Expression<Uint8List>? immagine,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gestoreId != null) 'gestore_id': gestoreId,
      if (nomeMensa != null) 'nome_mensa': nomeMensa,
      if (citta != null) 'citta': citta,
      if (comune != null) 'comune': comune,
      if (indirizzo != null) 'indirizzo': indirizzo,
      if (telefono != null) 'telefono': telefono,
      if (partitaIva != null) 'partita_iva': partitaIva,
      if (immagine != null) 'immagine': immagine,
    });
  }

  MenseCompanion copyWith({
    Value<int>? id,
    Value<int>? gestoreId,
    Value<String>? nomeMensa,
    Value<String>? citta,
    Value<String>? comune,
    Value<String>? indirizzo,
    Value<String?>? telefono,
    Value<String?>? partitaIva,
    Value<Uint8List?>? immagine,
  }) {
    return MenseCompanion(
      id: id ?? this.id,
      gestoreId: gestoreId ?? this.gestoreId,
      nomeMensa: nomeMensa ?? this.nomeMensa,
      citta: citta ?? this.citta,
      comune: comune ?? this.comune,
      indirizzo: indirizzo ?? this.indirizzo,
      telefono: telefono ?? this.telefono,
      partitaIva: partitaIva ?? this.partitaIva,
      immagine: immagine ?? this.immagine,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (gestoreId.present) {
      map['gestore_id'] = Variable<int>(gestoreId.value);
    }
    if (nomeMensa.present) {
      map['nome_mensa'] = Variable<String>(nomeMensa.value);
    }
    if (citta.present) {
      map['citta'] = Variable<String>(citta.value);
    }
    if (comune.present) {
      map['comune'] = Variable<String>(comune.value);
    }
    if (indirizzo.present) {
      map['indirizzo'] = Variable<String>(indirizzo.value);
    }
    if (telefono.present) {
      map['telefono'] = Variable<String>(telefono.value);
    }
    if (partitaIva.present) {
      map['partita_iva'] = Variable<String>(partitaIva.value);
    }
    if (immagine.present) {
      map['immagine'] = Variable<Uint8List>(immagine.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MenseCompanion(')
          ..write('id: $id, ')
          ..write('gestoreId: $gestoreId, ')
          ..write('nomeMensa: $nomeMensa, ')
          ..write('citta: $citta, ')
          ..write('comune: $comune, ')
          ..write('indirizzo: $indirizzo, ')
          ..write('telefono: $telefono, ')
          ..write('partitaIva: $partitaIva, ')
          ..write('immagine: $immagine')
          ..write(')'))
        .toString();
  }
}

class $UtenteMensePreferiteTable extends UtenteMensePreferite
    with TableInfo<$UtenteMensePreferiteTable, UtenteMensePreferiteData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UtenteMensePreferiteTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _utenteIdMeta = const VerificationMeta(
    'utenteId',
  );
  @override
  late final GeneratedColumn<int> utenteId = GeneratedColumn<int>(
    'utente_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES utenti (id)',
    ),
  );
  static const VerificationMeta _mensaIdMeta = const VerificationMeta(
    'mensaId',
  );
  @override
  late final GeneratedColumn<int> mensaId = GeneratedColumn<int>(
    'mensa_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES mense (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [utenteId, mensaId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'utente_mense_preferite';
  @override
  VerificationContext validateIntegrity(
    Insertable<UtenteMensePreferiteData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('utente_id')) {
      context.handle(
        _utenteIdMeta,
        utenteId.isAcceptableOrUnknown(data['utente_id']!, _utenteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_utenteIdMeta);
    }
    if (data.containsKey('mensa_id')) {
      context.handle(
        _mensaIdMeta,
        mensaId.isAcceptableOrUnknown(data['mensa_id']!, _mensaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_mensaIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {utenteId, mensaId};
  @override
  UtenteMensePreferiteData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UtenteMensePreferiteData(
      utenteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}utente_id'],
      )!,
      mensaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mensa_id'],
      )!,
    );
  }

  @override
  $UtenteMensePreferiteTable createAlias(String alias) {
    return $UtenteMensePreferiteTable(attachedDatabase, alias);
  }
}

class UtenteMensePreferiteData extends DataClass
    implements Insertable<UtenteMensePreferiteData> {
  final int utenteId;
  final int mensaId;
  const UtenteMensePreferiteData({
    required this.utenteId,
    required this.mensaId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['utente_id'] = Variable<int>(utenteId);
    map['mensa_id'] = Variable<int>(mensaId);
    return map;
  }

  UtenteMensePreferiteCompanion toCompanion(bool nullToAbsent) {
    return UtenteMensePreferiteCompanion(
      utenteId: Value(utenteId),
      mensaId: Value(mensaId),
    );
  }

  factory UtenteMensePreferiteData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UtenteMensePreferiteData(
      utenteId: serializer.fromJson<int>(json['utenteId']),
      mensaId: serializer.fromJson<int>(json['mensaId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'utenteId': serializer.toJson<int>(utenteId),
      'mensaId': serializer.toJson<int>(mensaId),
    };
  }

  UtenteMensePreferiteData copyWith({int? utenteId, int? mensaId}) =>
      UtenteMensePreferiteData(
        utenteId: utenteId ?? this.utenteId,
        mensaId: mensaId ?? this.mensaId,
      );
  UtenteMensePreferiteData copyWithCompanion(
    UtenteMensePreferiteCompanion data,
  ) {
    return UtenteMensePreferiteData(
      utenteId: data.utenteId.present ? data.utenteId.value : this.utenteId,
      mensaId: data.mensaId.present ? data.mensaId.value : this.mensaId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UtenteMensePreferiteData(')
          ..write('utenteId: $utenteId, ')
          ..write('mensaId: $mensaId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(utenteId, mensaId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UtenteMensePreferiteData &&
          other.utenteId == this.utenteId &&
          other.mensaId == this.mensaId);
}

class UtenteMensePreferiteCompanion
    extends UpdateCompanion<UtenteMensePreferiteData> {
  final Value<int> utenteId;
  final Value<int> mensaId;
  final Value<int> rowid;
  const UtenteMensePreferiteCompanion({
    this.utenteId = const Value.absent(),
    this.mensaId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UtenteMensePreferiteCompanion.insert({
    required int utenteId,
    required int mensaId,
    this.rowid = const Value.absent(),
  }) : utenteId = Value(utenteId),
       mensaId = Value(mensaId);
  static Insertable<UtenteMensePreferiteData> custom({
    Expression<int>? utenteId,
    Expression<int>? mensaId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (utenteId != null) 'utente_id': utenteId,
      if (mensaId != null) 'mensa_id': mensaId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UtenteMensePreferiteCompanion copyWith({
    Value<int>? utenteId,
    Value<int>? mensaId,
    Value<int>? rowid,
  }) {
    return UtenteMensePreferiteCompanion(
      utenteId: utenteId ?? this.utenteId,
      mensaId: mensaId ?? this.mensaId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (utenteId.present) {
      map['utente_id'] = Variable<int>(utenteId.value);
    }
    if (mensaId.present) {
      map['mensa_id'] = Variable<int>(mensaId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UtenteMensePreferiteCompanion(')
          ..write('utenteId: $utenteId, ')
          ..write('mensaId: $mensaId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PastoAllergieTable extends PastoAllergie
    with TableInfo<$PastoAllergieTable, PastoAllergieData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PastoAllergieTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pastoIdMeta = const VerificationMeta(
    'pastoId',
  );
  @override
  late final GeneratedColumn<int> pastoId = GeneratedColumn<int>(
    'pasto_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pasti (id)',
    ),
  );
  static const VerificationMeta _allergiaIdMeta = const VerificationMeta(
    'allergiaId',
  );
  @override
  late final GeneratedColumn<int> allergiaId = GeneratedColumn<int>(
    'allergia_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES allergie (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [pastoId, allergiaId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pasto_allergie';
  @override
  VerificationContext validateIntegrity(
    Insertable<PastoAllergieData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pasto_id')) {
      context.handle(
        _pastoIdMeta,
        pastoId.isAcceptableOrUnknown(data['pasto_id']!, _pastoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pastoIdMeta);
    }
    if (data.containsKey('allergia_id')) {
      context.handle(
        _allergiaIdMeta,
        allergiaId.isAcceptableOrUnknown(data['allergia_id']!, _allergiaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_allergiaIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pastoId, allergiaId};
  @override
  PastoAllergieData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PastoAllergieData(
      pastoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pasto_id'],
      )!,
      allergiaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}allergia_id'],
      )!,
    );
  }

  @override
  $PastoAllergieTable createAlias(String alias) {
    return $PastoAllergieTable(attachedDatabase, alias);
  }
}

class PastoAllergieData extends DataClass
    implements Insertable<PastoAllergieData> {
  final int pastoId;
  final int allergiaId;
  const PastoAllergieData({required this.pastoId, required this.allergiaId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pasto_id'] = Variable<int>(pastoId);
    map['allergia_id'] = Variable<int>(allergiaId);
    return map;
  }

  PastoAllergieCompanion toCompanion(bool nullToAbsent) {
    return PastoAllergieCompanion(
      pastoId: Value(pastoId),
      allergiaId: Value(allergiaId),
    );
  }

  factory PastoAllergieData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PastoAllergieData(
      pastoId: serializer.fromJson<int>(json['pastoId']),
      allergiaId: serializer.fromJson<int>(json['allergiaId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pastoId': serializer.toJson<int>(pastoId),
      'allergiaId': serializer.toJson<int>(allergiaId),
    };
  }

  PastoAllergieData copyWith({int? pastoId, int? allergiaId}) =>
      PastoAllergieData(
        pastoId: pastoId ?? this.pastoId,
        allergiaId: allergiaId ?? this.allergiaId,
      );
  PastoAllergieData copyWithCompanion(PastoAllergieCompanion data) {
    return PastoAllergieData(
      pastoId: data.pastoId.present ? data.pastoId.value : this.pastoId,
      allergiaId: data.allergiaId.present
          ? data.allergiaId.value
          : this.allergiaId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PastoAllergieData(')
          ..write('pastoId: $pastoId, ')
          ..write('allergiaId: $allergiaId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(pastoId, allergiaId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PastoAllergieData &&
          other.pastoId == this.pastoId &&
          other.allergiaId == this.allergiaId);
}

class PastoAllergieCompanion extends UpdateCompanion<PastoAllergieData> {
  final Value<int> pastoId;
  final Value<int> allergiaId;
  final Value<int> rowid;
  const PastoAllergieCompanion({
    this.pastoId = const Value.absent(),
    this.allergiaId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PastoAllergieCompanion.insert({
    required int pastoId,
    required int allergiaId,
    this.rowid = const Value.absent(),
  }) : pastoId = Value(pastoId),
       allergiaId = Value(allergiaId);
  static Insertable<PastoAllergieData> custom({
    Expression<int>? pastoId,
    Expression<int>? allergiaId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (pastoId != null) 'pasto_id': pastoId,
      if (allergiaId != null) 'allergia_id': allergiaId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PastoAllergieCompanion copyWith({
    Value<int>? pastoId,
    Value<int>? allergiaId,
    Value<int>? rowid,
  }) {
    return PastoAllergieCompanion(
      pastoId: pastoId ?? this.pastoId,
      allergiaId: allergiaId ?? this.allergiaId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pastoId.present) {
      map['pasto_id'] = Variable<int>(pastoId.value);
    }
    if (allergiaId.present) {
      map['allergia_id'] = Variable<int>(allergiaId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PastoAllergieCompanion(')
          ..write('pastoId: $pastoId, ')
          ..write('allergiaId: $allergiaId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PastoPreferenzeTable extends PastoPreferenze
    with TableInfo<$PastoPreferenzeTable, PastoPreferenzeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PastoPreferenzeTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pastoIdMeta = const VerificationMeta(
    'pastoId',
  );
  @override
  late final GeneratedColumn<int> pastoId = GeneratedColumn<int>(
    'pasto_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pasti (id)',
    ),
  );
  static const VerificationMeta _preferenzaIdMeta = const VerificationMeta(
    'preferenzaId',
  );
  @override
  late final GeneratedColumn<int> preferenzaId = GeneratedColumn<int>(
    'preferenza_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES preferenze (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [pastoId, preferenzaId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pasto_preferenze';
  @override
  VerificationContext validateIntegrity(
    Insertable<PastoPreferenzeData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pasto_id')) {
      context.handle(
        _pastoIdMeta,
        pastoId.isAcceptableOrUnknown(data['pasto_id']!, _pastoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pastoIdMeta);
    }
    if (data.containsKey('preferenza_id')) {
      context.handle(
        _preferenzaIdMeta,
        preferenzaId.isAcceptableOrUnknown(
          data['preferenza_id']!,
          _preferenzaIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_preferenzaIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pastoId, preferenzaId};
  @override
  PastoPreferenzeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PastoPreferenzeData(
      pastoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pasto_id'],
      )!,
      preferenzaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}preferenza_id'],
      )!,
    );
  }

  @override
  $PastoPreferenzeTable createAlias(String alias) {
    return $PastoPreferenzeTable(attachedDatabase, alias);
  }
}

class PastoPreferenzeData extends DataClass
    implements Insertable<PastoPreferenzeData> {
  final int pastoId;
  final int preferenzaId;
  const PastoPreferenzeData({
    required this.pastoId,
    required this.preferenzaId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pasto_id'] = Variable<int>(pastoId);
    map['preferenza_id'] = Variable<int>(preferenzaId);
    return map;
  }

  PastoPreferenzeCompanion toCompanion(bool nullToAbsent) {
    return PastoPreferenzeCompanion(
      pastoId: Value(pastoId),
      preferenzaId: Value(preferenzaId),
    );
  }

  factory PastoPreferenzeData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PastoPreferenzeData(
      pastoId: serializer.fromJson<int>(json['pastoId']),
      preferenzaId: serializer.fromJson<int>(json['preferenzaId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pastoId': serializer.toJson<int>(pastoId),
      'preferenzaId': serializer.toJson<int>(preferenzaId),
    };
  }

  PastoPreferenzeData copyWith({int? pastoId, int? preferenzaId}) =>
      PastoPreferenzeData(
        pastoId: pastoId ?? this.pastoId,
        preferenzaId: preferenzaId ?? this.preferenzaId,
      );
  PastoPreferenzeData copyWithCompanion(PastoPreferenzeCompanion data) {
    return PastoPreferenzeData(
      pastoId: data.pastoId.present ? data.pastoId.value : this.pastoId,
      preferenzaId: data.preferenzaId.present
          ? data.preferenzaId.value
          : this.preferenzaId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PastoPreferenzeData(')
          ..write('pastoId: $pastoId, ')
          ..write('preferenzaId: $preferenzaId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(pastoId, preferenzaId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PastoPreferenzeData &&
          other.pastoId == this.pastoId &&
          other.preferenzaId == this.preferenzaId);
}

class PastoPreferenzeCompanion extends UpdateCompanion<PastoPreferenzeData> {
  final Value<int> pastoId;
  final Value<int> preferenzaId;
  final Value<int> rowid;
  const PastoPreferenzeCompanion({
    this.pastoId = const Value.absent(),
    this.preferenzaId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PastoPreferenzeCompanion.insert({
    required int pastoId,
    required int preferenzaId,
    this.rowid = const Value.absent(),
  }) : pastoId = Value(pastoId),
       preferenzaId = Value(preferenzaId);
  static Insertable<PastoPreferenzeData> custom({
    Expression<int>? pastoId,
    Expression<int>? preferenzaId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (pastoId != null) 'pasto_id': pastoId,
      if (preferenzaId != null) 'preferenza_id': preferenzaId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PastoPreferenzeCompanion copyWith({
    Value<int>? pastoId,
    Value<int>? preferenzaId,
    Value<int>? rowid,
  }) {
    return PastoPreferenzeCompanion(
      pastoId: pastoId ?? this.pastoId,
      preferenzaId: preferenzaId ?? this.preferenzaId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pastoId.present) {
      map['pasto_id'] = Variable<int>(pastoId.value);
    }
    if (preferenzaId.present) {
      map['preferenza_id'] = Variable<int>(preferenzaId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PastoPreferenzeCompanion(')
          ..write('pastoId: $pastoId, ')
          ..write('preferenzaId: $preferenzaId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OrariAperturaTable extends OrariApertura
    with TableInfo<$OrariAperturaTable, OrariAperturaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrariAperturaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _mensaIdMeta = const VerificationMeta(
    'mensaId',
  );
  @override
  late final GeneratedColumn<int> mensaId = GeneratedColumn<int>(
    'mensa_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES mense (id)',
    ),
  );
  static const VerificationMeta _giornoMeta = const VerificationMeta('giorno');
  @override
  late final GeneratedColumn<String> giorno = GeneratedColumn<String>(
    'giorno',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aperturaMinutiMeta = const VerificationMeta(
    'aperturaMinuti',
  );
  @override
  late final GeneratedColumn<int> aperturaMinuti = GeneratedColumn<int>(
    'apertura_minuti',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chiusuraMinutiMeta = const VerificationMeta(
    'chiusuraMinuti',
  );
  @override
  late final GeneratedColumn<int> chiusuraMinuti = GeneratedColumn<int>(
    'chiusura_minuti',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mensaId,
    giorno,
    aperturaMinuti,
    chiusuraMinuti,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orari_apertura';
  @override
  VerificationContext validateIntegrity(
    Insertable<OrariAperturaData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('mensa_id')) {
      context.handle(
        _mensaIdMeta,
        mensaId.isAcceptableOrUnknown(data['mensa_id']!, _mensaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_mensaIdMeta);
    }
    if (data.containsKey('giorno')) {
      context.handle(
        _giornoMeta,
        giorno.isAcceptableOrUnknown(data['giorno']!, _giornoMeta),
      );
    } else if (isInserting) {
      context.missing(_giornoMeta);
    }
    if (data.containsKey('apertura_minuti')) {
      context.handle(
        _aperturaMinutiMeta,
        aperturaMinuti.isAcceptableOrUnknown(
          data['apertura_minuti']!,
          _aperturaMinutiMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_aperturaMinutiMeta);
    }
    if (data.containsKey('chiusura_minuti')) {
      context.handle(
        _chiusuraMinutiMeta,
        chiusuraMinuti.isAcceptableOrUnknown(
          data['chiusura_minuti']!,
          _chiusuraMinutiMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_chiusuraMinutiMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrariAperturaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrariAperturaData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mensaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mensa_id'],
      )!,
      giorno: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}giorno'],
      )!,
      aperturaMinuti: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}apertura_minuti'],
      )!,
      chiusuraMinuti: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chiusura_minuti'],
      )!,
    );
  }

  @override
  $OrariAperturaTable createAlias(String alias) {
    return $OrariAperturaTable(attachedDatabase, alias);
  }
}

class OrariAperturaData extends DataClass
    implements Insertable<OrariAperturaData> {
  final int id;
  final int mensaId;
  final String giorno;
  final int aperturaMinuti;
  final int chiusuraMinuti;
  const OrariAperturaData({
    required this.id,
    required this.mensaId,
    required this.giorno,
    required this.aperturaMinuti,
    required this.chiusuraMinuti,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['mensa_id'] = Variable<int>(mensaId);
    map['giorno'] = Variable<String>(giorno);
    map['apertura_minuti'] = Variable<int>(aperturaMinuti);
    map['chiusura_minuti'] = Variable<int>(chiusuraMinuti);
    return map;
  }

  OrariAperturaCompanion toCompanion(bool nullToAbsent) {
    return OrariAperturaCompanion(
      id: Value(id),
      mensaId: Value(mensaId),
      giorno: Value(giorno),
      aperturaMinuti: Value(aperturaMinuti),
      chiusuraMinuti: Value(chiusuraMinuti),
    );
  }

  factory OrariAperturaData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrariAperturaData(
      id: serializer.fromJson<int>(json['id']),
      mensaId: serializer.fromJson<int>(json['mensaId']),
      giorno: serializer.fromJson<String>(json['giorno']),
      aperturaMinuti: serializer.fromJson<int>(json['aperturaMinuti']),
      chiusuraMinuti: serializer.fromJson<int>(json['chiusuraMinuti']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mensaId': serializer.toJson<int>(mensaId),
      'giorno': serializer.toJson<String>(giorno),
      'aperturaMinuti': serializer.toJson<int>(aperturaMinuti),
      'chiusuraMinuti': serializer.toJson<int>(chiusuraMinuti),
    };
  }

  OrariAperturaData copyWith({
    int? id,
    int? mensaId,
    String? giorno,
    int? aperturaMinuti,
    int? chiusuraMinuti,
  }) => OrariAperturaData(
    id: id ?? this.id,
    mensaId: mensaId ?? this.mensaId,
    giorno: giorno ?? this.giorno,
    aperturaMinuti: aperturaMinuti ?? this.aperturaMinuti,
    chiusuraMinuti: chiusuraMinuti ?? this.chiusuraMinuti,
  );
  OrariAperturaData copyWithCompanion(OrariAperturaCompanion data) {
    return OrariAperturaData(
      id: data.id.present ? data.id.value : this.id,
      mensaId: data.mensaId.present ? data.mensaId.value : this.mensaId,
      giorno: data.giorno.present ? data.giorno.value : this.giorno,
      aperturaMinuti: data.aperturaMinuti.present
          ? data.aperturaMinuti.value
          : this.aperturaMinuti,
      chiusuraMinuti: data.chiusuraMinuti.present
          ? data.chiusuraMinuti.value
          : this.chiusuraMinuti,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrariAperturaData(')
          ..write('id: $id, ')
          ..write('mensaId: $mensaId, ')
          ..write('giorno: $giorno, ')
          ..write('aperturaMinuti: $aperturaMinuti, ')
          ..write('chiusuraMinuti: $chiusuraMinuti')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, mensaId, giorno, aperturaMinuti, chiusuraMinuti);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrariAperturaData &&
          other.id == this.id &&
          other.mensaId == this.mensaId &&
          other.giorno == this.giorno &&
          other.aperturaMinuti == this.aperturaMinuti &&
          other.chiusuraMinuti == this.chiusuraMinuti);
}

class OrariAperturaCompanion extends UpdateCompanion<OrariAperturaData> {
  final Value<int> id;
  final Value<int> mensaId;
  final Value<String> giorno;
  final Value<int> aperturaMinuti;
  final Value<int> chiusuraMinuti;
  const OrariAperturaCompanion({
    this.id = const Value.absent(),
    this.mensaId = const Value.absent(),
    this.giorno = const Value.absent(),
    this.aperturaMinuti = const Value.absent(),
    this.chiusuraMinuti = const Value.absent(),
  });
  OrariAperturaCompanion.insert({
    this.id = const Value.absent(),
    required int mensaId,
    required String giorno,
    required int aperturaMinuti,
    required int chiusuraMinuti,
  }) : mensaId = Value(mensaId),
       giorno = Value(giorno),
       aperturaMinuti = Value(aperturaMinuti),
       chiusuraMinuti = Value(chiusuraMinuti);
  static Insertable<OrariAperturaData> custom({
    Expression<int>? id,
    Expression<int>? mensaId,
    Expression<String>? giorno,
    Expression<int>? aperturaMinuti,
    Expression<int>? chiusuraMinuti,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mensaId != null) 'mensa_id': mensaId,
      if (giorno != null) 'giorno': giorno,
      if (aperturaMinuti != null) 'apertura_minuti': aperturaMinuti,
      if (chiusuraMinuti != null) 'chiusura_minuti': chiusuraMinuti,
    });
  }

  OrariAperturaCompanion copyWith({
    Value<int>? id,
    Value<int>? mensaId,
    Value<String>? giorno,
    Value<int>? aperturaMinuti,
    Value<int>? chiusuraMinuti,
  }) {
    return OrariAperturaCompanion(
      id: id ?? this.id,
      mensaId: mensaId ?? this.mensaId,
      giorno: giorno ?? this.giorno,
      aperturaMinuti: aperturaMinuti ?? this.aperturaMinuti,
      chiusuraMinuti: chiusuraMinuti ?? this.chiusuraMinuti,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mensaId.present) {
      map['mensa_id'] = Variable<int>(mensaId.value);
    }
    if (giorno.present) {
      map['giorno'] = Variable<String>(giorno.value);
    }
    if (aperturaMinuti.present) {
      map['apertura_minuti'] = Variable<int>(aperturaMinuti.value);
    }
    if (chiusuraMinuti.present) {
      map['chiusura_minuti'] = Variable<int>(chiusuraMinuti.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrariAperturaCompanion(')
          ..write('id: $id, ')
          ..write('mensaId: $mensaId, ')
          ..write('giorno: $giorno, ')
          ..write('aperturaMinuti: $aperturaMinuti, ')
          ..write('chiusuraMinuti: $chiusuraMinuti')
          ..write(')'))
        .toString();
  }
}

class $MenuGiornalieriTable extends MenuGiornalieri
    with TableInfo<$MenuGiornalieriTable, MenuGiornalieriData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MenuGiornalieriTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _mensaIdMeta = const VerificationMeta(
    'mensaId',
  );
  @override
  late final GeneratedColumn<int> mensaId = GeneratedColumn<int>(
    'mensa_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES mense (id)',
    ),
  );
  static const VerificationMeta _pastoIdMeta = const VerificationMeta(
    'pastoId',
  );
  @override
  late final GeneratedColumn<int> pastoId = GeneratedColumn<int>(
    'pasto_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pasti (id)',
    ),
  );
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<String> data = GeneratedColumn<String>(
    'data',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantitaDisponibileMeta =
      const VerificationMeta('quantitaDisponibile');
  @override
  late final GeneratedColumn<int> quantitaDisponibile = GeneratedColumn<int>(
    'quantita_disponibile',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    mensaId,
    pastoId,
    data,
    quantitaDisponibile,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'menu_giornalieri';
  @override
  VerificationContext validateIntegrity(
    Insertable<MenuGiornalieriData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('mensa_id')) {
      context.handle(
        _mensaIdMeta,
        mensaId.isAcceptableOrUnknown(data['mensa_id']!, _mensaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_mensaIdMeta);
    }
    if (data.containsKey('pasto_id')) {
      context.handle(
        _pastoIdMeta,
        pastoId.isAcceptableOrUnknown(data['pasto_id']!, _pastoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pastoIdMeta);
    }
    if (data.containsKey('data')) {
      context.handle(
        _dataMeta,
        this.data.isAcceptableOrUnknown(data['data']!, _dataMeta),
      );
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    if (data.containsKey('quantita_disponibile')) {
      context.handle(
        _quantitaDisponibileMeta,
        quantitaDisponibile.isAcceptableOrUnknown(
          data['quantita_disponibile']!,
          _quantitaDisponibileMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {mensaId, pastoId, data};
  @override
  MenuGiornalieriData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MenuGiornalieriData(
      mensaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mensa_id'],
      )!,
      pastoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pasto_id'],
      )!,
      data: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}data'],
      )!,
      quantitaDisponibile: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantita_disponibile'],
      ),
    );
  }

  @override
  $MenuGiornalieriTable createAlias(String alias) {
    return $MenuGiornalieriTable(attachedDatabase, alias);
  }
}

class MenuGiornalieriData extends DataClass
    implements Insertable<MenuGiornalieriData> {
  final int mensaId;
  final int pastoId;
  final String data;
  final int? quantitaDisponibile;
  const MenuGiornalieriData({
    required this.mensaId,
    required this.pastoId,
    required this.data,
    this.quantitaDisponibile,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['mensa_id'] = Variable<int>(mensaId);
    map['pasto_id'] = Variable<int>(pastoId);
    map['data'] = Variable<String>(data);
    if (!nullToAbsent || quantitaDisponibile != null) {
      map['quantita_disponibile'] = Variable<int>(quantitaDisponibile);
    }
    return map;
  }

  MenuGiornalieriCompanion toCompanion(bool nullToAbsent) {
    return MenuGiornalieriCompanion(
      mensaId: Value(mensaId),
      pastoId: Value(pastoId),
      data: Value(data),
      quantitaDisponibile: quantitaDisponibile == null && nullToAbsent
          ? const Value.absent()
          : Value(quantitaDisponibile),
    );
  }

  factory MenuGiornalieriData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MenuGiornalieriData(
      mensaId: serializer.fromJson<int>(json['mensaId']),
      pastoId: serializer.fromJson<int>(json['pastoId']),
      data: serializer.fromJson<String>(json['data']),
      quantitaDisponibile: serializer.fromJson<int?>(
        json['quantitaDisponibile'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'mensaId': serializer.toJson<int>(mensaId),
      'pastoId': serializer.toJson<int>(pastoId),
      'data': serializer.toJson<String>(data),
      'quantitaDisponibile': serializer.toJson<int?>(quantitaDisponibile),
    };
  }

  MenuGiornalieriData copyWith({
    int? mensaId,
    int? pastoId,
    String? data,
    Value<int?> quantitaDisponibile = const Value.absent(),
  }) => MenuGiornalieriData(
    mensaId: mensaId ?? this.mensaId,
    pastoId: pastoId ?? this.pastoId,
    data: data ?? this.data,
    quantitaDisponibile: quantitaDisponibile.present
        ? quantitaDisponibile.value
        : this.quantitaDisponibile,
  );
  MenuGiornalieriData copyWithCompanion(MenuGiornalieriCompanion data) {
    return MenuGiornalieriData(
      mensaId: data.mensaId.present ? data.mensaId.value : this.mensaId,
      pastoId: data.pastoId.present ? data.pastoId.value : this.pastoId,
      data: data.data.present ? data.data.value : this.data,
      quantitaDisponibile: data.quantitaDisponibile.present
          ? data.quantitaDisponibile.value
          : this.quantitaDisponibile,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MenuGiornalieriData(')
          ..write('mensaId: $mensaId, ')
          ..write('pastoId: $pastoId, ')
          ..write('data: $data, ')
          ..write('quantitaDisponibile: $quantitaDisponibile')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(mensaId, pastoId, data, quantitaDisponibile);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MenuGiornalieriData &&
          other.mensaId == this.mensaId &&
          other.pastoId == this.pastoId &&
          other.data == this.data &&
          other.quantitaDisponibile == this.quantitaDisponibile);
}

class MenuGiornalieriCompanion extends UpdateCompanion<MenuGiornalieriData> {
  final Value<int> mensaId;
  final Value<int> pastoId;
  final Value<String> data;
  final Value<int?> quantitaDisponibile;
  final Value<int> rowid;
  const MenuGiornalieriCompanion({
    this.mensaId = const Value.absent(),
    this.pastoId = const Value.absent(),
    this.data = const Value.absent(),
    this.quantitaDisponibile = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MenuGiornalieriCompanion.insert({
    required int mensaId,
    required int pastoId,
    required String data,
    this.quantitaDisponibile = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : mensaId = Value(mensaId),
       pastoId = Value(pastoId),
       data = Value(data);
  static Insertable<MenuGiornalieriData> custom({
    Expression<int>? mensaId,
    Expression<int>? pastoId,
    Expression<String>? data,
    Expression<int>? quantitaDisponibile,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (mensaId != null) 'mensa_id': mensaId,
      if (pastoId != null) 'pasto_id': pastoId,
      if (data != null) 'data': data,
      if (quantitaDisponibile != null)
        'quantita_disponibile': quantitaDisponibile,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MenuGiornalieriCompanion copyWith({
    Value<int>? mensaId,
    Value<int>? pastoId,
    Value<String>? data,
    Value<int?>? quantitaDisponibile,
    Value<int>? rowid,
  }) {
    return MenuGiornalieriCompanion(
      mensaId: mensaId ?? this.mensaId,
      pastoId: pastoId ?? this.pastoId,
      data: data ?? this.data,
      quantitaDisponibile: quantitaDisponibile ?? this.quantitaDisponibile,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (mensaId.present) {
      map['mensa_id'] = Variable<int>(mensaId.value);
    }
    if (pastoId.present) {
      map['pasto_id'] = Variable<int>(pastoId.value);
    }
    if (data.present) {
      map['data'] = Variable<String>(data.value);
    }
    if (quantitaDisponibile.present) {
      map['quantita_disponibile'] = Variable<int>(quantitaDisponibile.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MenuGiornalieriCompanion(')
          ..write('mensaId: $mensaId, ')
          ..write('pastoId: $pastoId, ')
          ..write('data: $data, ')
          ..write('quantitaDisponibile: $quantitaDisponibile, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OrdiniTable extends Ordini with TableInfo<$OrdiniTable, OrdiniData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdiniTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _utenteIdMeta = const VerificationMeta(
    'utenteId',
  );
  @override
  late final GeneratedColumn<int> utenteId = GeneratedColumn<int>(
    'utente_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES utenti (id)',
    ),
  );
  static const VerificationMeta _mensaIdMeta = const VerificationMeta(
    'mensaId',
  );
  @override
  late final GeneratedColumn<int> mensaId = GeneratedColumn<int>(
    'mensa_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES mense (id)',
    ),
  );
  static const VerificationMeta _giornoRitiroMeta = const VerificationMeta(
    'giornoRitiro',
  );
  @override
  late final GeneratedColumn<DateTime> giornoRitiro = GeneratedColumn<DateTime>(
    'giorno_ritiro',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orarioRitiroMeta = const VerificationMeta(
    'orarioRitiro',
  );
  @override
  late final GeneratedColumn<String> orarioRitiro = GeneratedColumn<String>(
    'orario_ritiro',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notaMeta = const VerificationMeta('nota');
  @override
  late final GeneratedColumn<String> nota = GeneratedColumn<String>(
    'nota',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _totaleMeta = const VerificationMeta('totale');
  @override
  late final GeneratedColumn<double> totale = GeneratedColumn<double>(
    'totale',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _piattiTotaliMeta = const VerificationMeta(
    'piattiTotali',
  );
  @override
  late final GeneratedColumn<int> piattiTotali = GeneratedColumn<int>(
    'piatti_totali',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _dataInvioMeta = const VerificationMeta(
    'dataInvio',
  );
  @override
  late final GeneratedColumn<DateTime> dataInvio = GeneratedColumn<DateTime>(
    'data_invio',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _statoMeta = const VerificationMeta('stato');
  @override
  late final GeneratedColumn<String> stato = GeneratedColumn<String>(
    'stato',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('In attesa'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    utenteId,
    mensaId,
    giornoRitiro,
    orarioRitiro,
    nota,
    totale,
    piattiTotali,
    dataInvio,
    stato,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ordini';
  @override
  VerificationContext validateIntegrity(
    Insertable<OrdiniData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('utente_id')) {
      context.handle(
        _utenteIdMeta,
        utenteId.isAcceptableOrUnknown(data['utente_id']!, _utenteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_utenteIdMeta);
    }
    if (data.containsKey('mensa_id')) {
      context.handle(
        _mensaIdMeta,
        mensaId.isAcceptableOrUnknown(data['mensa_id']!, _mensaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_mensaIdMeta);
    }
    if (data.containsKey('giorno_ritiro')) {
      context.handle(
        _giornoRitiroMeta,
        giornoRitiro.isAcceptableOrUnknown(
          data['giorno_ritiro']!,
          _giornoRitiroMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_giornoRitiroMeta);
    }
    if (data.containsKey('orario_ritiro')) {
      context.handle(
        _orarioRitiroMeta,
        orarioRitiro.isAcceptableOrUnknown(
          data['orario_ritiro']!,
          _orarioRitiroMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_orarioRitiroMeta);
    }
    if (data.containsKey('nota')) {
      context.handle(
        _notaMeta,
        nota.isAcceptableOrUnknown(data['nota']!, _notaMeta),
      );
    }
    if (data.containsKey('totale')) {
      context.handle(
        _totaleMeta,
        totale.isAcceptableOrUnknown(data['totale']!, _totaleMeta),
      );
    }
    if (data.containsKey('piatti_totali')) {
      context.handle(
        _piattiTotaliMeta,
        piattiTotali.isAcceptableOrUnknown(
          data['piatti_totali']!,
          _piattiTotaliMeta,
        ),
      );
    }
    if (data.containsKey('data_invio')) {
      context.handle(
        _dataInvioMeta,
        dataInvio.isAcceptableOrUnknown(data['data_invio']!, _dataInvioMeta),
      );
    }
    if (data.containsKey('stato')) {
      context.handle(
        _statoMeta,
        stato.isAcceptableOrUnknown(data['stato']!, _statoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrdiniData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrdiniData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      utenteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}utente_id'],
      )!,
      mensaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mensa_id'],
      )!,
      giornoRitiro: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}giorno_ritiro'],
      )!,
      orarioRitiro: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}orario_ritiro'],
      )!,
      nota: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nota'],
      )!,
      totale: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}totale'],
      )!,
      piattiTotali: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}piatti_totali'],
      )!,
      dataInvio: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}data_invio'],
      )!,
      stato: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stato'],
      )!,
    );
  }

  @override
  $OrdiniTable createAlias(String alias) {
    return $OrdiniTable(attachedDatabase, alias);
  }
}

class OrdiniData extends DataClass implements Insertable<OrdiniData> {
  final int id;
  final int utenteId;
  final int mensaId;
  final DateTime giornoRitiro;
  final String orarioRitiro;
  final String nota;
  final double totale;
  final int piattiTotali;
  final DateTime dataInvio;
  final String stato;
  const OrdiniData({
    required this.id,
    required this.utenteId,
    required this.mensaId,
    required this.giornoRitiro,
    required this.orarioRitiro,
    required this.nota,
    required this.totale,
    required this.piattiTotali,
    required this.dataInvio,
    required this.stato,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['utente_id'] = Variable<int>(utenteId);
    map['mensa_id'] = Variable<int>(mensaId);
    map['giorno_ritiro'] = Variable<DateTime>(giornoRitiro);
    map['orario_ritiro'] = Variable<String>(orarioRitiro);
    map['nota'] = Variable<String>(nota);
    map['totale'] = Variable<double>(totale);
    map['piatti_totali'] = Variable<int>(piattiTotali);
    map['data_invio'] = Variable<DateTime>(dataInvio);
    map['stato'] = Variable<String>(stato);
    return map;
  }

  OrdiniCompanion toCompanion(bool nullToAbsent) {
    return OrdiniCompanion(
      id: Value(id),
      utenteId: Value(utenteId),
      mensaId: Value(mensaId),
      giornoRitiro: Value(giornoRitiro),
      orarioRitiro: Value(orarioRitiro),
      nota: Value(nota),
      totale: Value(totale),
      piattiTotali: Value(piattiTotali),
      dataInvio: Value(dataInvio),
      stato: Value(stato),
    );
  }

  factory OrdiniData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrdiniData(
      id: serializer.fromJson<int>(json['id']),
      utenteId: serializer.fromJson<int>(json['utenteId']),
      mensaId: serializer.fromJson<int>(json['mensaId']),
      giornoRitiro: serializer.fromJson<DateTime>(json['giornoRitiro']),
      orarioRitiro: serializer.fromJson<String>(json['orarioRitiro']),
      nota: serializer.fromJson<String>(json['nota']),
      totale: serializer.fromJson<double>(json['totale']),
      piattiTotali: serializer.fromJson<int>(json['piattiTotali']),
      dataInvio: serializer.fromJson<DateTime>(json['dataInvio']),
      stato: serializer.fromJson<String>(json['stato']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'utenteId': serializer.toJson<int>(utenteId),
      'mensaId': serializer.toJson<int>(mensaId),
      'giornoRitiro': serializer.toJson<DateTime>(giornoRitiro),
      'orarioRitiro': serializer.toJson<String>(orarioRitiro),
      'nota': serializer.toJson<String>(nota),
      'totale': serializer.toJson<double>(totale),
      'piattiTotali': serializer.toJson<int>(piattiTotali),
      'dataInvio': serializer.toJson<DateTime>(dataInvio),
      'stato': serializer.toJson<String>(stato),
    };
  }

  OrdiniData copyWith({
    int? id,
    int? utenteId,
    int? mensaId,
    DateTime? giornoRitiro,
    String? orarioRitiro,
    String? nota,
    double? totale,
    int? piattiTotali,
    DateTime? dataInvio,
    String? stato,
  }) => OrdiniData(
    id: id ?? this.id,
    utenteId: utenteId ?? this.utenteId,
    mensaId: mensaId ?? this.mensaId,
    giornoRitiro: giornoRitiro ?? this.giornoRitiro,
    orarioRitiro: orarioRitiro ?? this.orarioRitiro,
    nota: nota ?? this.nota,
    totale: totale ?? this.totale,
    piattiTotali: piattiTotali ?? this.piattiTotali,
    dataInvio: dataInvio ?? this.dataInvio,
    stato: stato ?? this.stato,
  );
  OrdiniData copyWithCompanion(OrdiniCompanion data) {
    return OrdiniData(
      id: data.id.present ? data.id.value : this.id,
      utenteId: data.utenteId.present ? data.utenteId.value : this.utenteId,
      mensaId: data.mensaId.present ? data.mensaId.value : this.mensaId,
      giornoRitiro: data.giornoRitiro.present
          ? data.giornoRitiro.value
          : this.giornoRitiro,
      orarioRitiro: data.orarioRitiro.present
          ? data.orarioRitiro.value
          : this.orarioRitiro,
      nota: data.nota.present ? data.nota.value : this.nota,
      totale: data.totale.present ? data.totale.value : this.totale,
      piattiTotali: data.piattiTotali.present
          ? data.piattiTotali.value
          : this.piattiTotali,
      dataInvio: data.dataInvio.present ? data.dataInvio.value : this.dataInvio,
      stato: data.stato.present ? data.stato.value : this.stato,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrdiniData(')
          ..write('id: $id, ')
          ..write('utenteId: $utenteId, ')
          ..write('mensaId: $mensaId, ')
          ..write('giornoRitiro: $giornoRitiro, ')
          ..write('orarioRitiro: $orarioRitiro, ')
          ..write('nota: $nota, ')
          ..write('totale: $totale, ')
          ..write('piattiTotali: $piattiTotali, ')
          ..write('dataInvio: $dataInvio, ')
          ..write('stato: $stato')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    utenteId,
    mensaId,
    giornoRitiro,
    orarioRitiro,
    nota,
    totale,
    piattiTotali,
    dataInvio,
    stato,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrdiniData &&
          other.id == this.id &&
          other.utenteId == this.utenteId &&
          other.mensaId == this.mensaId &&
          other.giornoRitiro == this.giornoRitiro &&
          other.orarioRitiro == this.orarioRitiro &&
          other.nota == this.nota &&
          other.totale == this.totale &&
          other.piattiTotali == this.piattiTotali &&
          other.dataInvio == this.dataInvio &&
          other.stato == this.stato);
}

class OrdiniCompanion extends UpdateCompanion<OrdiniData> {
  final Value<int> id;
  final Value<int> utenteId;
  final Value<int> mensaId;
  final Value<DateTime> giornoRitiro;
  final Value<String> orarioRitiro;
  final Value<String> nota;
  final Value<double> totale;
  final Value<int> piattiTotali;
  final Value<DateTime> dataInvio;
  final Value<String> stato;
  const OrdiniCompanion({
    this.id = const Value.absent(),
    this.utenteId = const Value.absent(),
    this.mensaId = const Value.absent(),
    this.giornoRitiro = const Value.absent(),
    this.orarioRitiro = const Value.absent(),
    this.nota = const Value.absent(),
    this.totale = const Value.absent(),
    this.piattiTotali = const Value.absent(),
    this.dataInvio = const Value.absent(),
    this.stato = const Value.absent(),
  });
  OrdiniCompanion.insert({
    this.id = const Value.absent(),
    required int utenteId,
    required int mensaId,
    required DateTime giornoRitiro,
    required String orarioRitiro,
    this.nota = const Value.absent(),
    this.totale = const Value.absent(),
    this.piattiTotali = const Value.absent(),
    this.dataInvio = const Value.absent(),
    this.stato = const Value.absent(),
  }) : utenteId = Value(utenteId),
       mensaId = Value(mensaId),
       giornoRitiro = Value(giornoRitiro),
       orarioRitiro = Value(orarioRitiro);
  static Insertable<OrdiniData> custom({
    Expression<int>? id,
    Expression<int>? utenteId,
    Expression<int>? mensaId,
    Expression<DateTime>? giornoRitiro,
    Expression<String>? orarioRitiro,
    Expression<String>? nota,
    Expression<double>? totale,
    Expression<int>? piattiTotali,
    Expression<DateTime>? dataInvio,
    Expression<String>? stato,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (utenteId != null) 'utente_id': utenteId,
      if (mensaId != null) 'mensa_id': mensaId,
      if (giornoRitiro != null) 'giorno_ritiro': giornoRitiro,
      if (orarioRitiro != null) 'orario_ritiro': orarioRitiro,
      if (nota != null) 'nota': nota,
      if (totale != null) 'totale': totale,
      if (piattiTotali != null) 'piatti_totali': piattiTotali,
      if (dataInvio != null) 'data_invio': dataInvio,
      if (stato != null) 'stato': stato,
    });
  }

  OrdiniCompanion copyWith({
    Value<int>? id,
    Value<int>? utenteId,
    Value<int>? mensaId,
    Value<DateTime>? giornoRitiro,
    Value<String>? orarioRitiro,
    Value<String>? nota,
    Value<double>? totale,
    Value<int>? piattiTotali,
    Value<DateTime>? dataInvio,
    Value<String>? stato,
  }) {
    return OrdiniCompanion(
      id: id ?? this.id,
      utenteId: utenteId ?? this.utenteId,
      mensaId: mensaId ?? this.mensaId,
      giornoRitiro: giornoRitiro ?? this.giornoRitiro,
      orarioRitiro: orarioRitiro ?? this.orarioRitiro,
      nota: nota ?? this.nota,
      totale: totale ?? this.totale,
      piattiTotali: piattiTotali ?? this.piattiTotali,
      dataInvio: dataInvio ?? this.dataInvio,
      stato: stato ?? this.stato,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (utenteId.present) {
      map['utente_id'] = Variable<int>(utenteId.value);
    }
    if (mensaId.present) {
      map['mensa_id'] = Variable<int>(mensaId.value);
    }
    if (giornoRitiro.present) {
      map['giorno_ritiro'] = Variable<DateTime>(giornoRitiro.value);
    }
    if (orarioRitiro.present) {
      map['orario_ritiro'] = Variable<String>(orarioRitiro.value);
    }
    if (nota.present) {
      map['nota'] = Variable<String>(nota.value);
    }
    if (totale.present) {
      map['totale'] = Variable<double>(totale.value);
    }
    if (piattiTotali.present) {
      map['piatti_totali'] = Variable<int>(piattiTotali.value);
    }
    if (dataInvio.present) {
      map['data_invio'] = Variable<DateTime>(dataInvio.value);
    }
    if (stato.present) {
      map['stato'] = Variable<String>(stato.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdiniCompanion(')
          ..write('id: $id, ')
          ..write('utenteId: $utenteId, ')
          ..write('mensaId: $mensaId, ')
          ..write('giornoRitiro: $giornoRitiro, ')
          ..write('orarioRitiro: $orarioRitiro, ')
          ..write('nota: $nota, ')
          ..write('totale: $totale, ')
          ..write('piattiTotali: $piattiTotali, ')
          ..write('dataInvio: $dataInvio, ')
          ..write('stato: $stato')
          ..write(')'))
        .toString();
  }
}

class $OrdinePiattiTable extends OrdinePiatti
    with TableInfo<$OrdinePiattiTable, OrdinePiattiData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdinePiattiTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _ordineIdMeta = const VerificationMeta(
    'ordineId',
  );
  @override
  late final GeneratedColumn<int> ordineId = GeneratedColumn<int>(
    'ordine_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ordini (id)',
    ),
  );
  static const VerificationMeta _pastoIdMeta = const VerificationMeta(
    'pastoId',
  );
  @override
  late final GeneratedColumn<int> pastoId = GeneratedColumn<int>(
    'pasto_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pasti (id)',
    ),
  );
  static const VerificationMeta _nomePastoMeta = const VerificationMeta(
    'nomePasto',
  );
  @override
  late final GeneratedColumn<String> nomePasto = GeneratedColumn<String>(
    'nome_pasto',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _prezzoMeta = const VerificationMeta('prezzo');
  @override
  late final GeneratedColumn<double> prezzo = GeneratedColumn<double>(
    'prezzo',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _quantitaMeta = const VerificationMeta(
    'quantita',
  );
  @override
  late final GeneratedColumn<int> quantita = GeneratedColumn<int>(
    'quantita',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ordineId,
    pastoId,
    nomePasto,
    prezzo,
    quantita,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ordine_piatti';
  @override
  VerificationContext validateIntegrity(
    Insertable<OrdinePiattiData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ordine_id')) {
      context.handle(
        _ordineIdMeta,
        ordineId.isAcceptableOrUnknown(data['ordine_id']!, _ordineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ordineIdMeta);
    }
    if (data.containsKey('pasto_id')) {
      context.handle(
        _pastoIdMeta,
        pastoId.isAcceptableOrUnknown(data['pasto_id']!, _pastoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pastoIdMeta);
    }
    if (data.containsKey('nome_pasto')) {
      context.handle(
        _nomePastoMeta,
        nomePasto.isAcceptableOrUnknown(data['nome_pasto']!, _nomePastoMeta),
      );
    } else if (isInserting) {
      context.missing(_nomePastoMeta);
    }
    if (data.containsKey('prezzo')) {
      context.handle(
        _prezzoMeta,
        prezzo.isAcceptableOrUnknown(data['prezzo']!, _prezzoMeta),
      );
    }
    if (data.containsKey('quantita')) {
      context.handle(
        _quantitaMeta,
        quantita.isAcceptableOrUnknown(data['quantita']!, _quantitaMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrdinePiattiData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrdinePiattiData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ordineId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ordine_id'],
      )!,
      pastoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pasto_id'],
      )!,
      nomePasto: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nome_pasto'],
      )!,
      prezzo: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}prezzo'],
      )!,
      quantita: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantita'],
      )!,
    );
  }

  @override
  $OrdinePiattiTable createAlias(String alias) {
    return $OrdinePiattiTable(attachedDatabase, alias);
  }
}

class OrdinePiattiData extends DataClass
    implements Insertable<OrdinePiattiData> {
  final int id;
  final int ordineId;
  final int pastoId;
  final String nomePasto;
  final double prezzo;
  final int quantita;
  const OrdinePiattiData({
    required this.id,
    required this.ordineId,
    required this.pastoId,
    required this.nomePasto,
    required this.prezzo,
    required this.quantita,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ordine_id'] = Variable<int>(ordineId);
    map['pasto_id'] = Variable<int>(pastoId);
    map['nome_pasto'] = Variable<String>(nomePasto);
    map['prezzo'] = Variable<double>(prezzo);
    map['quantita'] = Variable<int>(quantita);
    return map;
  }

  OrdinePiattiCompanion toCompanion(bool nullToAbsent) {
    return OrdinePiattiCompanion(
      id: Value(id),
      ordineId: Value(ordineId),
      pastoId: Value(pastoId),
      nomePasto: Value(nomePasto),
      prezzo: Value(prezzo),
      quantita: Value(quantita),
    );
  }

  factory OrdinePiattiData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrdinePiattiData(
      id: serializer.fromJson<int>(json['id']),
      ordineId: serializer.fromJson<int>(json['ordineId']),
      pastoId: serializer.fromJson<int>(json['pastoId']),
      nomePasto: serializer.fromJson<String>(json['nomePasto']),
      prezzo: serializer.fromJson<double>(json['prezzo']),
      quantita: serializer.fromJson<int>(json['quantita']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ordineId': serializer.toJson<int>(ordineId),
      'pastoId': serializer.toJson<int>(pastoId),
      'nomePasto': serializer.toJson<String>(nomePasto),
      'prezzo': serializer.toJson<double>(prezzo),
      'quantita': serializer.toJson<int>(quantita),
    };
  }

  OrdinePiattiData copyWith({
    int? id,
    int? ordineId,
    int? pastoId,
    String? nomePasto,
    double? prezzo,
    int? quantita,
  }) => OrdinePiattiData(
    id: id ?? this.id,
    ordineId: ordineId ?? this.ordineId,
    pastoId: pastoId ?? this.pastoId,
    nomePasto: nomePasto ?? this.nomePasto,
    prezzo: prezzo ?? this.prezzo,
    quantita: quantita ?? this.quantita,
  );
  OrdinePiattiData copyWithCompanion(OrdinePiattiCompanion data) {
    return OrdinePiattiData(
      id: data.id.present ? data.id.value : this.id,
      ordineId: data.ordineId.present ? data.ordineId.value : this.ordineId,
      pastoId: data.pastoId.present ? data.pastoId.value : this.pastoId,
      nomePasto: data.nomePasto.present ? data.nomePasto.value : this.nomePasto,
      prezzo: data.prezzo.present ? data.prezzo.value : this.prezzo,
      quantita: data.quantita.present ? data.quantita.value : this.quantita,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrdinePiattiData(')
          ..write('id: $id, ')
          ..write('ordineId: $ordineId, ')
          ..write('pastoId: $pastoId, ')
          ..write('nomePasto: $nomePasto, ')
          ..write('prezzo: $prezzo, ')
          ..write('quantita: $quantita')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, ordineId, pastoId, nomePasto, prezzo, quantita);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrdinePiattiData &&
          other.id == this.id &&
          other.ordineId == this.ordineId &&
          other.pastoId == this.pastoId &&
          other.nomePasto == this.nomePasto &&
          other.prezzo == this.prezzo &&
          other.quantita == this.quantita);
}

class OrdinePiattiCompanion extends UpdateCompanion<OrdinePiattiData> {
  final Value<int> id;
  final Value<int> ordineId;
  final Value<int> pastoId;
  final Value<String> nomePasto;
  final Value<double> prezzo;
  final Value<int> quantita;
  const OrdinePiattiCompanion({
    this.id = const Value.absent(),
    this.ordineId = const Value.absent(),
    this.pastoId = const Value.absent(),
    this.nomePasto = const Value.absent(),
    this.prezzo = const Value.absent(),
    this.quantita = const Value.absent(),
  });
  OrdinePiattiCompanion.insert({
    this.id = const Value.absent(),
    required int ordineId,
    required int pastoId,
    required String nomePasto,
    this.prezzo = const Value.absent(),
    this.quantita = const Value.absent(),
  }) : ordineId = Value(ordineId),
       pastoId = Value(pastoId),
       nomePasto = Value(nomePasto);
  static Insertable<OrdinePiattiData> custom({
    Expression<int>? id,
    Expression<int>? ordineId,
    Expression<int>? pastoId,
    Expression<String>? nomePasto,
    Expression<double>? prezzo,
    Expression<int>? quantita,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ordineId != null) 'ordine_id': ordineId,
      if (pastoId != null) 'pasto_id': pastoId,
      if (nomePasto != null) 'nome_pasto': nomePasto,
      if (prezzo != null) 'prezzo': prezzo,
      if (quantita != null) 'quantita': quantita,
    });
  }

  OrdinePiattiCompanion copyWith({
    Value<int>? id,
    Value<int>? ordineId,
    Value<int>? pastoId,
    Value<String>? nomePasto,
    Value<double>? prezzo,
    Value<int>? quantita,
  }) {
    return OrdinePiattiCompanion(
      id: id ?? this.id,
      ordineId: ordineId ?? this.ordineId,
      pastoId: pastoId ?? this.pastoId,
      nomePasto: nomePasto ?? this.nomePasto,
      prezzo: prezzo ?? this.prezzo,
      quantita: quantita ?? this.quantita,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ordineId.present) {
      map['ordine_id'] = Variable<int>(ordineId.value);
    }
    if (pastoId.present) {
      map['pasto_id'] = Variable<int>(pastoId.value);
    }
    if (nomePasto.present) {
      map['nome_pasto'] = Variable<String>(nomePasto.value);
    }
    if (prezzo.present) {
      map['prezzo'] = Variable<double>(prezzo.value);
    }
    if (quantita.present) {
      map['quantita'] = Variable<int>(quantita.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdinePiattiCompanion(')
          ..write('id: $id, ')
          ..write('ordineId: $ordineId, ')
          ..write('pastoId: $pastoId, ')
          ..write('nomePasto: $nomePasto, ')
          ..write('prezzo: $prezzo, ')
          ..write('quantita: $quantita')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PastiTable pasti = $PastiTable(this);
  late final $UtentiTable utenti = $UtentiTable(this);
  late final $AllergieTable allergie = $AllergieTable(this);
  late final $PreferenzeTable preferenze = $PreferenzeTable(this);
  late final $UtenteAllergieTable utenteAllergie = $UtenteAllergieTable(this);
  late final $UtentePreferenzeTable utentePreferenze = $UtentePreferenzeTable(
    this,
  );
  late final $GestoriTable gestori = $GestoriTable(this);
  late final $MenseTable mense = $MenseTable(this);
  late final $UtenteMensePreferiteTable utenteMensePreferite =
      $UtenteMensePreferiteTable(this);
  late final $PastoAllergieTable pastoAllergie = $PastoAllergieTable(this);
  late final $PastoPreferenzeTable pastoPreferenze = $PastoPreferenzeTable(
    this,
  );
  late final $OrariAperturaTable orariApertura = $OrariAperturaTable(this);
  late final $MenuGiornalieriTable menuGiornalieri = $MenuGiornalieriTable(
    this,
  );
  late final $OrdiniTable ordini = $OrdiniTable(this);
  late final $OrdinePiattiTable ordinePiatti = $OrdinePiattiTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    pasti,
    utenti,
    allergie,
    preferenze,
    utenteAllergie,
    utentePreferenze,
    gestori,
    mense,
    utenteMensePreferite,
    pastoAllergie,
    pastoPreferenze,
    orariApertura,
    menuGiornalieri,
    ordini,
    ordinePiatti,
  ];
}

typedef $$PastiTableCreateCompanionBuilder = PastiCompanion Function({
  Value<int> id,
  Value<String?> partitaIva,
  required String nome,
  required String categoria,
  Value<double> prezzo,
  Value<String?> imagePath,
  Value<String> descrizione,
  Value<Uint8List?> immagine,
});
typedef $$PastiTableUpdateCompanionBuilder = PastiCompanion Function({
  Value<int> id,
  Value<String?> partitaIva,
  Value<String> nome,
  Value<String> categoria,
  Value<double> prezzo,
  Value<String?> imagePath,
  Value<String> descrizione,
  Value<Uint8List?> immagine,
});

final class $$PastiTableReferences
    extends BaseReferences<_$AppDatabase, $PastiTable, PastiData> {
  $$PastiTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PastoAllergieTable, List<PastoAllergieData>>
  _pastoAllergieRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pastoAllergie,
    aliasName: 'pasti__id__pasto_allergie__pasto_id',
  );

  $$PastoAllergieTableProcessedTableManager get pastoAllergieRefs {
    final manager = $$PastoAllergieTableTableManager(
      $_db,
      $_db.pastoAllergie,
    ).filter((f) => f.pastoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pastoAllergieRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PastoPreferenzeTable, List<PastoPreferenzeData>>
  _pastoPreferenzeRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pastoPreferenze,
    aliasName: 'pasti__id__pasto_preferenze__pasto_id',
  );

  $$PastoPreferenzeTableProcessedTableManager get pastoPreferenzeRefs {
    final manager = $$PastoPreferenzeTableTableManager(
      $_db,
      $_db.pastoPreferenze,
    ).filter((f) => f.pastoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pastoPreferenzeRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MenuGiornalieriTable, List<MenuGiornalieriData>>
  _menuGiornalieriRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.menuGiornalieri,
    aliasName: 'pasti__id__menu_giornalieri__pasto_id',
  );

  $$MenuGiornalieriTableProcessedTableManager get menuGiornalieriRefs {
    final manager = $$MenuGiornalieriTableTableManager(
      $_db,
      $_db.menuGiornalieri,
    ).filter((f) => f.pastoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _menuGiornalieriRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$OrdinePiattiTable, List<OrdinePiattiData>>
  _ordinePiattiRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.ordinePiatti,
    aliasName: 'pasti__id__ordine_piatti__pasto_id',
  );

  $$OrdinePiattiTableProcessedTableManager get ordinePiattiRefs {
    final manager = $$OrdinePiattiTableTableManager(
      $_db,
      $_db.ordinePiatti,
    ).filter((f) => f.pastoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ordinePiattiRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PastiTableFilterComposer extends Composer<_$AppDatabase, $PastiTable> {
  $$PastiTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partitaIva => $composableBuilder(
    column: $table.partitaIva,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoria => $composableBuilder(
    column: $table.categoria,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get prezzo => $composableBuilder(
    column: $table.prezzo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descrizione => $composableBuilder(
    column: $table.descrizione,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get immagine => $composableBuilder(
    column: $table.immagine,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> pastoAllergieRefs(
    Expression<bool> Function($$PastoAllergieTableFilterComposer f) f,
  ) {
    final $$PastoAllergieTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pastoAllergie,
      getReferencedColumn: (t) => t.pastoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PastoAllergieTableFilterComposer(
            $db: $db,
            $table: $db.pastoAllergie,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pastoPreferenzeRefs(
    Expression<bool> Function($$PastoPreferenzeTableFilterComposer f) f,
  ) {
    final $$PastoPreferenzeTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pastoPreferenze,
      getReferencedColumn: (t) => t.pastoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PastoPreferenzeTableFilterComposer(
            $db: $db,
            $table: $db.pastoPreferenze,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> menuGiornalieriRefs(
    Expression<bool> Function($$MenuGiornalieriTableFilterComposer f) f,
  ) {
    final $$MenuGiornalieriTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.menuGiornalieri,
      getReferencedColumn: (t) => t.pastoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenuGiornalieriTableFilterComposer(
            $db: $db,
            $table: $db.menuGiornalieri,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> ordinePiattiRefs(
    Expression<bool> Function($$OrdinePiattiTableFilterComposer f) f,
  ) {
    final $$OrdinePiattiTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ordinePiatti,
      getReferencedColumn: (t) => t.pastoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdinePiattiTableFilterComposer(
            $db: $db,
            $table: $db.ordinePiatti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PastiTableOrderingComposer
    extends Composer<_$AppDatabase, $PastiTable> {
  $$PastiTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partitaIva => $composableBuilder(
    column: $table.partitaIva,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoria => $composableBuilder(
    column: $table.categoria,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get prezzo => $composableBuilder(
    column: $table.prezzo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descrizione => $composableBuilder(
    column: $table.descrizione,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get immagine => $composableBuilder(
    column: $table.immagine,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PastiTableAnnotationComposer
    extends Composer<_$AppDatabase, $PastiTable> {
  $$PastiTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get partitaIva => $composableBuilder(
    column: $table.partitaIva,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get categoria =>
      $composableBuilder(column: $table.categoria, builder: (column) => column);

  GeneratedColumn<double> get prezzo =>
      $composableBuilder(column: $table.prezzo, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<String> get descrizione => $composableBuilder(
    column: $table.descrizione,
    builder: (column) => column,
  );

  GeneratedColumn<Uint8List> get immagine =>
      $composableBuilder(column: $table.immagine, builder: (column) => column);

  Expression<T> pastoAllergieRefs<T extends Object>(
    Expression<T> Function($$PastoAllergieTableAnnotationComposer a) f,
  ) {
    final $$PastoAllergieTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pastoAllergie,
      getReferencedColumn: (t) => t.pastoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PastoAllergieTableAnnotationComposer(
            $db: $db,
            $table: $db.pastoAllergie,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> pastoPreferenzeRefs<T extends Object>(
    Expression<T> Function($$PastoPreferenzeTableAnnotationComposer a) f,
  ) {
    final $$PastoPreferenzeTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pastoPreferenze,
      getReferencedColumn: (t) => t.pastoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PastoPreferenzeTableAnnotationComposer(
            $db: $db,
            $table: $db.pastoPreferenze,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> menuGiornalieriRefs<T extends Object>(
    Expression<T> Function($$MenuGiornalieriTableAnnotationComposer a) f,
  ) {
    final $$MenuGiornalieriTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.menuGiornalieri,
      getReferencedColumn: (t) => t.pastoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenuGiornalieriTableAnnotationComposer(
            $db: $db,
            $table: $db.menuGiornalieri,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> ordinePiattiRefs<T extends Object>(
    Expression<T> Function($$OrdinePiattiTableAnnotationComposer a) f,
  ) {
    final $$OrdinePiattiTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ordinePiatti,
      getReferencedColumn: (t) => t.pastoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdinePiattiTableAnnotationComposer(
            $db: $db,
            $table: $db.ordinePiatti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PastiTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PastiTable,
          PastiData,
          $$PastiTableFilterComposer,
          $$PastiTableOrderingComposer,
          $$PastiTableAnnotationComposer,
          $$PastiTableCreateCompanionBuilder,
          $$PastiTableUpdateCompanionBuilder,
          (PastiData, $$PastiTableReferences),
          PastiData,
          PrefetchHooks Function({
            bool pastoAllergieRefs,
            bool pastoPreferenzeRefs,
            bool menuGiornalieriRefs,
            bool ordinePiattiRefs,
          })
        > {
  $$PastiTableTableManager(_$AppDatabase db, $PastiTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PastiTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PastiTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PastiTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> partitaIva = const Value.absent(),
                Value<String> nome = const Value.absent(),
                Value<String> categoria = const Value.absent(),
                Value<double> prezzo = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<String> descrizione = const Value.absent(),
                Value<Uint8List?> immagine = const Value.absent(),
              }) => PastiCompanion(
                id: id,
                partitaIva: partitaIva,
                nome: nome,
                categoria: categoria,
                prezzo: prezzo,
                imagePath: imagePath,
                descrizione: descrizione,
                immagine: immagine,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> partitaIva = const Value.absent(),
                required String nome,
                required String categoria,
                Value<double> prezzo = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<String> descrizione = const Value.absent(),
                Value<Uint8List?> immagine = const Value.absent(),
              }) => PastiCompanion.insert(
                id: id,
                partitaIva: partitaIva,
                nome: nome,
                categoria: categoria,
                prezzo: prezzo,
                imagePath: imagePath,
                descrizione: descrizione,
                immagine: immagine,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PastiTable, PastiData>(table),
                  $$PastiTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                pastoAllergieRefs = false,
                pastoPreferenzeRefs = false,
                menuGiornalieriRefs = false,
                ordinePiattiRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pastoAllergieRefs) db.pastoAllergie,
                    if (pastoPreferenzeRefs) db.pastoPreferenze,
                    if (menuGiornalieriRefs) db.menuGiornalieri,
                    if (ordinePiattiRefs) db.ordinePiatti,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pastoAllergieRefs)
                        await $_getPrefetchedData<
                          PastiData,
                          $PastiTable,
                          PastoAllergieData
                        >(
                          currentTable: table,
                          referencedTable: $$PastiTableReferences
                              ._pastoAllergieRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PastiTableReferences(
                                db,
                                table,
                                p0,
                              ).pastoAllergieRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.pastoId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (pastoPreferenzeRefs)
                        await $_getPrefetchedData<
                          PastiData,
                          $PastiTable,
                          PastoPreferenzeData
                        >(
                          currentTable: table,
                          referencedTable: $$PastiTableReferences
                              ._pastoPreferenzeRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PastiTableReferences(
                                db,
                                table,
                                p0,
                              ).pastoPreferenzeRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.pastoId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (menuGiornalieriRefs)
                        await $_getPrefetchedData<
                          PastiData,
                          $PastiTable,
                          MenuGiornalieriData
                        >(
                          currentTable: table,
                          referencedTable: $$PastiTableReferences
                              ._menuGiornalieriRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PastiTableReferences(
                                db,
                                table,
                                p0,
                              ).menuGiornalieriRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.pastoId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (ordinePiattiRefs)
                        await $_getPrefetchedData<
                          PastiData,
                          $PastiTable,
                          OrdinePiattiData
                        >(
                          currentTable: table,
                          referencedTable: $$PastiTableReferences
                              ._ordinePiattiRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PastiTableReferences(
                                db,
                                table,
                                p0,
                              ).ordinePiattiRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.pastoId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PastiTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PastiTable,
      PastiData,
      $$PastiTableFilterComposer,
      $$PastiTableOrderingComposer,
      $$PastiTableAnnotationComposer,
      $$PastiTableCreateCompanionBuilder,
      $$PastiTableUpdateCompanionBuilder,
      (PastiData, $$PastiTableReferences),
      PastiData,
      PrefetchHooks Function({
        bool pastoAllergieRefs,
        bool pastoPreferenzeRefs,
        bool menuGiornalieriRefs,
        bool ordinePiattiRefs,
      })
    >;
typedef $$UtentiTableCreateCompanionBuilder = UtentiCompanion Function({
  Value<int> id,
  required String nome,
  required String cognome,
  required String indirizzo,
  required String comune,
  required String provincia,
  required String email,
  required String password,
  required DateTime dataNascita,
});
typedef $$UtentiTableUpdateCompanionBuilder = UtentiCompanion Function({
  Value<int> id,
  Value<String> nome,
  Value<String> cognome,
  Value<String> indirizzo,
  Value<String> comune,
  Value<String> provincia,
  Value<String> email,
  Value<String> password,
  Value<DateTime> dataNascita,
});

final class $$UtentiTableReferences
    extends BaseReferences<_$AppDatabase, $UtentiTable, UtentiData> {
  $$UtentiTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UtenteAllergieTable, List<UtenteAllergieData>>
  _utenteAllergieRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.utenteAllergie,
    aliasName: 'utenti__id__utente_allergie__utente_id',
  );

  $$UtenteAllergieTableProcessedTableManager get utenteAllergieRefs {
    final manager = $$UtenteAllergieTableTableManager(
      $_db,
      $_db.utenteAllergie,
    ).filter((f) => f.utenteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_utenteAllergieRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$UtentePreferenzeTable, List<UtentePreferenzeData>>
  _utentePreferenzeRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.utentePreferenze,
    aliasName: 'utenti__id__utente_preferenze__utente_id',
  );

  $$UtentePreferenzeTableProcessedTableManager get utentePreferenzeRefs {
    final manager = $$UtentePreferenzeTableTableManager(
      $_db,
      $_db.utentePreferenze,
    ).filter((f) => f.utenteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _utentePreferenzeRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $UtenteMensePreferiteTable,
    List<UtenteMensePreferiteData>
  >
  _utenteMensePreferiteRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.utenteMensePreferite,
        aliasName: 'utenti__id__utente_mense_preferite__utente_id',
      );

  $$UtenteMensePreferiteTableProcessedTableManager
  get utenteMensePreferiteRefs {
    final manager = $$UtenteMensePreferiteTableTableManager(
      $_db,
      $_db.utenteMensePreferite,
    ).filter((f) => f.utenteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _utenteMensePreferiteRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$OrdiniTable, List<OrdiniData>> _ordiniRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.ordini,
    aliasName: 'utenti__id__ordini__utente_id',
  );

  $$OrdiniTableProcessedTableManager get ordiniRefs {
    final manager = $$OrdiniTableTableManager(
      $_db,
      $_db.ordini,
    ).filter((f) => f.utenteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ordiniRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UtentiTableFilterComposer
    extends Composer<_$AppDatabase, $UtentiTable> {
  $$UtentiTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cognome => $composableBuilder(
    column: $table.cognome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get indirizzo => $composableBuilder(
    column: $table.indirizzo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comune => $composableBuilder(
    column: $table.comune,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get provincia => $composableBuilder(
    column: $table.provincia,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dataNascita => $composableBuilder(
    column: $table.dataNascita,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> utenteAllergieRefs(
    Expression<bool> Function($$UtenteAllergieTableFilterComposer f) f,
  ) {
    final $$UtenteAllergieTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.utenteAllergie,
      getReferencedColumn: (t) => t.utenteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtenteAllergieTableFilterComposer(
            $db: $db,
            $table: $db.utenteAllergie,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> utentePreferenzeRefs(
    Expression<bool> Function($$UtentePreferenzeTableFilterComposer f) f,
  ) {
    final $$UtentePreferenzeTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.utentePreferenze,
      getReferencedColumn: (t) => t.utenteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtentePreferenzeTableFilterComposer(
            $db: $db,
            $table: $db.utentePreferenze,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> utenteMensePreferiteRefs(
    Expression<bool> Function($$UtenteMensePreferiteTableFilterComposer f) f,
  ) {
    final $$UtenteMensePreferiteTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.utenteMensePreferite,
      getReferencedColumn: (t) => t.utenteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtenteMensePreferiteTableFilterComposer(
            $db: $db,
            $table: $db.utenteMensePreferite,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> ordiniRefs(
    Expression<bool> Function($$OrdiniTableFilterComposer f) f,
  ) {
    final $$OrdiniTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ordini,
      getReferencedColumn: (t) => t.utenteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdiniTableFilterComposer(
            $db: $db,
            $table: $db.ordini,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UtentiTableOrderingComposer
    extends Composer<_$AppDatabase, $UtentiTable> {
  $$UtentiTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cognome => $composableBuilder(
    column: $table.cognome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get indirizzo => $composableBuilder(
    column: $table.indirizzo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comune => $composableBuilder(
    column: $table.comune,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get provincia => $composableBuilder(
    column: $table.provincia,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dataNascita => $composableBuilder(
    column: $table.dataNascita,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UtentiTableAnnotationComposer
    extends Composer<_$AppDatabase, $UtentiTable> {
  $$UtentiTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get cognome =>
      $composableBuilder(column: $table.cognome, builder: (column) => column);

  GeneratedColumn<String> get indirizzo =>
      $composableBuilder(column: $table.indirizzo, builder: (column) => column);

  GeneratedColumn<String> get comune =>
      $composableBuilder(column: $table.comune, builder: (column) => column);

  GeneratedColumn<String> get provincia =>
      $composableBuilder(column: $table.provincia, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<DateTime> get dataNascita => $composableBuilder(
    column: $table.dataNascita,
    builder: (column) => column,
  );

  Expression<T> utenteAllergieRefs<T extends Object>(
    Expression<T> Function($$UtenteAllergieTableAnnotationComposer a) f,
  ) {
    final $$UtenteAllergieTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.utenteAllergie,
      getReferencedColumn: (t) => t.utenteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtenteAllergieTableAnnotationComposer(
            $db: $db,
            $table: $db.utenteAllergie,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> utentePreferenzeRefs<T extends Object>(
    Expression<T> Function($$UtentePreferenzeTableAnnotationComposer a) f,
  ) {
    final $$UtentePreferenzeTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.utentePreferenze,
      getReferencedColumn: (t) => t.utenteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtentePreferenzeTableAnnotationComposer(
            $db: $db,
            $table: $db.utentePreferenze,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> utenteMensePreferiteRefs<T extends Object>(
    Expression<T> Function($$UtenteMensePreferiteTableAnnotationComposer a) f,
  ) {
    final $$UtenteMensePreferiteTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.utenteMensePreferite,
          getReferencedColumn: (t) => t.utenteId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UtenteMensePreferiteTableAnnotationComposer(
                $db: $db,
                $table: $db.utenteMensePreferite,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> ordiniRefs<T extends Object>(
    Expression<T> Function($$OrdiniTableAnnotationComposer a) f,
  ) {
    final $$OrdiniTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ordini,
      getReferencedColumn: (t) => t.utenteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdiniTableAnnotationComposer(
            $db: $db,
            $table: $db.ordini,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UtentiTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UtentiTable,
          UtentiData,
          $$UtentiTableFilterComposer,
          $$UtentiTableOrderingComposer,
          $$UtentiTableAnnotationComposer,
          $$UtentiTableCreateCompanionBuilder,
          $$UtentiTableUpdateCompanionBuilder,
          (UtentiData, $$UtentiTableReferences),
          UtentiData,
          PrefetchHooks Function({
            bool utenteAllergieRefs,
            bool utentePreferenzeRefs,
            bool utenteMensePreferiteRefs,
            bool ordiniRefs,
          })
        > {
  $$UtentiTableTableManager(_$AppDatabase db, $UtentiTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UtentiTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UtentiTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UtentiTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nome = const Value.absent(),
                Value<String> cognome = const Value.absent(),
                Value<String> indirizzo = const Value.absent(),
                Value<String> comune = const Value.absent(),
                Value<String> provincia = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> password = const Value.absent(),
                Value<DateTime> dataNascita = const Value.absent(),
              }) => UtentiCompanion(
                id: id,
                nome: nome,
                cognome: cognome,
                indirizzo: indirizzo,
                comune: comune,
                provincia: provincia,
                email: email,
                password: password,
                dataNascita: dataNascita,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nome,
                required String cognome,
                required String indirizzo,
                required String comune,
                required String provincia,
                required String email,
                required String password,
                required DateTime dataNascita,
              }) => UtentiCompanion.insert(
                id: id,
                nome: nome,
                cognome: cognome,
                indirizzo: indirizzo,
                comune: comune,
                provincia: provincia,
                email: email,
                password: password,
                dataNascita: dataNascita,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UtentiTable, UtentiData>(table),
                  $$UtentiTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                utenteAllergieRefs = false,
                utentePreferenzeRefs = false,
                utenteMensePreferiteRefs = false,
                ordiniRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (utenteAllergieRefs) db.utenteAllergie,
                    if (utentePreferenzeRefs) db.utentePreferenze,
                    if (utenteMensePreferiteRefs) db.utenteMensePreferite,
                    if (ordiniRefs) db.ordini,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (utenteAllergieRefs)
                        await $_getPrefetchedData<
                          UtentiData,
                          $UtentiTable,
                          UtenteAllergieData
                        >(
                          currentTable: table,
                          referencedTable: $$UtentiTableReferences
                              ._utenteAllergieRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UtentiTableReferences(
                                db,
                                table,
                                p0,
                              ).utenteAllergieRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.utenteId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (utentePreferenzeRefs)
                        await $_getPrefetchedData<
                          UtentiData,
                          $UtentiTable,
                          UtentePreferenzeData
                        >(
                          currentTable: table,
                          referencedTable: $$UtentiTableReferences
                              ._utentePreferenzeRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UtentiTableReferences(
                                db,
                                table,
                                p0,
                              ).utentePreferenzeRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.utenteId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (utenteMensePreferiteRefs)
                        await $_getPrefetchedData<
                          UtentiData,
                          $UtentiTable,
                          UtenteMensePreferiteData
                        >(
                          currentTable: table,
                          referencedTable: $$UtentiTableReferences
                              ._utenteMensePreferiteRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UtentiTableReferences(
                                db,
                                table,
                                p0,
                              ).utenteMensePreferiteRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.utenteId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (ordiniRefs)
                        await $_getPrefetchedData<
                          UtentiData,
                          $UtentiTable,
                          OrdiniData
                        >(
                          currentTable: table,
                          referencedTable: $$UtentiTableReferences
                              ._ordiniRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UtentiTableReferences(db, table, p0).ordiniRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.utenteId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$UtentiTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UtentiTable,
      UtentiData,
      $$UtentiTableFilterComposer,
      $$UtentiTableOrderingComposer,
      $$UtentiTableAnnotationComposer,
      $$UtentiTableCreateCompanionBuilder,
      $$UtentiTableUpdateCompanionBuilder,
      (UtentiData, $$UtentiTableReferences),
      UtentiData,
      PrefetchHooks Function({
        bool utenteAllergieRefs,
        bool utentePreferenzeRefs,
        bool utenteMensePreferiteRefs,
        bool ordiniRefs,
      })
    >;
typedef $$AllergieTableCreateCompanionBuilder = AllergieCompanion Function({
  Value<int> id,
  required String nome,
});
typedef $$AllergieTableUpdateCompanionBuilder = AllergieCompanion Function({
  Value<int> id,
  Value<String> nome,
});

final class $$AllergieTableReferences
    extends BaseReferences<_$AppDatabase, $AllergieTable, AllergieData> {
  $$AllergieTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UtenteAllergieTable, List<UtenteAllergieData>>
  _utenteAllergieRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.utenteAllergie,
    aliasName: 'allergie__id__utente_allergie__allergia_id',
  );

  $$UtenteAllergieTableProcessedTableManager get utenteAllergieRefs {
    final manager = $$UtenteAllergieTableTableManager(
      $_db,
      $_db.utenteAllergie,
    ).filter((f) => f.allergiaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_utenteAllergieRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PastoAllergieTable, List<PastoAllergieData>>
  _pastoAllergieRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pastoAllergie,
    aliasName: 'allergie__id__pasto_allergie__allergia_id',
  );

  $$PastoAllergieTableProcessedTableManager get pastoAllergieRefs {
    final manager = $$PastoAllergieTableTableManager(
      $_db,
      $_db.pastoAllergie,
    ).filter((f) => f.allergiaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pastoAllergieRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AllergieTableFilterComposer
    extends Composer<_$AppDatabase, $AllergieTable> {
  $$AllergieTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> utenteAllergieRefs(
    Expression<bool> Function($$UtenteAllergieTableFilterComposer f) f,
  ) {
    final $$UtenteAllergieTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.utenteAllergie,
      getReferencedColumn: (t) => t.allergiaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtenteAllergieTableFilterComposer(
            $db: $db,
            $table: $db.utenteAllergie,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pastoAllergieRefs(
    Expression<bool> Function($$PastoAllergieTableFilterComposer f) f,
  ) {
    final $$PastoAllergieTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pastoAllergie,
      getReferencedColumn: (t) => t.allergiaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PastoAllergieTableFilterComposer(
            $db: $db,
            $table: $db.pastoAllergie,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AllergieTableOrderingComposer
    extends Composer<_$AppDatabase, $AllergieTable> {
  $$AllergieTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AllergieTableAnnotationComposer
    extends Composer<_$AppDatabase, $AllergieTable> {
  $$AllergieTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  Expression<T> utenteAllergieRefs<T extends Object>(
    Expression<T> Function($$UtenteAllergieTableAnnotationComposer a) f,
  ) {
    final $$UtenteAllergieTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.utenteAllergie,
      getReferencedColumn: (t) => t.allergiaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtenteAllergieTableAnnotationComposer(
            $db: $db,
            $table: $db.utenteAllergie,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> pastoAllergieRefs<T extends Object>(
    Expression<T> Function($$PastoAllergieTableAnnotationComposer a) f,
  ) {
    final $$PastoAllergieTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pastoAllergie,
      getReferencedColumn: (t) => t.allergiaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PastoAllergieTableAnnotationComposer(
            $db: $db,
            $table: $db.pastoAllergie,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AllergieTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AllergieTable,
          AllergieData,
          $$AllergieTableFilterComposer,
          $$AllergieTableOrderingComposer,
          $$AllergieTableAnnotationComposer,
          $$AllergieTableCreateCompanionBuilder,
          $$AllergieTableUpdateCompanionBuilder,
          (AllergieData, $$AllergieTableReferences),
          AllergieData,
          PrefetchHooks Function({
            bool utenteAllergieRefs,
            bool pastoAllergieRefs,
          })
        > {
  $$AllergieTableTableManager(_$AppDatabase db, $AllergieTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AllergieTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AllergieTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AllergieTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nome = const Value.absent(),
          }) => AllergieCompanion(id: id, nome: nome),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nome,
          }) => AllergieCompanion.insert(id: id, nome: nome),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AllergieTable, AllergieData>(table),
                  $$AllergieTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({utenteAllergieRefs = false, pastoAllergieRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (utenteAllergieRefs) db.utenteAllergie,
                    if (pastoAllergieRefs) db.pastoAllergie,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (utenteAllergieRefs)
                        await $_getPrefetchedData<
                          AllergieData,
                          $AllergieTable,
                          UtenteAllergieData
                        >(
                          currentTable: table,
                          referencedTable: $$AllergieTableReferences
                              ._utenteAllergieRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AllergieTableReferences(
                                db,
                                table,
                                p0,
                              ).utenteAllergieRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.allergiaId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (pastoAllergieRefs)
                        await $_getPrefetchedData<
                          AllergieData,
                          $AllergieTable,
                          PastoAllergieData
                        >(
                          currentTable: table,
                          referencedTable: $$AllergieTableReferences
                              ._pastoAllergieRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AllergieTableReferences(
                                db,
                                table,
                                p0,
                              ).pastoAllergieRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.allergiaId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AllergieTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AllergieTable,
      AllergieData,
      $$AllergieTableFilterComposer,
      $$AllergieTableOrderingComposer,
      $$AllergieTableAnnotationComposer,
      $$AllergieTableCreateCompanionBuilder,
      $$AllergieTableUpdateCompanionBuilder,
      (AllergieData, $$AllergieTableReferences),
      AllergieData,
      PrefetchHooks Function({bool utenteAllergieRefs, bool pastoAllergieRefs})
    >;
typedef $$PreferenzeTableCreateCompanionBuilder = PreferenzeCompanion Function({
  Value<int> id,
  required String nome,
});
typedef $$PreferenzeTableUpdateCompanionBuilder = PreferenzeCompanion Function({
  Value<int> id,
  Value<String> nome,
});

final class $$PreferenzeTableReferences
    extends BaseReferences<_$AppDatabase, $PreferenzeTable, PreferenzeData> {
  $$PreferenzeTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UtentePreferenzeTable, List<UtentePreferenzeData>>
  _utentePreferenzeRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.utentePreferenze,
    aliasName: 'preferenze__id__utente_preferenze__preferenza_id',
  );

  $$UtentePreferenzeTableProcessedTableManager get utentePreferenzeRefs {
    final manager = $$UtentePreferenzeTableTableManager(
      $_db,
      $_db.utentePreferenze,
    ).filter((f) => f.preferenzaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _utentePreferenzeRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PastoPreferenzeTable, List<PastoPreferenzeData>>
  _pastoPreferenzeRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pastoPreferenze,
    aliasName: 'preferenze__id__pasto_preferenze__preferenza_id',
  );

  $$PastoPreferenzeTableProcessedTableManager get pastoPreferenzeRefs {
    final manager = $$PastoPreferenzeTableTableManager(
      $_db,
      $_db.pastoPreferenze,
    ).filter((f) => f.preferenzaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pastoPreferenzeRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PreferenzeTableFilterComposer
    extends Composer<_$AppDatabase, $PreferenzeTable> {
  $$PreferenzeTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> utentePreferenzeRefs(
    Expression<bool> Function($$UtentePreferenzeTableFilterComposer f) f,
  ) {
    final $$UtentePreferenzeTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.utentePreferenze,
      getReferencedColumn: (t) => t.preferenzaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtentePreferenzeTableFilterComposer(
            $db: $db,
            $table: $db.utentePreferenze,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pastoPreferenzeRefs(
    Expression<bool> Function($$PastoPreferenzeTableFilterComposer f) f,
  ) {
    final $$PastoPreferenzeTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pastoPreferenze,
      getReferencedColumn: (t) => t.preferenzaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PastoPreferenzeTableFilterComposer(
            $db: $db,
            $table: $db.pastoPreferenze,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PreferenzeTableOrderingComposer
    extends Composer<_$AppDatabase, $PreferenzeTable> {
  $$PreferenzeTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PreferenzeTableAnnotationComposer
    extends Composer<_$AppDatabase, $PreferenzeTable> {
  $$PreferenzeTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  Expression<T> utentePreferenzeRefs<T extends Object>(
    Expression<T> Function($$UtentePreferenzeTableAnnotationComposer a) f,
  ) {
    final $$UtentePreferenzeTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.utentePreferenze,
      getReferencedColumn: (t) => t.preferenzaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtentePreferenzeTableAnnotationComposer(
            $db: $db,
            $table: $db.utentePreferenze,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> pastoPreferenzeRefs<T extends Object>(
    Expression<T> Function($$PastoPreferenzeTableAnnotationComposer a) f,
  ) {
    final $$PastoPreferenzeTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pastoPreferenze,
      getReferencedColumn: (t) => t.preferenzaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PastoPreferenzeTableAnnotationComposer(
            $db: $db,
            $table: $db.pastoPreferenze,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PreferenzeTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PreferenzeTable,
          PreferenzeData,
          $$PreferenzeTableFilterComposer,
          $$PreferenzeTableOrderingComposer,
          $$PreferenzeTableAnnotationComposer,
          $$PreferenzeTableCreateCompanionBuilder,
          $$PreferenzeTableUpdateCompanionBuilder,
          (PreferenzeData, $$PreferenzeTableReferences),
          PreferenzeData,
          PrefetchHooks Function({
            bool utentePreferenzeRefs,
            bool pastoPreferenzeRefs,
          })
        > {
  $$PreferenzeTableTableManager(_$AppDatabase db, $PreferenzeTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PreferenzeTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PreferenzeTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PreferenzeTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nome = const Value.absent(),
          }) => PreferenzeCompanion(id: id, nome: nome),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nome,
          }) => PreferenzeCompanion.insert(id: id, nome: nome),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PreferenzeTable, PreferenzeData>(table),
                  $$PreferenzeTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({utentePreferenzeRefs = false, pastoPreferenzeRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (utentePreferenzeRefs) db.utentePreferenze,
                    if (pastoPreferenzeRefs) db.pastoPreferenze,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (utentePreferenzeRefs)
                        await $_getPrefetchedData<
                          PreferenzeData,
                          $PreferenzeTable,
                          UtentePreferenzeData
                        >(
                          currentTable: table,
                          referencedTable: $$PreferenzeTableReferences
                              ._utentePreferenzeRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PreferenzeTableReferences(
                                db,
                                table,
                                p0,
                              ).utentePreferenzeRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.preferenzaId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (pastoPreferenzeRefs)
                        await $_getPrefetchedData<
                          PreferenzeData,
                          $PreferenzeTable,
                          PastoPreferenzeData
                        >(
                          currentTable: table,
                          referencedTable: $$PreferenzeTableReferences
                              ._pastoPreferenzeRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PreferenzeTableReferences(
                                db,
                                table,
                                p0,
                              ).pastoPreferenzeRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.preferenzaId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PreferenzeTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PreferenzeTable,
      PreferenzeData,
      $$PreferenzeTableFilterComposer,
      $$PreferenzeTableOrderingComposer,
      $$PreferenzeTableAnnotationComposer,
      $$PreferenzeTableCreateCompanionBuilder,
      $$PreferenzeTableUpdateCompanionBuilder,
      (PreferenzeData, $$PreferenzeTableReferences),
      PreferenzeData,
      PrefetchHooks Function({
        bool utentePreferenzeRefs,
        bool pastoPreferenzeRefs,
      })
    >;
typedef $$UtenteAllergieTableCreateCompanionBuilder =
    UtenteAllergieCompanion Function({
      required int utenteId,
      required int allergiaId,
      Value<int> rowid,
    });
typedef $$UtenteAllergieTableUpdateCompanionBuilder =
    UtenteAllergieCompanion Function({
      Value<int> utenteId,
      Value<int> allergiaId,
      Value<int> rowid,
    });

final class $$UtenteAllergieTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $UtenteAllergieTable,
          UtenteAllergieData
        > {
  $$UtenteAllergieTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UtentiTable _utenteIdTable(_$AppDatabase db) =>
      db.utenti.createAlias('utente_allergie__utente_id__utenti__id');

  $$UtentiTableProcessedTableManager get utenteId {
    final $_column = $_itemColumn<int>('utente_id')!;

    final manager = $$UtentiTableTableManager(
      $_db,
      $_db.utenti,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_utenteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AllergieTable _allergiaIdTable(_$AppDatabase db) =>
      db.allergie.createAlias('utente_allergie__allergia_id__allergie__id');

  $$AllergieTableProcessedTableManager get allergiaId {
    final $_column = $_itemColumn<int>('allergia_id')!;

    final manager = $$AllergieTableTableManager(
      $_db,
      $_db.allergie,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_allergiaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UtenteAllergieTableFilterComposer
    extends Composer<_$AppDatabase, $UtenteAllergieTable> {
  $$UtenteAllergieTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$UtentiTableFilterComposer get utenteId {
    final $$UtentiTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.utenteId,
      referencedTable: $db.utenti,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtentiTableFilterComposer(
            $db: $db,
            $table: $db.utenti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AllergieTableFilterComposer get allergiaId {
    final $$AllergieTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.allergiaId,
      referencedTable: $db.allergie,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AllergieTableFilterComposer(
            $db: $db,
            $table: $db.allergie,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UtenteAllergieTableOrderingComposer
    extends Composer<_$AppDatabase, $UtenteAllergieTable> {
  $$UtenteAllergieTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$UtentiTableOrderingComposer get utenteId {
    final $$UtentiTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.utenteId,
      referencedTable: $db.utenti,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtentiTableOrderingComposer(
            $db: $db,
            $table: $db.utenti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AllergieTableOrderingComposer get allergiaId {
    final $$AllergieTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.allergiaId,
      referencedTable: $db.allergie,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AllergieTableOrderingComposer(
            $db: $db,
            $table: $db.allergie,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UtenteAllergieTableAnnotationComposer
    extends Composer<_$AppDatabase, $UtenteAllergieTable> {
  $$UtenteAllergieTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$UtentiTableAnnotationComposer get utenteId {
    final $$UtentiTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.utenteId,
      referencedTable: $db.utenti,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtentiTableAnnotationComposer(
            $db: $db,
            $table: $db.utenti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AllergieTableAnnotationComposer get allergiaId {
    final $$AllergieTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.allergiaId,
      referencedTable: $db.allergie,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AllergieTableAnnotationComposer(
            $db: $db,
            $table: $db.allergie,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UtenteAllergieTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UtenteAllergieTable,
          UtenteAllergieData,
          $$UtenteAllergieTableFilterComposer,
          $$UtenteAllergieTableOrderingComposer,
          $$UtenteAllergieTableAnnotationComposer,
          $$UtenteAllergieTableCreateCompanionBuilder,
          $$UtenteAllergieTableUpdateCompanionBuilder,
          (UtenteAllergieData, $$UtenteAllergieTableReferences),
          UtenteAllergieData,
          PrefetchHooks Function({bool utenteId, bool allergiaId})
        > {
  $$UtenteAllergieTableTableManager(
    _$AppDatabase db,
    $UtenteAllergieTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UtenteAllergieTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UtenteAllergieTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UtenteAllergieTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> utenteId = const Value.absent(),
                Value<int> allergiaId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UtenteAllergieCompanion(
                utenteId: utenteId,
                allergiaId: allergiaId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int utenteId,
                required int allergiaId,
                Value<int> rowid = const Value.absent(),
              }) => UtenteAllergieCompanion.insert(
                utenteId: utenteId,
                allergiaId: allergiaId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UtenteAllergieTable, UtenteAllergieData>(table),
                  $$UtenteAllergieTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({utenteId = false, allergiaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (utenteId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.utenteId,
                        referencedTable: $$UtenteAllergieTableReferences
                            ._utenteIdTable(db),
                        referencedColumn: $$UtenteAllergieTableReferences
                            ._utenteIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (allergiaId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.allergiaId,
                        referencedTable: $$UtenteAllergieTableReferences
                            ._allergiaIdTable(db),
                        referencedColumn: $$UtenteAllergieTableReferences
                            ._allergiaIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UtenteAllergieTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UtenteAllergieTable,
      UtenteAllergieData,
      $$UtenteAllergieTableFilterComposer,
      $$UtenteAllergieTableOrderingComposer,
      $$UtenteAllergieTableAnnotationComposer,
      $$UtenteAllergieTableCreateCompanionBuilder,
      $$UtenteAllergieTableUpdateCompanionBuilder,
      (UtenteAllergieData, $$UtenteAllergieTableReferences),
      UtenteAllergieData,
      PrefetchHooks Function({bool utenteId, bool allergiaId})
    >;
typedef $$UtentePreferenzeTableCreateCompanionBuilder =
    UtentePreferenzeCompanion Function({
      required int utenteId,
      required int preferenzaId,
      Value<int> rowid,
    });
typedef $$UtentePreferenzeTableUpdateCompanionBuilder =
    UtentePreferenzeCompanion Function({
      Value<int> utenteId,
      Value<int> preferenzaId,
      Value<int> rowid,
    });

final class $$UtentePreferenzeTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $UtentePreferenzeTable,
          UtentePreferenzeData
        > {
  $$UtentePreferenzeTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UtentiTable _utenteIdTable(_$AppDatabase db) =>
      db.utenti.createAlias('utente_preferenze__utente_id__utenti__id');

  $$UtentiTableProcessedTableManager get utenteId {
    final $_column = $_itemColumn<int>('utente_id')!;

    final manager = $$UtentiTableTableManager(
      $_db,
      $_db.utenti,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_utenteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PreferenzeTable _preferenzaIdTable(_$AppDatabase db) => db.preferenze
      .createAlias('utente_preferenze__preferenza_id__preferenze__id');

  $$PreferenzeTableProcessedTableManager get preferenzaId {
    final $_column = $_itemColumn<int>('preferenza_id')!;

    final manager = $$PreferenzeTableTableManager(
      $_db,
      $_db.preferenze,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_preferenzaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UtentePreferenzeTableFilterComposer
    extends Composer<_$AppDatabase, $UtentePreferenzeTable> {
  $$UtentePreferenzeTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$UtentiTableFilterComposer get utenteId {
    final $$UtentiTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.utenteId,
      referencedTable: $db.utenti,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtentiTableFilterComposer(
            $db: $db,
            $table: $db.utenti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PreferenzeTableFilterComposer get preferenzaId {
    final $$PreferenzeTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.preferenzaId,
      referencedTable: $db.preferenze,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PreferenzeTableFilterComposer(
            $db: $db,
            $table: $db.preferenze,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UtentePreferenzeTableOrderingComposer
    extends Composer<_$AppDatabase, $UtentePreferenzeTable> {
  $$UtentePreferenzeTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$UtentiTableOrderingComposer get utenteId {
    final $$UtentiTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.utenteId,
      referencedTable: $db.utenti,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtentiTableOrderingComposer(
            $db: $db,
            $table: $db.utenti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PreferenzeTableOrderingComposer get preferenzaId {
    final $$PreferenzeTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.preferenzaId,
      referencedTable: $db.preferenze,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PreferenzeTableOrderingComposer(
            $db: $db,
            $table: $db.preferenze,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UtentePreferenzeTableAnnotationComposer
    extends Composer<_$AppDatabase, $UtentePreferenzeTable> {
  $$UtentePreferenzeTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$UtentiTableAnnotationComposer get utenteId {
    final $$UtentiTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.utenteId,
      referencedTable: $db.utenti,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtentiTableAnnotationComposer(
            $db: $db,
            $table: $db.utenti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PreferenzeTableAnnotationComposer get preferenzaId {
    final $$PreferenzeTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.preferenzaId,
      referencedTable: $db.preferenze,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PreferenzeTableAnnotationComposer(
            $db: $db,
            $table: $db.preferenze,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UtentePreferenzeTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UtentePreferenzeTable,
          UtentePreferenzeData,
          $$UtentePreferenzeTableFilterComposer,
          $$UtentePreferenzeTableOrderingComposer,
          $$UtentePreferenzeTableAnnotationComposer,
          $$UtentePreferenzeTableCreateCompanionBuilder,
          $$UtentePreferenzeTableUpdateCompanionBuilder,
          (UtentePreferenzeData, $$UtentePreferenzeTableReferences),
          UtentePreferenzeData,
          PrefetchHooks Function({bool utenteId, bool preferenzaId})
        > {
  $$UtentePreferenzeTableTableManager(
    _$AppDatabase db,
    $UtentePreferenzeTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UtentePreferenzeTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UtentePreferenzeTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UtentePreferenzeTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> utenteId = const Value.absent(),
                Value<int> preferenzaId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UtentePreferenzeCompanion(
                utenteId: utenteId,
                preferenzaId: preferenzaId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int utenteId,
                required int preferenzaId,
                Value<int> rowid = const Value.absent(),
              }) => UtentePreferenzeCompanion.insert(
                utenteId: utenteId,
                preferenzaId: preferenzaId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UtentePreferenzeTable, UtentePreferenzeData>(
                    table,
                  ),
                  $$UtentePreferenzeTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({utenteId = false, preferenzaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (utenteId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.utenteId,
                        referencedTable: $$UtentePreferenzeTableReferences
                            ._utenteIdTable(db),
                        referencedColumn: $$UtentePreferenzeTableReferences
                            ._utenteIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (preferenzaId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.preferenzaId,
                        referencedTable: $$UtentePreferenzeTableReferences
                            ._preferenzaIdTable(db),
                        referencedColumn: $$UtentePreferenzeTableReferences
                            ._preferenzaIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UtentePreferenzeTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UtentePreferenzeTable,
      UtentePreferenzeData,
      $$UtentePreferenzeTableFilterComposer,
      $$UtentePreferenzeTableOrderingComposer,
      $$UtentePreferenzeTableAnnotationComposer,
      $$UtentePreferenzeTableCreateCompanionBuilder,
      $$UtentePreferenzeTableUpdateCompanionBuilder,
      (UtentePreferenzeData, $$UtentePreferenzeTableReferences),
      UtentePreferenzeData,
      PrefetchHooks Function({bool utenteId, bool preferenzaId})
    >;
typedef $$GestoriTableCreateCompanionBuilder = GestoriCompanion Function({
  Value<int> id,
  required String email,
  required String password,
});
typedef $$GestoriTableUpdateCompanionBuilder = GestoriCompanion Function({
  Value<int> id,
  Value<String> email,
  Value<String> password,
});

final class $$GestoriTableReferences
    extends BaseReferences<_$AppDatabase, $GestoriTable, GestoriData> {
  $$GestoriTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MenseTable, List<MenseData>> _menseRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.mense,
    aliasName: 'gestori__id__mense__gestore_id',
  );

  $$MenseTableProcessedTableManager get menseRefs {
    final manager = $$MenseTableTableManager(
      $_db,
      $_db.mense,
    ).filter((f) => f.gestoreId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_menseRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GestoriTableFilterComposer
    extends Composer<_$AppDatabase, $GestoriTable> {
  $$GestoriTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> menseRefs(
    Expression<bool> Function($$MenseTableFilterComposer f) f,
  ) {
    final $$MenseTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mense,
      getReferencedColumn: (t) => t.gestoreId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenseTableFilterComposer(
            $db: $db,
            $table: $db.mense,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GestoriTableOrderingComposer
    extends Composer<_$AppDatabase, $GestoriTable> {
  $$GestoriTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GestoriTableAnnotationComposer
    extends Composer<_$AppDatabase, $GestoriTable> {
  $$GestoriTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  Expression<T> menseRefs<T extends Object>(
    Expression<T> Function($$MenseTableAnnotationComposer a) f,
  ) {
    final $$MenseTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mense,
      getReferencedColumn: (t) => t.gestoreId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenseTableAnnotationComposer(
            $db: $db,
            $table: $db.mense,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GestoriTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GestoriTable,
          GestoriData,
          $$GestoriTableFilterComposer,
          $$GestoriTableOrderingComposer,
          $$GestoriTableAnnotationComposer,
          $$GestoriTableCreateCompanionBuilder,
          $$GestoriTableUpdateCompanionBuilder,
          (GestoriData, $$GestoriTableReferences),
          GestoriData,
          PrefetchHooks Function({bool menseRefs})
        > {
  $$GestoriTableTableManager(_$AppDatabase db, $GestoriTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GestoriTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GestoriTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GestoriTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> password = const Value.absent(),
          }) => GestoriCompanion(id: id, email: email, password: password),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String email,
                required String password,
              }) => GestoriCompanion.insert(
                id: id,
                email: email,
                password: password,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GestoriTable, GestoriData>(table),
                  $$GestoriTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({menseRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (menseRefs) db.mense],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (menseRefs)
                    await $_getPrefetchedData<
                      GestoriData,
                      $GestoriTable,
                      MenseData
                    >(
                      currentTable: table,
                      referencedTable: $$GestoriTableReferences._menseRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$GestoriTableReferences(db, table, p0).menseRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.gestoreId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$GestoriTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GestoriTable,
      GestoriData,
      $$GestoriTableFilterComposer,
      $$GestoriTableOrderingComposer,
      $$GestoriTableAnnotationComposer,
      $$GestoriTableCreateCompanionBuilder,
      $$GestoriTableUpdateCompanionBuilder,
      (GestoriData, $$GestoriTableReferences),
      GestoriData,
      PrefetchHooks Function({bool menseRefs})
    >;
typedef $$MenseTableCreateCompanionBuilder = MenseCompanion Function({
  Value<int> id,
  required int gestoreId,
  required String nomeMensa,
  required String citta,
  required String comune,
  required String indirizzo,
  Value<String?> telefono,
  Value<String?> partitaIva,
  Value<Uint8List?> immagine,
});
typedef $$MenseTableUpdateCompanionBuilder = MenseCompanion Function({
  Value<int> id,
  Value<int> gestoreId,
  Value<String> nomeMensa,
  Value<String> citta,
  Value<String> comune,
  Value<String> indirizzo,
  Value<String?> telefono,
  Value<String?> partitaIva,
  Value<Uint8List?> immagine,
});

final class $$MenseTableReferences
    extends BaseReferences<_$AppDatabase, $MenseTable, MenseData> {
  $$MenseTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GestoriTable _gestoreIdTable(_$AppDatabase db) =>
      db.gestori.createAlias('mense__gestore_id__gestori__id');

  $$GestoriTableProcessedTableManager get gestoreId {
    final $_column = $_itemColumn<int>('gestore_id')!;

    final manager = $$GestoriTableTableManager(
      $_db,
      $_db.gestori,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gestoreIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $UtenteMensePreferiteTable,
    List<UtenteMensePreferiteData>
  >
  _utenteMensePreferiteRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.utenteMensePreferite,
        aliasName: 'mense__id__utente_mense_preferite__mensa_id',
      );

  $$UtenteMensePreferiteTableProcessedTableManager
  get utenteMensePreferiteRefs {
    final manager = $$UtenteMensePreferiteTableTableManager(
      $_db,
      $_db.utenteMensePreferite,
    ).filter((f) => f.mensaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _utenteMensePreferiteRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$OrariAperturaTable, List<OrariAperturaData>>
  _orariAperturaRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.orariApertura,
    aliasName: 'mense__id__orari_apertura__mensa_id',
  );

  $$OrariAperturaTableProcessedTableManager get orariAperturaRefs {
    final manager = $$OrariAperturaTableTableManager(
      $_db,
      $_db.orariApertura,
    ).filter((f) => f.mensaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_orariAperturaRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MenuGiornalieriTable, List<MenuGiornalieriData>>
  _menuGiornalieriRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.menuGiornalieri,
    aliasName: 'mense__id__menu_giornalieri__mensa_id',
  );

  $$MenuGiornalieriTableProcessedTableManager get menuGiornalieriRefs {
    final manager = $$MenuGiornalieriTableTableManager(
      $_db,
      $_db.menuGiornalieri,
    ).filter((f) => f.mensaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _menuGiornalieriRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$OrdiniTable, List<OrdiniData>> _ordiniRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.ordini,
    aliasName: 'mense__id__ordini__mensa_id',
  );

  $$OrdiniTableProcessedTableManager get ordiniRefs {
    final manager = $$OrdiniTableTableManager(
      $_db,
      $_db.ordini,
    ).filter((f) => f.mensaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ordiniRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MenseTableFilterComposer extends Composer<_$AppDatabase, $MenseTable> {
  $$MenseTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nomeMensa => $composableBuilder(
    column: $table.nomeMensa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get citta => $composableBuilder(
    column: $table.citta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comune => $composableBuilder(
    column: $table.comune,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get indirizzo => $composableBuilder(
    column: $table.indirizzo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get telefono => $composableBuilder(
    column: $table.telefono,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partitaIva => $composableBuilder(
    column: $table.partitaIva,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get immagine => $composableBuilder(
    column: $table.immagine,
    builder: (column) => ColumnFilters(column),
  );

  $$GestoriTableFilterComposer get gestoreId {
    final $$GestoriTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gestoreId,
      referencedTable: $db.gestori,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GestoriTableFilterComposer(
            $db: $db,
            $table: $db.gestori,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> utenteMensePreferiteRefs(
    Expression<bool> Function($$UtenteMensePreferiteTableFilterComposer f) f,
  ) {
    final $$UtenteMensePreferiteTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.utenteMensePreferite,
      getReferencedColumn: (t) => t.mensaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtenteMensePreferiteTableFilterComposer(
            $db: $db,
            $table: $db.utenteMensePreferite,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> orariAperturaRefs(
    Expression<bool> Function($$OrariAperturaTableFilterComposer f) f,
  ) {
    final $$OrariAperturaTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.orariApertura,
      getReferencedColumn: (t) => t.mensaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrariAperturaTableFilterComposer(
            $db: $db,
            $table: $db.orariApertura,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> menuGiornalieriRefs(
    Expression<bool> Function($$MenuGiornalieriTableFilterComposer f) f,
  ) {
    final $$MenuGiornalieriTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.menuGiornalieri,
      getReferencedColumn: (t) => t.mensaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenuGiornalieriTableFilterComposer(
            $db: $db,
            $table: $db.menuGiornalieri,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> ordiniRefs(
    Expression<bool> Function($$OrdiniTableFilterComposer f) f,
  ) {
    final $$OrdiniTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ordini,
      getReferencedColumn: (t) => t.mensaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdiniTableFilterComposer(
            $db: $db,
            $table: $db.ordini,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MenseTableOrderingComposer
    extends Composer<_$AppDatabase, $MenseTable> {
  $$MenseTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nomeMensa => $composableBuilder(
    column: $table.nomeMensa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get citta => $composableBuilder(
    column: $table.citta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comune => $composableBuilder(
    column: $table.comune,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get indirizzo => $composableBuilder(
    column: $table.indirizzo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get telefono => $composableBuilder(
    column: $table.telefono,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partitaIva => $composableBuilder(
    column: $table.partitaIva,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get immagine => $composableBuilder(
    column: $table.immagine,
    builder: (column) => ColumnOrderings(column),
  );

  $$GestoriTableOrderingComposer get gestoreId {
    final $$GestoriTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gestoreId,
      referencedTable: $db.gestori,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GestoriTableOrderingComposer(
            $db: $db,
            $table: $db.gestori,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MenseTableAnnotationComposer
    extends Composer<_$AppDatabase, $MenseTable> {
  $$MenseTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nomeMensa =>
      $composableBuilder(column: $table.nomeMensa, builder: (column) => column);

  GeneratedColumn<String> get citta =>
      $composableBuilder(column: $table.citta, builder: (column) => column);

  GeneratedColumn<String> get comune =>
      $composableBuilder(column: $table.comune, builder: (column) => column);

  GeneratedColumn<String> get indirizzo =>
      $composableBuilder(column: $table.indirizzo, builder: (column) => column);

  GeneratedColumn<String> get telefono =>
      $composableBuilder(column: $table.telefono, builder: (column) => column);

  GeneratedColumn<String> get partitaIva => $composableBuilder(
    column: $table.partitaIva,
    builder: (column) => column,
  );

  GeneratedColumn<Uint8List> get immagine =>
      $composableBuilder(column: $table.immagine, builder: (column) => column);

  $$GestoriTableAnnotationComposer get gestoreId {
    final $$GestoriTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gestoreId,
      referencedTable: $db.gestori,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GestoriTableAnnotationComposer(
            $db: $db,
            $table: $db.gestori,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> utenteMensePreferiteRefs<T extends Object>(
    Expression<T> Function($$UtenteMensePreferiteTableAnnotationComposer a) f,
  ) {
    final $$UtenteMensePreferiteTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.utenteMensePreferite,
          getReferencedColumn: (t) => t.mensaId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UtenteMensePreferiteTableAnnotationComposer(
                $db: $db,
                $table: $db.utenteMensePreferite,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> orariAperturaRefs<T extends Object>(
    Expression<T> Function($$OrariAperturaTableAnnotationComposer a) f,
  ) {
    final $$OrariAperturaTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.orariApertura,
      getReferencedColumn: (t) => t.mensaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrariAperturaTableAnnotationComposer(
            $db: $db,
            $table: $db.orariApertura,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> menuGiornalieriRefs<T extends Object>(
    Expression<T> Function($$MenuGiornalieriTableAnnotationComposer a) f,
  ) {
    final $$MenuGiornalieriTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.menuGiornalieri,
      getReferencedColumn: (t) => t.mensaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenuGiornalieriTableAnnotationComposer(
            $db: $db,
            $table: $db.menuGiornalieri,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> ordiniRefs<T extends Object>(
    Expression<T> Function($$OrdiniTableAnnotationComposer a) f,
  ) {
    final $$OrdiniTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ordini,
      getReferencedColumn: (t) => t.mensaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdiniTableAnnotationComposer(
            $db: $db,
            $table: $db.ordini,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MenseTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MenseTable,
          MenseData,
          $$MenseTableFilterComposer,
          $$MenseTableOrderingComposer,
          $$MenseTableAnnotationComposer,
          $$MenseTableCreateCompanionBuilder,
          $$MenseTableUpdateCompanionBuilder,
          (MenseData, $$MenseTableReferences),
          MenseData,
          PrefetchHooks Function({
            bool gestoreId,
            bool utenteMensePreferiteRefs,
            bool orariAperturaRefs,
            bool menuGiornalieriRefs,
            bool ordiniRefs,
          })
        > {
  $$MenseTableTableManager(_$AppDatabase db, $MenseTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MenseTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MenseTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MenseTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> gestoreId = const Value.absent(),
                Value<String> nomeMensa = const Value.absent(),
                Value<String> citta = const Value.absent(),
                Value<String> comune = const Value.absent(),
                Value<String> indirizzo = const Value.absent(),
                Value<String?> telefono = const Value.absent(),
                Value<String?> partitaIva = const Value.absent(),
                Value<Uint8List?> immagine = const Value.absent(),
              }) => MenseCompanion(
                id: id,
                gestoreId: gestoreId,
                nomeMensa: nomeMensa,
                citta: citta,
                comune: comune,
                indirizzo: indirizzo,
                telefono: telefono,
                partitaIva: partitaIva,
                immagine: immagine,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int gestoreId,
                required String nomeMensa,
                required String citta,
                required String comune,
                required String indirizzo,
                Value<String?> telefono = const Value.absent(),
                Value<String?> partitaIva = const Value.absent(),
                Value<Uint8List?> immagine = const Value.absent(),
              }) => MenseCompanion.insert(
                id: id,
                gestoreId: gestoreId,
                nomeMensa: nomeMensa,
                citta: citta,
                comune: comune,
                indirizzo: indirizzo,
                telefono: telefono,
                partitaIva: partitaIva,
                immagine: immagine,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MenseTable, MenseData>(table),
                  $$MenseTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                gestoreId = false,
                utenteMensePreferiteRefs = false,
                orariAperturaRefs = false,
                menuGiornalieriRefs = false,
                ordiniRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (utenteMensePreferiteRefs) db.utenteMensePreferite,
                    if (orariAperturaRefs) db.orariApertura,
                    if (menuGiornalieriRefs) db.menuGiornalieri,
                    if (ordiniRefs) db.ordini,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (gestoreId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.gestoreId,
                            referencedTable: $$MenseTableReferences
                                ._gestoreIdTable(db),
                            referencedColumn: $$MenseTableReferences
                                ._gestoreIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (utenteMensePreferiteRefs)
                        await $_getPrefetchedData<
                          MenseData,
                          $MenseTable,
                          UtenteMensePreferiteData
                        >(
                          currentTable: table,
                          referencedTable: $$MenseTableReferences
                              ._utenteMensePreferiteRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MenseTableReferences(
                                db,
                                table,
                                p0,
                              ).utenteMensePreferiteRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mensaId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (orariAperturaRefs)
                        await $_getPrefetchedData<
                          MenseData,
                          $MenseTable,
                          OrariAperturaData
                        >(
                          currentTable: table,
                          referencedTable: $$MenseTableReferences
                              ._orariAperturaRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MenseTableReferences(
                                db,
                                table,
                                p0,
                              ).orariAperturaRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mensaId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (menuGiornalieriRefs)
                        await $_getPrefetchedData<
                          MenseData,
                          $MenseTable,
                          MenuGiornalieriData
                        >(
                          currentTable: table,
                          referencedTable: $$MenseTableReferences
                              ._menuGiornalieriRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MenseTableReferences(
                                db,
                                table,
                                p0,
                              ).menuGiornalieriRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mensaId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (ordiniRefs)
                        await $_getPrefetchedData<
                          MenseData,
                          $MenseTable,
                          OrdiniData
                        >(
                          currentTable: table,
                          referencedTable: $$MenseTableReferences
                              ._ordiniRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MenseTableReferences(db, table, p0).ordiniRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mensaId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MenseTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MenseTable,
      MenseData,
      $$MenseTableFilterComposer,
      $$MenseTableOrderingComposer,
      $$MenseTableAnnotationComposer,
      $$MenseTableCreateCompanionBuilder,
      $$MenseTableUpdateCompanionBuilder,
      (MenseData, $$MenseTableReferences),
      MenseData,
      PrefetchHooks Function({
        bool gestoreId,
        bool utenteMensePreferiteRefs,
        bool orariAperturaRefs,
        bool menuGiornalieriRefs,
        bool ordiniRefs,
      })
    >;
typedef $$UtenteMensePreferiteTableCreateCompanionBuilder =
    UtenteMensePreferiteCompanion Function({
      required int utenteId,
      required int mensaId,
      Value<int> rowid,
    });
typedef $$UtenteMensePreferiteTableUpdateCompanionBuilder =
    UtenteMensePreferiteCompanion Function({
      Value<int> utenteId,
      Value<int> mensaId,
      Value<int> rowid,
    });

final class $$UtenteMensePreferiteTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $UtenteMensePreferiteTable,
          UtenteMensePreferiteData
        > {
  $$UtenteMensePreferiteTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UtentiTable _utenteIdTable(_$AppDatabase db) =>
      db.utenti.createAlias('utente_mense_preferite__utente_id__utenti__id');

  $$UtentiTableProcessedTableManager get utenteId {
    final $_column = $_itemColumn<int>('utente_id')!;

    final manager = $$UtentiTableTableManager(
      $_db,
      $_db.utenti,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_utenteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MenseTable _mensaIdTable(_$AppDatabase db) =>
      db.mense.createAlias('utente_mense_preferite__mensa_id__mense__id');

  $$MenseTableProcessedTableManager get mensaId {
    final $_column = $_itemColumn<int>('mensa_id')!;

    final manager = $$MenseTableTableManager(
      $_db,
      $_db.mense,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mensaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UtenteMensePreferiteTableFilterComposer
    extends Composer<_$AppDatabase, $UtenteMensePreferiteTable> {
  $$UtenteMensePreferiteTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$UtentiTableFilterComposer get utenteId {
    final $$UtentiTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.utenteId,
      referencedTable: $db.utenti,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtentiTableFilterComposer(
            $db: $db,
            $table: $db.utenti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MenseTableFilterComposer get mensaId {
    final $$MenseTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mensaId,
      referencedTable: $db.mense,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenseTableFilterComposer(
            $db: $db,
            $table: $db.mense,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UtenteMensePreferiteTableOrderingComposer
    extends Composer<_$AppDatabase, $UtenteMensePreferiteTable> {
  $$UtenteMensePreferiteTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$UtentiTableOrderingComposer get utenteId {
    final $$UtentiTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.utenteId,
      referencedTable: $db.utenti,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtentiTableOrderingComposer(
            $db: $db,
            $table: $db.utenti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MenseTableOrderingComposer get mensaId {
    final $$MenseTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mensaId,
      referencedTable: $db.mense,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenseTableOrderingComposer(
            $db: $db,
            $table: $db.mense,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UtenteMensePreferiteTableAnnotationComposer
    extends Composer<_$AppDatabase, $UtenteMensePreferiteTable> {
  $$UtenteMensePreferiteTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$UtentiTableAnnotationComposer get utenteId {
    final $$UtentiTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.utenteId,
      referencedTable: $db.utenti,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtentiTableAnnotationComposer(
            $db: $db,
            $table: $db.utenti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MenseTableAnnotationComposer get mensaId {
    final $$MenseTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mensaId,
      referencedTable: $db.mense,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenseTableAnnotationComposer(
            $db: $db,
            $table: $db.mense,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UtenteMensePreferiteTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UtenteMensePreferiteTable,
          UtenteMensePreferiteData,
          $$UtenteMensePreferiteTableFilterComposer,
          $$UtenteMensePreferiteTableOrderingComposer,
          $$UtenteMensePreferiteTableAnnotationComposer,
          $$UtenteMensePreferiteTableCreateCompanionBuilder,
          $$UtenteMensePreferiteTableUpdateCompanionBuilder,
          (UtenteMensePreferiteData, $$UtenteMensePreferiteTableReferences),
          UtenteMensePreferiteData,
          PrefetchHooks Function({bool utenteId, bool mensaId})
        > {
  $$UtenteMensePreferiteTableTableManager(
    _$AppDatabase db,
    $UtenteMensePreferiteTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UtenteMensePreferiteTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UtenteMensePreferiteTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$UtenteMensePreferiteTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> utenteId = const Value.absent(),
                Value<int> mensaId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UtenteMensePreferiteCompanion(
                utenteId: utenteId,
                mensaId: mensaId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int utenteId,
                required int mensaId,
                Value<int> rowid = const Value.absent(),
              }) => UtenteMensePreferiteCompanion.insert(
                utenteId: utenteId,
                mensaId: mensaId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $UtenteMensePreferiteTable,
                    UtenteMensePreferiteData
                  >(table),
                  $$UtenteMensePreferiteTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({utenteId = false, mensaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (utenteId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.utenteId,
                        referencedTable: $$UtenteMensePreferiteTableReferences
                            ._utenteIdTable(db),
                        referencedColumn: $$UtenteMensePreferiteTableReferences
                            ._utenteIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (mensaId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.mensaId,
                        referencedTable: $$UtenteMensePreferiteTableReferences
                            ._mensaIdTable(db),
                        referencedColumn: $$UtenteMensePreferiteTableReferences
                            ._mensaIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UtenteMensePreferiteTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UtenteMensePreferiteTable,
      UtenteMensePreferiteData,
      $$UtenteMensePreferiteTableFilterComposer,
      $$UtenteMensePreferiteTableOrderingComposer,
      $$UtenteMensePreferiteTableAnnotationComposer,
      $$UtenteMensePreferiteTableCreateCompanionBuilder,
      $$UtenteMensePreferiteTableUpdateCompanionBuilder,
      (UtenteMensePreferiteData, $$UtenteMensePreferiteTableReferences),
      UtenteMensePreferiteData,
      PrefetchHooks Function({bool utenteId, bool mensaId})
    >;
typedef $$PastoAllergieTableCreateCompanionBuilder =
    PastoAllergieCompanion Function({
      required int pastoId,
      required int allergiaId,
      Value<int> rowid,
    });
typedef $$PastoAllergieTableUpdateCompanionBuilder =
    PastoAllergieCompanion Function({
      Value<int> pastoId,
      Value<int> allergiaId,
      Value<int> rowid,
    });

final class $$PastoAllergieTableReferences
    extends
        BaseReferences<_$AppDatabase, $PastoAllergieTable, PastoAllergieData> {
  $$PastoAllergieTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PastiTable _pastoIdTable(_$AppDatabase db) =>
      db.pasti.createAlias('pasto_allergie__pasto_id__pasti__id');

  $$PastiTableProcessedTableManager get pastoId {
    final $_column = $_itemColumn<int>('pasto_id')!;

    final manager = $$PastiTableTableManager(
      $_db,
      $_db.pasti,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pastoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AllergieTable _allergiaIdTable(_$AppDatabase db) =>
      db.allergie.createAlias('pasto_allergie__allergia_id__allergie__id');

  $$AllergieTableProcessedTableManager get allergiaId {
    final $_column = $_itemColumn<int>('allergia_id')!;

    final manager = $$AllergieTableTableManager(
      $_db,
      $_db.allergie,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_allergiaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PastoAllergieTableFilterComposer
    extends Composer<_$AppDatabase, $PastoAllergieTable> {
  $$PastoAllergieTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PastiTableFilterComposer get pastoId {
    final $$PastiTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pastoId,
      referencedTable: $db.pasti,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PastiTableFilterComposer(
            $db: $db,
            $table: $db.pasti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AllergieTableFilterComposer get allergiaId {
    final $$AllergieTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.allergiaId,
      referencedTable: $db.allergie,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AllergieTableFilterComposer(
            $db: $db,
            $table: $db.allergie,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PastoAllergieTableOrderingComposer
    extends Composer<_$AppDatabase, $PastoAllergieTable> {
  $$PastoAllergieTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PastiTableOrderingComposer get pastoId {
    final $$PastiTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pastoId,
      referencedTable: $db.pasti,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PastiTableOrderingComposer(
            $db: $db,
            $table: $db.pasti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AllergieTableOrderingComposer get allergiaId {
    final $$AllergieTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.allergiaId,
      referencedTable: $db.allergie,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AllergieTableOrderingComposer(
            $db: $db,
            $table: $db.allergie,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PastoAllergieTableAnnotationComposer
    extends Composer<_$AppDatabase, $PastoAllergieTable> {
  $$PastoAllergieTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PastiTableAnnotationComposer get pastoId {
    final $$PastiTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pastoId,
      referencedTable: $db.pasti,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PastiTableAnnotationComposer(
            $db: $db,
            $table: $db.pasti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AllergieTableAnnotationComposer get allergiaId {
    final $$AllergieTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.allergiaId,
      referencedTable: $db.allergie,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AllergieTableAnnotationComposer(
            $db: $db,
            $table: $db.allergie,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PastoAllergieTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PastoAllergieTable,
          PastoAllergieData,
          $$PastoAllergieTableFilterComposer,
          $$PastoAllergieTableOrderingComposer,
          $$PastoAllergieTableAnnotationComposer,
          $$PastoAllergieTableCreateCompanionBuilder,
          $$PastoAllergieTableUpdateCompanionBuilder,
          (PastoAllergieData, $$PastoAllergieTableReferences),
          PastoAllergieData,
          PrefetchHooks Function({bool pastoId, bool allergiaId})
        > {
  $$PastoAllergieTableTableManager(_$AppDatabase db, $PastoAllergieTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PastoAllergieTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PastoAllergieTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PastoAllergieTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> pastoId = const Value.absent(),
                Value<int> allergiaId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PastoAllergieCompanion(
                pastoId: pastoId,
                allergiaId: allergiaId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int pastoId,
                required int allergiaId,
                Value<int> rowid = const Value.absent(),
              }) => PastoAllergieCompanion.insert(
                pastoId: pastoId,
                allergiaId: allergiaId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PastoAllergieTable, PastoAllergieData>(table),
                  $$PastoAllergieTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pastoId = false, allergiaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (pastoId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.pastoId,
                        referencedTable: $$PastoAllergieTableReferences
                            ._pastoIdTable(db),
                        referencedColumn: $$PastoAllergieTableReferences
                            ._pastoIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (allergiaId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.allergiaId,
                        referencedTable: $$PastoAllergieTableReferences
                            ._allergiaIdTable(db),
                        referencedColumn: $$PastoAllergieTableReferences
                            ._allergiaIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PastoAllergieTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PastoAllergieTable,
      PastoAllergieData,
      $$PastoAllergieTableFilterComposer,
      $$PastoAllergieTableOrderingComposer,
      $$PastoAllergieTableAnnotationComposer,
      $$PastoAllergieTableCreateCompanionBuilder,
      $$PastoAllergieTableUpdateCompanionBuilder,
      (PastoAllergieData, $$PastoAllergieTableReferences),
      PastoAllergieData,
      PrefetchHooks Function({bool pastoId, bool allergiaId})
    >;
typedef $$PastoPreferenzeTableCreateCompanionBuilder =
    PastoPreferenzeCompanion Function({
      required int pastoId,
      required int preferenzaId,
      Value<int> rowid,
    });
typedef $$PastoPreferenzeTableUpdateCompanionBuilder =
    PastoPreferenzeCompanion Function({
      Value<int> pastoId,
      Value<int> preferenzaId,
      Value<int> rowid,
    });

final class $$PastoPreferenzeTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PastoPreferenzeTable,
          PastoPreferenzeData
        > {
  $$PastoPreferenzeTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PastiTable _pastoIdTable(_$AppDatabase db) =>
      db.pasti.createAlias('pasto_preferenze__pasto_id__pasti__id');

  $$PastiTableProcessedTableManager get pastoId {
    final $_column = $_itemColumn<int>('pasto_id')!;

    final manager = $$PastiTableTableManager(
      $_db,
      $_db.pasti,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pastoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PreferenzeTable _preferenzaIdTable(_$AppDatabase db) => db.preferenze
      .createAlias('pasto_preferenze__preferenza_id__preferenze__id');

  $$PreferenzeTableProcessedTableManager get preferenzaId {
    final $_column = $_itemColumn<int>('preferenza_id')!;

    final manager = $$PreferenzeTableTableManager(
      $_db,
      $_db.preferenze,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_preferenzaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PastoPreferenzeTableFilterComposer
    extends Composer<_$AppDatabase, $PastoPreferenzeTable> {
  $$PastoPreferenzeTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PastiTableFilterComposer get pastoId {
    final $$PastiTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pastoId,
      referencedTable: $db.pasti,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PastiTableFilterComposer(
            $db: $db,
            $table: $db.pasti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PreferenzeTableFilterComposer get preferenzaId {
    final $$PreferenzeTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.preferenzaId,
      referencedTable: $db.preferenze,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PreferenzeTableFilterComposer(
            $db: $db,
            $table: $db.preferenze,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PastoPreferenzeTableOrderingComposer
    extends Composer<_$AppDatabase, $PastoPreferenzeTable> {
  $$PastoPreferenzeTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PastiTableOrderingComposer get pastoId {
    final $$PastiTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pastoId,
      referencedTable: $db.pasti,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PastiTableOrderingComposer(
            $db: $db,
            $table: $db.pasti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PreferenzeTableOrderingComposer get preferenzaId {
    final $$PreferenzeTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.preferenzaId,
      referencedTable: $db.preferenze,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PreferenzeTableOrderingComposer(
            $db: $db,
            $table: $db.preferenze,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PastoPreferenzeTableAnnotationComposer
    extends Composer<_$AppDatabase, $PastoPreferenzeTable> {
  $$PastoPreferenzeTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PastiTableAnnotationComposer get pastoId {
    final $$PastiTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pastoId,
      referencedTable: $db.pasti,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PastiTableAnnotationComposer(
            $db: $db,
            $table: $db.pasti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PreferenzeTableAnnotationComposer get preferenzaId {
    final $$PreferenzeTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.preferenzaId,
      referencedTable: $db.preferenze,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PreferenzeTableAnnotationComposer(
            $db: $db,
            $table: $db.preferenze,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PastoPreferenzeTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PastoPreferenzeTable,
          PastoPreferenzeData,
          $$PastoPreferenzeTableFilterComposer,
          $$PastoPreferenzeTableOrderingComposer,
          $$PastoPreferenzeTableAnnotationComposer,
          $$PastoPreferenzeTableCreateCompanionBuilder,
          $$PastoPreferenzeTableUpdateCompanionBuilder,
          (PastoPreferenzeData, $$PastoPreferenzeTableReferences),
          PastoPreferenzeData,
          PrefetchHooks Function({bool pastoId, bool preferenzaId})
        > {
  $$PastoPreferenzeTableTableManager(
    _$AppDatabase db,
    $PastoPreferenzeTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PastoPreferenzeTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PastoPreferenzeTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PastoPreferenzeTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> pastoId = const Value.absent(),
                Value<int> preferenzaId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PastoPreferenzeCompanion(
                pastoId: pastoId,
                preferenzaId: preferenzaId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int pastoId,
                required int preferenzaId,
                Value<int> rowid = const Value.absent(),
              }) => PastoPreferenzeCompanion.insert(
                pastoId: pastoId,
                preferenzaId: preferenzaId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PastoPreferenzeTable, PastoPreferenzeData>(
                    table,
                  ),
                  $$PastoPreferenzeTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pastoId = false, preferenzaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (pastoId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.pastoId,
                        referencedTable: $$PastoPreferenzeTableReferences
                            ._pastoIdTable(db),
                        referencedColumn: $$PastoPreferenzeTableReferences
                            ._pastoIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (preferenzaId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.preferenzaId,
                        referencedTable: $$PastoPreferenzeTableReferences
                            ._preferenzaIdTable(db),
                        referencedColumn: $$PastoPreferenzeTableReferences
                            ._preferenzaIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PastoPreferenzeTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PastoPreferenzeTable,
      PastoPreferenzeData,
      $$PastoPreferenzeTableFilterComposer,
      $$PastoPreferenzeTableOrderingComposer,
      $$PastoPreferenzeTableAnnotationComposer,
      $$PastoPreferenzeTableCreateCompanionBuilder,
      $$PastoPreferenzeTableUpdateCompanionBuilder,
      (PastoPreferenzeData, $$PastoPreferenzeTableReferences),
      PastoPreferenzeData,
      PrefetchHooks Function({bool pastoId, bool preferenzaId})
    >;
typedef $$OrariAperturaTableCreateCompanionBuilder =
    OrariAperturaCompanion Function({
      Value<int> id,
      required int mensaId,
      required String giorno,
      required int aperturaMinuti,
      required int chiusuraMinuti,
    });
typedef $$OrariAperturaTableUpdateCompanionBuilder =
    OrariAperturaCompanion Function({
      Value<int> id,
      Value<int> mensaId,
      Value<String> giorno,
      Value<int> aperturaMinuti,
      Value<int> chiusuraMinuti,
    });

final class $$OrariAperturaTableReferences
    extends
        BaseReferences<_$AppDatabase, $OrariAperturaTable, OrariAperturaData> {
  $$OrariAperturaTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MenseTable _mensaIdTable(_$AppDatabase db) =>
      db.mense.createAlias('orari_apertura__mensa_id__mense__id');

  $$MenseTableProcessedTableManager get mensaId {
    final $_column = $_itemColumn<int>('mensa_id')!;

    final manager = $$MenseTableTableManager(
      $_db,
      $_db.mense,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mensaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$OrariAperturaTableFilterComposer
    extends Composer<_$AppDatabase, $OrariAperturaTable> {
  $$OrariAperturaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get giorno => $composableBuilder(
    column: $table.giorno,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get aperturaMinuti => $composableBuilder(
    column: $table.aperturaMinuti,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chiusuraMinuti => $composableBuilder(
    column: $table.chiusuraMinuti,
    builder: (column) => ColumnFilters(column),
  );

  $$MenseTableFilterComposer get mensaId {
    final $$MenseTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mensaId,
      referencedTable: $db.mense,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenseTableFilterComposer(
            $db: $db,
            $table: $db.mense,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrariAperturaTableOrderingComposer
    extends Composer<_$AppDatabase, $OrariAperturaTable> {
  $$OrariAperturaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get giorno => $composableBuilder(
    column: $table.giorno,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get aperturaMinuti => $composableBuilder(
    column: $table.aperturaMinuti,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chiusuraMinuti => $composableBuilder(
    column: $table.chiusuraMinuti,
    builder: (column) => ColumnOrderings(column),
  );

  $$MenseTableOrderingComposer get mensaId {
    final $$MenseTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mensaId,
      referencedTable: $db.mense,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenseTableOrderingComposer(
            $db: $db,
            $table: $db.mense,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrariAperturaTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrariAperturaTable> {
  $$OrariAperturaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get giorno =>
      $composableBuilder(column: $table.giorno, builder: (column) => column);

  GeneratedColumn<int> get aperturaMinuti => $composableBuilder(
    column: $table.aperturaMinuti,
    builder: (column) => column,
  );

  GeneratedColumn<int> get chiusuraMinuti => $composableBuilder(
    column: $table.chiusuraMinuti,
    builder: (column) => column,
  );

  $$MenseTableAnnotationComposer get mensaId {
    final $$MenseTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mensaId,
      referencedTable: $db.mense,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenseTableAnnotationComposer(
            $db: $db,
            $table: $db.mense,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrariAperturaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OrariAperturaTable,
          OrariAperturaData,
          $$OrariAperturaTableFilterComposer,
          $$OrariAperturaTableOrderingComposer,
          $$OrariAperturaTableAnnotationComposer,
          $$OrariAperturaTableCreateCompanionBuilder,
          $$OrariAperturaTableUpdateCompanionBuilder,
          (OrariAperturaData, $$OrariAperturaTableReferences),
          OrariAperturaData,
          PrefetchHooks Function({bool mensaId})
        > {
  $$OrariAperturaTableTableManager(_$AppDatabase db, $OrariAperturaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrariAperturaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrariAperturaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrariAperturaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> mensaId = const Value.absent(),
                Value<String> giorno = const Value.absent(),
                Value<int> aperturaMinuti = const Value.absent(),
                Value<int> chiusuraMinuti = const Value.absent(),
              }) => OrariAperturaCompanion(
                id: id,
                mensaId: mensaId,
                giorno: giorno,
                aperturaMinuti: aperturaMinuti,
                chiusuraMinuti: chiusuraMinuti,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int mensaId,
                required String giorno,
                required int aperturaMinuti,
                required int chiusuraMinuti,
              }) => OrariAperturaCompanion.insert(
                id: id,
                mensaId: mensaId,
                giorno: giorno,
                aperturaMinuti: aperturaMinuti,
                chiusuraMinuti: chiusuraMinuti,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$OrariAperturaTable, OrariAperturaData>(table),
                  $$OrariAperturaTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mensaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (mensaId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.mensaId,
                        referencedTable: $$OrariAperturaTableReferences
                            ._mensaIdTable(db),
                        referencedColumn: $$OrariAperturaTableReferences
                            ._mensaIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$OrariAperturaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OrariAperturaTable,
      OrariAperturaData,
      $$OrariAperturaTableFilterComposer,
      $$OrariAperturaTableOrderingComposer,
      $$OrariAperturaTableAnnotationComposer,
      $$OrariAperturaTableCreateCompanionBuilder,
      $$OrariAperturaTableUpdateCompanionBuilder,
      (OrariAperturaData, $$OrariAperturaTableReferences),
      OrariAperturaData,
      PrefetchHooks Function({bool mensaId})
    >;
typedef $$MenuGiornalieriTableCreateCompanionBuilder =
    MenuGiornalieriCompanion Function({
      required int mensaId,
      required int pastoId,
      required String data,
      Value<int?> quantitaDisponibile,
      Value<int> rowid,
    });
typedef $$MenuGiornalieriTableUpdateCompanionBuilder =
    MenuGiornalieriCompanion Function({
      Value<int> mensaId,
      Value<int> pastoId,
      Value<String> data,
      Value<int?> quantitaDisponibile,
      Value<int> rowid,
    });

final class $$MenuGiornalieriTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MenuGiornalieriTable,
          MenuGiornalieriData
        > {
  $$MenuGiornalieriTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MenseTable _mensaIdTable(_$AppDatabase db) =>
      db.mense.createAlias('menu_giornalieri__mensa_id__mense__id');

  $$MenseTableProcessedTableManager get mensaId {
    final $_column = $_itemColumn<int>('mensa_id')!;

    final manager = $$MenseTableTableManager(
      $_db,
      $_db.mense,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mensaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PastiTable _pastoIdTable(_$AppDatabase db) =>
      db.pasti.createAlias('menu_giornalieri__pasto_id__pasti__id');

  $$PastiTableProcessedTableManager get pastoId {
    final $_column = $_itemColumn<int>('pasto_id')!;

    final manager = $$PastiTableTableManager(
      $_db,
      $_db.pasti,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pastoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MenuGiornalieriTableFilterComposer
    extends Composer<_$AppDatabase, $MenuGiornalieriTable> {
  $$MenuGiornalieriTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantitaDisponibile => $composableBuilder(
    column: $table.quantitaDisponibile,
    builder: (column) => ColumnFilters(column),
  );

  $$MenseTableFilterComposer get mensaId {
    final $$MenseTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mensaId,
      referencedTable: $db.mense,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenseTableFilterComposer(
            $db: $db,
            $table: $db.mense,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PastiTableFilterComposer get pastoId {
    final $$PastiTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pastoId,
      referencedTable: $db.pasti,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PastiTableFilterComposer(
            $db: $db,
            $table: $db.pasti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MenuGiornalieriTableOrderingComposer
    extends Composer<_$AppDatabase, $MenuGiornalieriTable> {
  $$MenuGiornalieriTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantitaDisponibile => $composableBuilder(
    column: $table.quantitaDisponibile,
    builder: (column) => ColumnOrderings(column),
  );

  $$MenseTableOrderingComposer get mensaId {
    final $$MenseTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mensaId,
      referencedTable: $db.mense,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenseTableOrderingComposer(
            $db: $db,
            $table: $db.mense,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PastiTableOrderingComposer get pastoId {
    final $$PastiTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pastoId,
      referencedTable: $db.pasti,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PastiTableOrderingComposer(
            $db: $db,
            $table: $db.pasti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MenuGiornalieriTableAnnotationComposer
    extends Composer<_$AppDatabase, $MenuGiornalieriTable> {
  $$MenuGiornalieriTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);

  GeneratedColumn<int> get quantitaDisponibile => $composableBuilder(
    column: $table.quantitaDisponibile,
    builder: (column) => column,
  );

  $$MenseTableAnnotationComposer get mensaId {
    final $$MenseTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mensaId,
      referencedTable: $db.mense,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenseTableAnnotationComposer(
            $db: $db,
            $table: $db.mense,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PastiTableAnnotationComposer get pastoId {
    final $$PastiTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pastoId,
      referencedTable: $db.pasti,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PastiTableAnnotationComposer(
            $db: $db,
            $table: $db.pasti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MenuGiornalieriTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MenuGiornalieriTable,
          MenuGiornalieriData,
          $$MenuGiornalieriTableFilterComposer,
          $$MenuGiornalieriTableOrderingComposer,
          $$MenuGiornalieriTableAnnotationComposer,
          $$MenuGiornalieriTableCreateCompanionBuilder,
          $$MenuGiornalieriTableUpdateCompanionBuilder,
          (MenuGiornalieriData, $$MenuGiornalieriTableReferences),
          MenuGiornalieriData,
          PrefetchHooks Function({bool mensaId, bool pastoId})
        > {
  $$MenuGiornalieriTableTableManager(
    _$AppDatabase db,
    $MenuGiornalieriTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MenuGiornalieriTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MenuGiornalieriTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MenuGiornalieriTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> mensaId = const Value.absent(),
                Value<int> pastoId = const Value.absent(),
                Value<String> data = const Value.absent(),
                Value<int?> quantitaDisponibile = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MenuGiornalieriCompanion(
                mensaId: mensaId,
                pastoId: pastoId,
                data: data,
                quantitaDisponibile: quantitaDisponibile,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int mensaId,
                required int pastoId,
                required String data,
                Value<int?> quantitaDisponibile = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MenuGiornalieriCompanion.insert(
                mensaId: mensaId,
                pastoId: pastoId,
                data: data,
                quantitaDisponibile: quantitaDisponibile,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MenuGiornalieriTable, MenuGiornalieriData>(
                    table,
                  ),
                  $$MenuGiornalieriTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mensaId = false, pastoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (mensaId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.mensaId,
                        referencedTable: $$MenuGiornalieriTableReferences
                            ._mensaIdTable(db),
                        referencedColumn: $$MenuGiornalieriTableReferences
                            ._mensaIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (pastoId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.pastoId,
                        referencedTable: $$MenuGiornalieriTableReferences
                            ._pastoIdTable(db),
                        referencedColumn: $$MenuGiornalieriTableReferences
                            ._pastoIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MenuGiornalieriTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MenuGiornalieriTable,
      MenuGiornalieriData,
      $$MenuGiornalieriTableFilterComposer,
      $$MenuGiornalieriTableOrderingComposer,
      $$MenuGiornalieriTableAnnotationComposer,
      $$MenuGiornalieriTableCreateCompanionBuilder,
      $$MenuGiornalieriTableUpdateCompanionBuilder,
      (MenuGiornalieriData, $$MenuGiornalieriTableReferences),
      MenuGiornalieriData,
      PrefetchHooks Function({bool mensaId, bool pastoId})
    >;
typedef $$OrdiniTableCreateCompanionBuilder = OrdiniCompanion Function({
  Value<int> id,
  required int utenteId,
  required int mensaId,
  required DateTime giornoRitiro,
  required String orarioRitiro,
  Value<String> nota,
  Value<double> totale,
  Value<int> piattiTotali,
  Value<DateTime> dataInvio,
  Value<String> stato,
});
typedef $$OrdiniTableUpdateCompanionBuilder = OrdiniCompanion Function({
  Value<int> id,
  Value<int> utenteId,
  Value<int> mensaId,
  Value<DateTime> giornoRitiro,
  Value<String> orarioRitiro,
  Value<String> nota,
  Value<double> totale,
  Value<int> piattiTotali,
  Value<DateTime> dataInvio,
  Value<String> stato,
});

final class $$OrdiniTableReferences
    extends BaseReferences<_$AppDatabase, $OrdiniTable, OrdiniData> {
  $$OrdiniTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UtentiTable _utenteIdTable(_$AppDatabase db) =>
      db.utenti.createAlias('ordini__utente_id__utenti__id');

  $$UtentiTableProcessedTableManager get utenteId {
    final $_column = $_itemColumn<int>('utente_id')!;

    final manager = $$UtentiTableTableManager(
      $_db,
      $_db.utenti,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_utenteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MenseTable _mensaIdTable(_$AppDatabase db) =>
      db.mense.createAlias('ordini__mensa_id__mense__id');

  $$MenseTableProcessedTableManager get mensaId {
    final $_column = $_itemColumn<int>('mensa_id')!;

    final manager = $$MenseTableTableManager(
      $_db,
      $_db.mense,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mensaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$OrdinePiattiTable, List<OrdinePiattiData>>
  _ordinePiattiRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.ordinePiatti,
    aliasName: 'ordini__id__ordine_piatti__ordine_id',
  );

  $$OrdinePiattiTableProcessedTableManager get ordinePiattiRefs {
    final manager = $$OrdinePiattiTableTableManager(
      $_db,
      $_db.ordinePiatti,
    ).filter((f) => f.ordineId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ordinePiattiRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$OrdiniTableFilterComposer
    extends Composer<_$AppDatabase, $OrdiniTable> {
  $$OrdiniTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get giornoRitiro => $composableBuilder(
    column: $table.giornoRitiro,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get orarioRitiro => $composableBuilder(
    column: $table.orarioRitiro,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nota => $composableBuilder(
    column: $table.nota,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totale => $composableBuilder(
    column: $table.totale,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get piattiTotali => $composableBuilder(
    column: $table.piattiTotali,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dataInvio => $composableBuilder(
    column: $table.dataInvio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stato => $composableBuilder(
    column: $table.stato,
    builder: (column) => ColumnFilters(column),
  );

  $$UtentiTableFilterComposer get utenteId {
    final $$UtentiTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.utenteId,
      referencedTable: $db.utenti,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtentiTableFilterComposer(
            $db: $db,
            $table: $db.utenti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MenseTableFilterComposer get mensaId {
    final $$MenseTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mensaId,
      referencedTable: $db.mense,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenseTableFilterComposer(
            $db: $db,
            $table: $db.mense,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> ordinePiattiRefs(
    Expression<bool> Function($$OrdinePiattiTableFilterComposer f) f,
  ) {
    final $$OrdinePiattiTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ordinePiatti,
      getReferencedColumn: (t) => t.ordineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdinePiattiTableFilterComposer(
            $db: $db,
            $table: $db.ordinePiatti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$OrdiniTableOrderingComposer
    extends Composer<_$AppDatabase, $OrdiniTable> {
  $$OrdiniTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get giornoRitiro => $composableBuilder(
    column: $table.giornoRitiro,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get orarioRitiro => $composableBuilder(
    column: $table.orarioRitiro,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nota => $composableBuilder(
    column: $table.nota,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totale => $composableBuilder(
    column: $table.totale,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get piattiTotali => $composableBuilder(
    column: $table.piattiTotali,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dataInvio => $composableBuilder(
    column: $table.dataInvio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stato => $composableBuilder(
    column: $table.stato,
    builder: (column) => ColumnOrderings(column),
  );

  $$UtentiTableOrderingComposer get utenteId {
    final $$UtentiTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.utenteId,
      referencedTable: $db.utenti,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtentiTableOrderingComposer(
            $db: $db,
            $table: $db.utenti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MenseTableOrderingComposer get mensaId {
    final $$MenseTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mensaId,
      referencedTable: $db.mense,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenseTableOrderingComposer(
            $db: $db,
            $table: $db.mense,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrdiniTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrdiniTable> {
  $$OrdiniTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get giornoRitiro => $composableBuilder(
    column: $table.giornoRitiro,
    builder: (column) => column,
  );

  GeneratedColumn<String> get orarioRitiro => $composableBuilder(
    column: $table.orarioRitiro,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nota =>
      $composableBuilder(column: $table.nota, builder: (column) => column);

  GeneratedColumn<double> get totale =>
      $composableBuilder(column: $table.totale, builder: (column) => column);

  GeneratedColumn<int> get piattiTotali => $composableBuilder(
    column: $table.piattiTotali,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dataInvio =>
      $composableBuilder(column: $table.dataInvio, builder: (column) => column);

  GeneratedColumn<String> get stato =>
      $composableBuilder(column: $table.stato, builder: (column) => column);

  $$UtentiTableAnnotationComposer get utenteId {
    final $$UtentiTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.utenteId,
      referencedTable: $db.utenti,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtentiTableAnnotationComposer(
            $db: $db,
            $table: $db.utenti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MenseTableAnnotationComposer get mensaId {
    final $$MenseTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mensaId,
      referencedTable: $db.mense,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenseTableAnnotationComposer(
            $db: $db,
            $table: $db.mense,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> ordinePiattiRefs<T extends Object>(
    Expression<T> Function($$OrdinePiattiTableAnnotationComposer a) f,
  ) {
    final $$OrdinePiattiTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ordinePiatti,
      getReferencedColumn: (t) => t.ordineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdinePiattiTableAnnotationComposer(
            $db: $db,
            $table: $db.ordinePiatti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$OrdiniTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OrdiniTable,
          OrdiniData,
          $$OrdiniTableFilterComposer,
          $$OrdiniTableOrderingComposer,
          $$OrdiniTableAnnotationComposer,
          $$OrdiniTableCreateCompanionBuilder,
          $$OrdiniTableUpdateCompanionBuilder,
          (OrdiniData, $$OrdiniTableReferences),
          OrdiniData,
          PrefetchHooks Function({
            bool utenteId,
            bool mensaId,
            bool ordinePiattiRefs,
          })
        > {
  $$OrdiniTableTableManager(_$AppDatabase db, $OrdiniTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrdiniTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrdiniTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrdiniTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> utenteId = const Value.absent(),
                Value<int> mensaId = const Value.absent(),
                Value<DateTime> giornoRitiro = const Value.absent(),
                Value<String> orarioRitiro = const Value.absent(),
                Value<String> nota = const Value.absent(),
                Value<double> totale = const Value.absent(),
                Value<int> piattiTotali = const Value.absent(),
                Value<DateTime> dataInvio = const Value.absent(),
                Value<String> stato = const Value.absent(),
              }) => OrdiniCompanion(
                id: id,
                utenteId: utenteId,
                mensaId: mensaId,
                giornoRitiro: giornoRitiro,
                orarioRitiro: orarioRitiro,
                nota: nota,
                totale: totale,
                piattiTotali: piattiTotali,
                dataInvio: dataInvio,
                stato: stato,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int utenteId,
                required int mensaId,
                required DateTime giornoRitiro,
                required String orarioRitiro,
                Value<String> nota = const Value.absent(),
                Value<double> totale = const Value.absent(),
                Value<int> piattiTotali = const Value.absent(),
                Value<DateTime> dataInvio = const Value.absent(),
                Value<String> stato = const Value.absent(),
              }) => OrdiniCompanion.insert(
                id: id,
                utenteId: utenteId,
                mensaId: mensaId,
                giornoRitiro: giornoRitiro,
                orarioRitiro: orarioRitiro,
                nota: nota,
                totale: totale,
                piattiTotali: piattiTotali,
                dataInvio: dataInvio,
                stato: stato,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$OrdiniTable, OrdiniData>(table),
                  $$OrdiniTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({utenteId = false, mensaId = false, ordinePiattiRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (ordinePiattiRefs) db.ordinePiatti,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (utenteId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.utenteId,
                            referencedTable: $$OrdiniTableReferences
                                ._utenteIdTable(db),
                            referencedColumn: $$OrdiniTableReferences
                                ._utenteIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (mensaId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.mensaId,
                            referencedTable: $$OrdiniTableReferences
                                ._mensaIdTable(db),
                            referencedColumn: $$OrdiniTableReferences
                                ._mensaIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (ordinePiattiRefs)
                        await $_getPrefetchedData<
                          OrdiniData,
                          $OrdiniTable,
                          OrdinePiattiData
                        >(
                          currentTable: table,
                          referencedTable: $$OrdiniTableReferences
                              ._ordinePiattiRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OrdiniTableReferences(
                                db,
                                table,
                                p0,
                              ).ordinePiattiRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ordineId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$OrdiniTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OrdiniTable,
      OrdiniData,
      $$OrdiniTableFilterComposer,
      $$OrdiniTableOrderingComposer,
      $$OrdiniTableAnnotationComposer,
      $$OrdiniTableCreateCompanionBuilder,
      $$OrdiniTableUpdateCompanionBuilder,
      (OrdiniData, $$OrdiniTableReferences),
      OrdiniData,
      PrefetchHooks Function({
        bool utenteId,
        bool mensaId,
        bool ordinePiattiRefs,
      })
    >;
typedef $$OrdinePiattiTableCreateCompanionBuilder =
    OrdinePiattiCompanion Function({
      Value<int> id,
      required int ordineId,
      required int pastoId,
      required String nomePasto,
      Value<double> prezzo,
      Value<int> quantita,
    });
typedef $$OrdinePiattiTableUpdateCompanionBuilder =
    OrdinePiattiCompanion Function({
      Value<int> id,
      Value<int> ordineId,
      Value<int> pastoId,
      Value<String> nomePasto,
      Value<double> prezzo,
      Value<int> quantita,
    });

final class $$OrdinePiattiTableReferences
    extends
        BaseReferences<_$AppDatabase, $OrdinePiattiTable, OrdinePiattiData> {
  $$OrdinePiattiTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OrdiniTable _ordineIdTable(_$AppDatabase db) =>
      db.ordini.createAlias('ordine_piatti__ordine_id__ordini__id');

  $$OrdiniTableProcessedTableManager get ordineId {
    final $_column = $_itemColumn<int>('ordine_id')!;

    final manager = $$OrdiniTableTableManager(
      $_db,
      $_db.ordini,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ordineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PastiTable _pastoIdTable(_$AppDatabase db) =>
      db.pasti.createAlias('ordine_piatti__pasto_id__pasti__id');

  $$PastiTableProcessedTableManager get pastoId {
    final $_column = $_itemColumn<int>('pasto_id')!;

    final manager = $$PastiTableTableManager(
      $_db,
      $_db.pasti,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pastoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$OrdinePiattiTableFilterComposer
    extends Composer<_$AppDatabase, $OrdinePiattiTable> {
  $$OrdinePiattiTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nomePasto => $composableBuilder(
    column: $table.nomePasto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get prezzo => $composableBuilder(
    column: $table.prezzo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantita => $composableBuilder(
    column: $table.quantita,
    builder: (column) => ColumnFilters(column),
  );

  $$OrdiniTableFilterComposer get ordineId {
    final $$OrdiniTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ordineId,
      referencedTable: $db.ordini,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdiniTableFilterComposer(
            $db: $db,
            $table: $db.ordini,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PastiTableFilterComposer get pastoId {
    final $$PastiTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pastoId,
      referencedTable: $db.pasti,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PastiTableFilterComposer(
            $db: $db,
            $table: $db.pasti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrdinePiattiTableOrderingComposer
    extends Composer<_$AppDatabase, $OrdinePiattiTable> {
  $$OrdinePiattiTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nomePasto => $composableBuilder(
    column: $table.nomePasto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get prezzo => $composableBuilder(
    column: $table.prezzo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantita => $composableBuilder(
    column: $table.quantita,
    builder: (column) => ColumnOrderings(column),
  );

  $$OrdiniTableOrderingComposer get ordineId {
    final $$OrdiniTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ordineId,
      referencedTable: $db.ordini,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdiniTableOrderingComposer(
            $db: $db,
            $table: $db.ordini,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PastiTableOrderingComposer get pastoId {
    final $$PastiTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pastoId,
      referencedTable: $db.pasti,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PastiTableOrderingComposer(
            $db: $db,
            $table: $db.pasti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrdinePiattiTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrdinePiattiTable> {
  $$OrdinePiattiTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nomePasto =>
      $composableBuilder(column: $table.nomePasto, builder: (column) => column);

  GeneratedColumn<double> get prezzo =>
      $composableBuilder(column: $table.prezzo, builder: (column) => column);

  GeneratedColumn<int> get quantita =>
      $composableBuilder(column: $table.quantita, builder: (column) => column);

  $$OrdiniTableAnnotationComposer get ordineId {
    final $$OrdiniTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ordineId,
      referencedTable: $db.ordini,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdiniTableAnnotationComposer(
            $db: $db,
            $table: $db.ordini,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PastiTableAnnotationComposer get pastoId {
    final $$PastiTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pastoId,
      referencedTable: $db.pasti,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PastiTableAnnotationComposer(
            $db: $db,
            $table: $db.pasti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrdinePiattiTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OrdinePiattiTable,
          OrdinePiattiData,
          $$OrdinePiattiTableFilterComposer,
          $$OrdinePiattiTableOrderingComposer,
          $$OrdinePiattiTableAnnotationComposer,
          $$OrdinePiattiTableCreateCompanionBuilder,
          $$OrdinePiattiTableUpdateCompanionBuilder,
          (OrdinePiattiData, $$OrdinePiattiTableReferences),
          OrdinePiattiData,
          PrefetchHooks Function({bool ordineId, bool pastoId})
        > {
  $$OrdinePiattiTableTableManager(_$AppDatabase db, $OrdinePiattiTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrdinePiattiTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrdinePiattiTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrdinePiattiTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> ordineId = const Value.absent(),
                Value<int> pastoId = const Value.absent(),
                Value<String> nomePasto = const Value.absent(),
                Value<double> prezzo = const Value.absent(),
                Value<int> quantita = const Value.absent(),
              }) => OrdinePiattiCompanion(
                id: id,
                ordineId: ordineId,
                pastoId: pastoId,
                nomePasto: nomePasto,
                prezzo: prezzo,
                quantita: quantita,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int ordineId,
                required int pastoId,
                required String nomePasto,
                Value<double> prezzo = const Value.absent(),
                Value<int> quantita = const Value.absent(),
              }) => OrdinePiattiCompanion.insert(
                id: id,
                ordineId: ordineId,
                pastoId: pastoId,
                nomePasto: nomePasto,
                prezzo: prezzo,
                quantita: quantita,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$OrdinePiattiTable, OrdinePiattiData>(table),
                  $$OrdinePiattiTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ordineId = false, pastoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (ordineId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.ordineId,
                        referencedTable: $$OrdinePiattiTableReferences
                            ._ordineIdTable(db),
                        referencedColumn: $$OrdinePiattiTableReferences
                            ._ordineIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (pastoId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.pastoId,
                        referencedTable: $$OrdinePiattiTableReferences
                            ._pastoIdTable(db),
                        referencedColumn: $$OrdinePiattiTableReferences
                            ._pastoIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$OrdinePiattiTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OrdinePiattiTable,
      OrdinePiattiData,
      $$OrdinePiattiTableFilterComposer,
      $$OrdinePiattiTableOrderingComposer,
      $$OrdinePiattiTableAnnotationComposer,
      $$OrdinePiattiTableCreateCompanionBuilder,
      $$OrdinePiattiTableUpdateCompanionBuilder,
      (OrdinePiattiData, $$OrdinePiattiTableReferences),
      OrdinePiattiData,
      PrefetchHooks Function({bool ordineId, bool pastoId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PastiTableTableManager get pasti =>
      $$PastiTableTableManager(_db, _db.pasti);
  $$UtentiTableTableManager get utenti =>
      $$UtentiTableTableManager(_db, _db.utenti);
  $$AllergieTableTableManager get allergie =>
      $$AllergieTableTableManager(_db, _db.allergie);
  $$PreferenzeTableTableManager get preferenze =>
      $$PreferenzeTableTableManager(_db, _db.preferenze);
  $$UtenteAllergieTableTableManager get utenteAllergie =>
      $$UtenteAllergieTableTableManager(_db, _db.utenteAllergie);
  $$UtentePreferenzeTableTableManager get utentePreferenze =>
      $$UtentePreferenzeTableTableManager(_db, _db.utentePreferenze);
  $$GestoriTableTableManager get gestori =>
      $$GestoriTableTableManager(_db, _db.gestori);
  $$MenseTableTableManager get mense =>
      $$MenseTableTableManager(_db, _db.mense);
  $$UtenteMensePreferiteTableTableManager get utenteMensePreferite =>
      $$UtenteMensePreferiteTableTableManager(_db, _db.utenteMensePreferite);
  $$PastoAllergieTableTableManager get pastoAllergie =>
      $$PastoAllergieTableTableManager(_db, _db.pastoAllergie);
  $$PastoPreferenzeTableTableManager get pastoPreferenze =>
      $$PastoPreferenzeTableTableManager(_db, _db.pastoPreferenze);
  $$OrariAperturaTableTableManager get orariApertura =>
      $$OrariAperturaTableTableManager(_db, _db.orariApertura);
  $$MenuGiornalieriTableTableManager get menuGiornalieri =>
      $$MenuGiornalieriTableTableManager(_db, _db.menuGiornalieri);
  $$OrdiniTableTableManager get ordini =>
      $$OrdiniTableTableManager(_db, _db.ordini);
  $$OrdinePiattiTableTableManager get ordinePiatti =>
      $$OrdinePiattiTableTableManager(_db, _db.ordinePiatti);
}
