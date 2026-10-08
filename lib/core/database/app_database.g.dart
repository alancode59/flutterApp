// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SettingsEntriesTable extends SettingsEntries with TableInfo<$SettingsEntriesTable, SettingsEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings_entries';
  @override
  VerificationContext validateIntegrity(Insertable<SettingsEntry> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(_keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(_valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SettingsEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingsEntry(
      key: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $SettingsEntriesTable createAlias(String alias) {
    return $SettingsEntriesTable(attachedDatabase, alias);
  }
}

class SettingsEntry extends DataClass implements Insertable<SettingsEntry> {
  final String key;
  final String value;
  const SettingsEntry({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  SettingsEntriesCompanion toCompanion(bool nullToAbsent) {
    return SettingsEntriesCompanion(key: Value(key), value: Value(value));
  }

  factory SettingsEntry.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingsEntry(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  SettingsEntry copyWith({String? key, String? value}) =>
      SettingsEntry(key: key ?? this.key, value: value ?? this.value);
  SettingsEntry copyWithCompanion(SettingsEntriesCompanion data) {
    return SettingsEntry(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingsEntry(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingsEntry && other.key == this.key && other.value == this.value);
}

class SettingsEntriesCompanion extends UpdateCompanion<SettingsEntry> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const SettingsEntriesCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsEntriesCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<SettingsEntry> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsEntriesCompanion copyWith({Value<String>? key, Value<String>? value, Value<int>? rowid}) {
    return SettingsEntriesCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsEntriesCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories with TableInfo<$CategoriesTable, CategoryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 40),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MovementKind, String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<MovementKind>($CategoriesTable.$converterkind);
  static const VerificationMeta _sortOrderMeta = const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _archivedMeta = const VerificationMeta('archived');
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("archived" IN (0, 1))'),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, icon, color, kind, sortOrder, archived];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<CategoryRow> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(_nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(_iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('color')) {
      context.handle(_colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta, sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    if (data.containsKey('archived')) {
      context.handle(_archivedMeta, archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryRow(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      icon: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
      color: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}color'])!,
      kind: $CategoriesTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}kind'])!,
      ),
      sortOrder: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      archived: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}archived'])!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MovementKind, String, String> $converterkind =
      const EnumNameConverter<MovementKind>(MovementKind.values);
}

class CategoryRow extends DataClass implements Insertable<CategoryRow> {
  final int id;
  final String name;
  final String icon;
  final int color;
  final MovementKind kind;
  final int sortOrder;
  final bool archived;
  const CategoryRow({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.kind,
    required this.sortOrder,
    required this.archived,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['icon'] = Variable<String>(icon);
    map['color'] = Variable<int>(color);
    {
      map['kind'] = Variable<String>($CategoriesTable.$converterkind.toSql(kind));
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['archived'] = Variable<bool>(archived);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      icon: Value(icon),
      color: Value(color),
      kind: Value(kind),
      sortOrder: Value(sortOrder),
      archived: Value(archived),
    );
  }

  factory CategoryRow.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<String>(json['icon']),
      color: serializer.fromJson<int>(json['color']),
      kind: $CategoriesTable.$converterkind.fromJson(serializer.fromJson<String>(json['kind'])),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      archived: serializer.fromJson<bool>(json['archived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<String>(icon),
      'color': serializer.toJson<int>(color),
      'kind': serializer.toJson<String>($CategoriesTable.$converterkind.toJson(kind)),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'archived': serializer.toJson<bool>(archived),
    };
  }

  CategoryRow copyWith({
    int? id,
    String? name,
    String? icon,
    int? color,
    MovementKind? kind,
    int? sortOrder,
    bool? archived,
  }) => CategoryRow(
    id: id ?? this.id,
    name: name ?? this.name,
    icon: icon ?? this.icon,
    color: color ?? this.color,
    kind: kind ?? this.kind,
    sortOrder: sortOrder ?? this.sortOrder,
    archived: archived ?? this.archived,
  );
  CategoryRow copyWithCompanion(CategoriesCompanion data) {
    return CategoryRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      icon: data.icon.present ? data.icon.value : this.icon,
      color: data.color.present ? data.color.value : this.color,
      kind: data.kind.present ? data.kind.value : this.kind,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      archived: data.archived.present ? data.archived.value : this.archived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('kind: $kind, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('archived: $archived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, icon, color, kind, sortOrder, archived);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.icon == this.icon &&
          other.color == this.color &&
          other.kind == this.kind &&
          other.sortOrder == this.sortOrder &&
          other.archived == this.archived);
}

class CategoriesCompanion extends UpdateCompanion<CategoryRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> icon;
  final Value<int> color;
  final Value<MovementKind> kind;
  final Value<int> sortOrder;
  final Value<bool> archived;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.kind = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.archived = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String icon,
    required int color,
    required MovementKind kind,
    this.sortOrder = const Value.absent(),
    this.archived = const Value.absent(),
  }) : name = Value(name),
       icon = Value(icon),
       color = Value(color),
       kind = Value(kind);
  static Insertable<CategoryRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? icon,
    Expression<int>? color,
    Expression<String>? kind,
    Expression<int>? sortOrder,
    Expression<bool>? archived,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (color != null) 'color': color,
      if (kind != null) 'kind': kind,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (archived != null) 'archived': archived,
    });
  }

  CategoriesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? icon,
    Value<int>? color,
    Value<MovementKind>? kind,
    Value<int>? sortOrder,
    Value<bool>? archived,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      kind: kind ?? this.kind,
      sortOrder: sortOrder ?? this.sortOrder,
      archived: archived ?? this.archived,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>($CategoriesTable.$converterkind.toSql(kind.value));
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('kind: $kind, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('archived: $archived')
          ..write(')'))
        .toString();
  }
}

class $RecurringRulesTable extends RecurringRules with TableInfo<$RecurringRulesTable, RecurringRuleRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecurringRulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  @override
  late final GeneratedColumnWithTypeConverter<MovementKind, String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<MovementKind>($RecurringRulesTable.$converterkind);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 60),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    check: () => ComparableExpr(amount).isBiggerThanValue(0),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES categories (id)'),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Frequency, String> frequency = GeneratedColumn<String>(
    'frequency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<Frequency>($RecurringRulesTable.$converterfrequency);
  static const VerificationMeta _startDateMeta = const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<PaymentMethod?, String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<PaymentMethod?>($RecurringRulesTable.$converterpaymentMethodn);
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<int> cardId = GeneratedColumn<int>(
    'card_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _incomeSourceMeta = const VerificationMeta('incomeSource');
  @override
  late final GeneratedColumn<String> incomeSource = GeneratedColumn<String>(
    'income_source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastGeneratedDateMeta = const VerificationMeta('lastGeneratedDate');
  @override
  late final GeneratedColumn<DateTime> lastGeneratedDate = GeneratedColumn<DateTime>(
    'last_generated_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("active" IN (0, 1))'),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    kind,
    name,
    amount,
    categoryId,
    frequency,
    startDate,
    endDate,
    paymentMethod,
    cardId,
    incomeSource,
    lastGeneratedDate,
    active,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recurring_rules';
  @override
  VerificationContext validateIntegrity(Insertable<RecurringRuleRow> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(_nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta, amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta, startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta, endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('card_id')) {
      context.handle(_cardIdMeta, cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta));
    }
    if (data.containsKey('income_source')) {
      context.handle(
        _incomeSourceMeta,
        incomeSource.isAcceptableOrUnknown(data['income_source']!, _incomeSourceMeta),
      );
    }
    if (data.containsKey('last_generated_date')) {
      context.handle(
        _lastGeneratedDateMeta,
        lastGeneratedDate.isAcceptableOrUnknown(data['last_generated_date']!, _lastGeneratedDateMeta),
      );
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta, active.isAcceptableOrUnknown(data['active']!, _activeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecurringRuleRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecurringRuleRow(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      kind: $RecurringRulesTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}kind'])!,
      ),
      name: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      amount: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      categoryId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}category_id'])!,
      frequency: $RecurringRulesTable.$converterfrequency.fromSql(
        attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}frequency'])!,
      ),
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}end_date']),
      paymentMethod: $RecurringRulesTable.$converterpaymentMethodn.fromSql(
        attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}payment_method']),
      ),
      cardId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}card_id']),
      incomeSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}income_source'],
      ),
      lastGeneratedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_generated_date'],
      ),
      active: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}active'])!,
    );
  }

  @override
  $RecurringRulesTable createAlias(String alias) {
    return $RecurringRulesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MovementKind, String, String> $converterkind =
      const EnumNameConverter<MovementKind>(MovementKind.values);
  static JsonTypeConverter2<Frequency, String, String> $converterfrequency =
      const EnumNameConverter<Frequency>(Frequency.values);
  static JsonTypeConverter2<PaymentMethod, String, String> $converterpaymentMethod =
      const EnumNameConverter<PaymentMethod>(PaymentMethod.values);
  static JsonTypeConverter2<PaymentMethod?, String?, String?> $converterpaymentMethodn =
      JsonTypeConverter2.asNullable($converterpaymentMethod);
}

class RecurringRuleRow extends DataClass implements Insertable<RecurringRuleRow> {
  final int id;
  final MovementKind kind;
  final String name;
  final int amount;
  final int categoryId;
  final Frequency frequency;
  final DateTime startDate;
  final DateTime? endDate;
  final PaymentMethod? paymentMethod;
  final int? cardId;
  final String? incomeSource;
  final DateTime? lastGeneratedDate;
  final bool active;
  const RecurringRuleRow({
    required this.id,
    required this.kind,
    required this.name,
    required this.amount,
    required this.categoryId,
    required this.frequency,
    required this.startDate,
    this.endDate,
    this.paymentMethod,
    this.cardId,
    this.incomeSource,
    this.lastGeneratedDate,
    required this.active,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['kind'] = Variable<String>($RecurringRulesTable.$converterkind.toSql(kind));
    }
    map['name'] = Variable<String>(name);
    map['amount'] = Variable<int>(amount);
    map['category_id'] = Variable<int>(categoryId);
    {
      map['frequency'] = Variable<String>($RecurringRulesTable.$converterfrequency.toSql(frequency));
    }
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    if (!nullToAbsent || paymentMethod != null) {
      map['payment_method'] = Variable<String>(
        $RecurringRulesTable.$converterpaymentMethodn.toSql(paymentMethod),
      );
    }
    if (!nullToAbsent || cardId != null) {
      map['card_id'] = Variable<int>(cardId);
    }
    if (!nullToAbsent || incomeSource != null) {
      map['income_source'] = Variable<String>(incomeSource);
    }
    if (!nullToAbsent || lastGeneratedDate != null) {
      map['last_generated_date'] = Variable<DateTime>(lastGeneratedDate);
    }
    map['active'] = Variable<bool>(active);
    return map;
  }

  RecurringRulesCompanion toCompanion(bool nullToAbsent) {
    return RecurringRulesCompanion(
      id: Value(id),
      kind: Value(kind),
      name: Value(name),
      amount: Value(amount),
      categoryId: Value(categoryId),
      frequency: Value(frequency),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent ? const Value.absent() : Value(endDate),
      paymentMethod: paymentMethod == null && nullToAbsent ? const Value.absent() : Value(paymentMethod),
      cardId: cardId == null && nullToAbsent ? const Value.absent() : Value(cardId),
      incomeSource: incomeSource == null && nullToAbsent ? const Value.absent() : Value(incomeSource),
      lastGeneratedDate: lastGeneratedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastGeneratedDate),
      active: Value(active),
    );
  }

  factory RecurringRuleRow.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecurringRuleRow(
      id: serializer.fromJson<int>(json['id']),
      kind: $RecurringRulesTable.$converterkind.fromJson(serializer.fromJson<String>(json['kind'])),
      name: serializer.fromJson<String>(json['name']),
      amount: serializer.fromJson<int>(json['amount']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      frequency: $RecurringRulesTable.$converterfrequency.fromJson(
        serializer.fromJson<String>(json['frequency']),
      ),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      paymentMethod: $RecurringRulesTable.$converterpaymentMethodn.fromJson(
        serializer.fromJson<String?>(json['paymentMethod']),
      ),
      cardId: serializer.fromJson<int?>(json['cardId']),
      incomeSource: serializer.fromJson<String?>(json['incomeSource']),
      lastGeneratedDate: serializer.fromJson<DateTime?>(json['lastGeneratedDate']),
      active: serializer.fromJson<bool>(json['active']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kind': serializer.toJson<String>($RecurringRulesTable.$converterkind.toJson(kind)),
      'name': serializer.toJson<String>(name),
      'amount': serializer.toJson<int>(amount),
      'categoryId': serializer.toJson<int>(categoryId),
      'frequency': serializer.toJson<String>($RecurringRulesTable.$converterfrequency.toJson(frequency)),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'paymentMethod': serializer.toJson<String?>(
        $RecurringRulesTable.$converterpaymentMethodn.toJson(paymentMethod),
      ),
      'cardId': serializer.toJson<int?>(cardId),
      'incomeSource': serializer.toJson<String?>(incomeSource),
      'lastGeneratedDate': serializer.toJson<DateTime?>(lastGeneratedDate),
      'active': serializer.toJson<bool>(active),
    };
  }

  RecurringRuleRow copyWith({
    int? id,
    MovementKind? kind,
    String? name,
    int? amount,
    int? categoryId,
    Frequency? frequency,
    DateTime? startDate,
    Value<DateTime?> endDate = const Value.absent(),
    Value<PaymentMethod?> paymentMethod = const Value.absent(),
    Value<int?> cardId = const Value.absent(),
    Value<String?> incomeSource = const Value.absent(),
    Value<DateTime?> lastGeneratedDate = const Value.absent(),
    bool? active,
  }) => RecurringRuleRow(
    id: id ?? this.id,
    kind: kind ?? this.kind,
    name: name ?? this.name,
    amount: amount ?? this.amount,
    categoryId: categoryId ?? this.categoryId,
    frequency: frequency ?? this.frequency,
    startDate: startDate ?? this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    paymentMethod: paymentMethod.present ? paymentMethod.value : this.paymentMethod,
    cardId: cardId.present ? cardId.value : this.cardId,
    incomeSource: incomeSource.present ? incomeSource.value : this.incomeSource,
    lastGeneratedDate: lastGeneratedDate.present ? lastGeneratedDate.value : this.lastGeneratedDate,
    active: active ?? this.active,
  );
  RecurringRuleRow copyWithCompanion(RecurringRulesCompanion data) {
    return RecurringRuleRow(
      id: data.id.present ? data.id.value : this.id,
      kind: data.kind.present ? data.kind.value : this.kind,
      name: data.name.present ? data.name.value : this.name,
      amount: data.amount.present ? data.amount.value : this.amount,
      categoryId: data.categoryId.present ? data.categoryId.value : this.categoryId,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      paymentMethod: data.paymentMethod.present ? data.paymentMethod.value : this.paymentMethod,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      incomeSource: data.incomeSource.present ? data.incomeSource.value : this.incomeSource,
      lastGeneratedDate: data.lastGeneratedDate.present
          ? data.lastGeneratedDate.value
          : this.lastGeneratedDate,
      active: data.active.present ? data.active.value : this.active,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecurringRuleRow(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('categoryId: $categoryId, ')
          ..write('frequency: $frequency, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('cardId: $cardId, ')
          ..write('incomeSource: $incomeSource, ')
          ..write('lastGeneratedDate: $lastGeneratedDate, ')
          ..write('active: $active')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    kind,
    name,
    amount,
    categoryId,
    frequency,
    startDate,
    endDate,
    paymentMethod,
    cardId,
    incomeSource,
    lastGeneratedDate,
    active,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecurringRuleRow &&
          other.id == this.id &&
          other.kind == this.kind &&
          other.name == this.name &&
          other.amount == this.amount &&
          other.categoryId == this.categoryId &&
          other.frequency == this.frequency &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.paymentMethod == this.paymentMethod &&
          other.cardId == this.cardId &&
          other.incomeSource == this.incomeSource &&
          other.lastGeneratedDate == this.lastGeneratedDate &&
          other.active == this.active);
}

class RecurringRulesCompanion extends UpdateCompanion<RecurringRuleRow> {
  final Value<int> id;
  final Value<MovementKind> kind;
  final Value<String> name;
  final Value<int> amount;
  final Value<int> categoryId;
  final Value<Frequency> frequency;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<PaymentMethod?> paymentMethod;
  final Value<int?> cardId;
  final Value<String?> incomeSource;
  final Value<DateTime?> lastGeneratedDate;
  final Value<bool> active;
  const RecurringRulesCompanion({
    this.id = const Value.absent(),
    this.kind = const Value.absent(),
    this.name = const Value.absent(),
    this.amount = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.frequency = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.cardId = const Value.absent(),
    this.incomeSource = const Value.absent(),
    this.lastGeneratedDate = const Value.absent(),
    this.active = const Value.absent(),
  });
  RecurringRulesCompanion.insert({
    this.id = const Value.absent(),
    required MovementKind kind,
    required String name,
    required int amount,
    required int categoryId,
    required Frequency frequency,
    required DateTime startDate,
    this.endDate = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.cardId = const Value.absent(),
    this.incomeSource = const Value.absent(),
    this.lastGeneratedDate = const Value.absent(),
    this.active = const Value.absent(),
  }) : kind = Value(kind),
       name = Value(name),
       amount = Value(amount),
       categoryId = Value(categoryId),
       frequency = Value(frequency),
       startDate = Value(startDate);
  static Insertable<RecurringRuleRow> custom({
    Expression<int>? id,
    Expression<String>? kind,
    Expression<String>? name,
    Expression<int>? amount,
    Expression<int>? categoryId,
    Expression<String>? frequency,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? paymentMethod,
    Expression<int>? cardId,
    Expression<String>? incomeSource,
    Expression<DateTime>? lastGeneratedDate,
    Expression<bool>? active,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kind != null) 'kind': kind,
      if (name != null) 'name': name,
      if (amount != null) 'amount': amount,
      if (categoryId != null) 'category_id': categoryId,
      if (frequency != null) 'frequency': frequency,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (cardId != null) 'card_id': cardId,
      if (incomeSource != null) 'income_source': incomeSource,
      if (lastGeneratedDate != null) 'last_generated_date': lastGeneratedDate,
      if (active != null) 'active': active,
    });
  }

  RecurringRulesCompanion copyWith({
    Value<int>? id,
    Value<MovementKind>? kind,
    Value<String>? name,
    Value<int>? amount,
    Value<int>? categoryId,
    Value<Frequency>? frequency,
    Value<DateTime>? startDate,
    Value<DateTime?>? endDate,
    Value<PaymentMethod?>? paymentMethod,
    Value<int?>? cardId,
    Value<String?>? incomeSource,
    Value<DateTime?>? lastGeneratedDate,
    Value<bool>? active,
  }) {
    return RecurringRulesCompanion(
      id: id ?? this.id,
      kind: kind ?? this.kind,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      categoryId: categoryId ?? this.categoryId,
      frequency: frequency ?? this.frequency,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      cardId: cardId ?? this.cardId,
      incomeSource: incomeSource ?? this.incomeSource,
      lastGeneratedDate: lastGeneratedDate ?? this.lastGeneratedDate,
      active: active ?? this.active,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>($RecurringRulesTable.$converterkind.toSql(kind.value));
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>($RecurringRulesTable.$converterfrequency.toSql(frequency.value));
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(
        $RecurringRulesTable.$converterpaymentMethodn.toSql(paymentMethod.value),
      );
    }
    if (cardId.present) {
      map['card_id'] = Variable<int>(cardId.value);
    }
    if (incomeSource.present) {
      map['income_source'] = Variable<String>(incomeSource.value);
    }
    if (lastGeneratedDate.present) {
      map['last_generated_date'] = Variable<DateTime>(lastGeneratedDate.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecurringRulesCompanion(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('categoryId: $categoryId, ')
          ..write('frequency: $frequency, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('cardId: $cardId, ')
          ..write('incomeSource: $incomeSource, ')
          ..write('lastGeneratedDate: $lastGeneratedDate, ')
          ..write('active: $active')
          ..write(')'))
        .toString();
  }
}

class $CreditCardsTable extends CreditCards with TableInfo<$CreditCardsTable, CreditCardRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CreditCardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 30),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bankMeta = const VerificationMeta('bank');
  @override
  late final GeneratedColumn<String> bank = GeneratedColumn<String>(
    'bank',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _last4Meta = const VerificationMeta('last4');
  @override
  late final GeneratedColumn<String> last4 = GeneratedColumn<String>(
    'last4',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 4, maxTextLength: 4),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<CardNetwork, String> network = GeneratedColumn<String>(
    'network',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<CardNetwork>($CreditCardsTable.$converternetwork);
  static const VerificationMeta _colorIndexMeta = const VerificationMeta('colorIndex');
  @override
  late final GeneratedColumn<int> colorIndex = GeneratedColumn<int>(
    'color_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _creditLimitMeta = const VerificationMeta('creditLimit');
  @override
  late final GeneratedColumn<int> creditLimit = GeneratedColumn<int>(
    'credit_limit',
    aliasedName,
    false,
    check: () => ComparableExpr(creditLimit).isBiggerOrEqualValue(0),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cutoffDayMeta = const VerificationMeta('cutoffDay');
  @override
  late final GeneratedColumn<int> cutoffDay = GeneratedColumn<int>(
    'cutoff_day',
    aliasedName,
    false,
    check: () => ComparableExpr(cutoffDay).isBetweenValues(1, 31),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueDayMeta = const VerificationMeta('dueDay');
  @override
  late final GeneratedColumn<int> dueDay = GeneratedColumn<int>(
    'due_day',
    aliasedName,
    false,
    check: () => ComparableExpr(dueDay).isBetweenValues(1, 31),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _openingBalanceMeta = const VerificationMeta('openingBalance');
  @override
  late final GeneratedColumn<int> openingBalance = GeneratedColumn<int>(
    'opening_balance',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _balanceDateMeta = const VerificationMeta('balanceDate');
  @override
  late final GeneratedColumn<DateTime> balanceDate = GeneratedColumn<DateTime>(
    'balance_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statementRemainingMeta = const VerificationMeta('statementRemaining');
  @override
  late final GeneratedColumn<int> statementRemaining = GeneratedColumn<int>(
    'statement_remaining',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _minimumPaymentMeta = const VerificationMeta('minimumPayment');
  @override
  late final GeneratedColumn<int> minimumPayment = GeneratedColumn<int>(
    'minimum_payment',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _archivedMeta = const VerificationMeta('archived');
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("archived" IN (0, 1))'),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    bank,
    last4,
    network,
    colorIndex,
    creditLimit,
    cutoffDay,
    dueDay,
    openingBalance,
    balanceDate,
    statementRemaining,
    minimumPayment,
    sortOrder,
    archived,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'credit_cards';
  @override
  VerificationContext validateIntegrity(Insertable<CreditCardRow> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(_nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('bank')) {
      context.handle(_bankMeta, bank.isAcceptableOrUnknown(data['bank']!, _bankMeta));
    }
    if (data.containsKey('last4')) {
      context.handle(_last4Meta, last4.isAcceptableOrUnknown(data['last4']!, _last4Meta));
    }
    if (data.containsKey('color_index')) {
      context.handle(
        _colorIndexMeta,
        colorIndex.isAcceptableOrUnknown(data['color_index']!, _colorIndexMeta),
      );
    }
    if (data.containsKey('credit_limit')) {
      context.handle(
        _creditLimitMeta,
        creditLimit.isAcceptableOrUnknown(data['credit_limit']!, _creditLimitMeta),
      );
    } else if (isInserting) {
      context.missing(_creditLimitMeta);
    }
    if (data.containsKey('cutoff_day')) {
      context.handle(_cutoffDayMeta, cutoffDay.isAcceptableOrUnknown(data['cutoff_day']!, _cutoffDayMeta));
    } else if (isInserting) {
      context.missing(_cutoffDayMeta);
    }
    if (data.containsKey('due_day')) {
      context.handle(_dueDayMeta, dueDay.isAcceptableOrUnknown(data['due_day']!, _dueDayMeta));
    } else if (isInserting) {
      context.missing(_dueDayMeta);
    }
    if (data.containsKey('opening_balance')) {
      context.handle(
        _openingBalanceMeta,
        openingBalance.isAcceptableOrUnknown(data['opening_balance']!, _openingBalanceMeta),
      );
    }
    if (data.containsKey('balance_date')) {
      context.handle(
        _balanceDateMeta,
        balanceDate.isAcceptableOrUnknown(data['balance_date']!, _balanceDateMeta),
      );
    }
    if (data.containsKey('statement_remaining')) {
      context.handle(
        _statementRemainingMeta,
        statementRemaining.isAcceptableOrUnknown(data['statement_remaining']!, _statementRemainingMeta),
      );
    }
    if (data.containsKey('minimum_payment')) {
      context.handle(
        _minimumPaymentMeta,
        minimumPayment.isAcceptableOrUnknown(data['minimum_payment']!, _minimumPaymentMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta, sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    if (data.containsKey('archived')) {
      context.handle(_archivedMeta, archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CreditCardRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CreditCardRow(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      bank: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}bank']),
      last4: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}last4']),
      network: $CreditCardsTable.$converternetwork.fromSql(
        attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}network'])!,
      ),
      colorIndex: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}color_index'])!,
      creditLimit: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}credit_limit'],
      )!,
      cutoffDay: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}cutoff_day'])!,
      dueDay: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}due_day'])!,
      openingBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}opening_balance'],
      )!,
      balanceDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}balance_date'],
      ),
      statementRemaining: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}statement_remaining'],
      ),
      minimumPayment: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minimum_payment'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      archived: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}archived'])!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CreditCardsTable createAlias(String alias) {
    return $CreditCardsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CardNetwork, String, String> $converternetwork =
      const EnumNameConverter<CardNetwork>(CardNetwork.values);
}

class CreditCardRow extends DataClass implements Insertable<CreditCardRow> {
  final int id;
  final String name;
  final String? bank;
  final String? last4;
  final CardNetwork network;
  final int colorIndex;
  final int creditLimit;
  final int cutoffDay;
  final int dueDay;
  final int openingBalance;
  final DateTime? balanceDate;
  final int? statementRemaining;
  final int? minimumPayment;
  final int sortOrder;
  final bool archived;
  final DateTime createdAt;
  const CreditCardRow({
    required this.id,
    required this.name,
    this.bank,
    this.last4,
    required this.network,
    required this.colorIndex,
    required this.creditLimit,
    required this.cutoffDay,
    required this.dueDay,
    required this.openingBalance,
    this.balanceDate,
    this.statementRemaining,
    this.minimumPayment,
    required this.sortOrder,
    required this.archived,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || bank != null) {
      map['bank'] = Variable<String>(bank);
    }
    if (!nullToAbsent || last4 != null) {
      map['last4'] = Variable<String>(last4);
    }
    {
      map['network'] = Variable<String>($CreditCardsTable.$converternetwork.toSql(network));
    }
    map['color_index'] = Variable<int>(colorIndex);
    map['credit_limit'] = Variable<int>(creditLimit);
    map['cutoff_day'] = Variable<int>(cutoffDay);
    map['due_day'] = Variable<int>(dueDay);
    map['opening_balance'] = Variable<int>(openingBalance);
    if (!nullToAbsent || balanceDate != null) {
      map['balance_date'] = Variable<DateTime>(balanceDate);
    }
    if (!nullToAbsent || statementRemaining != null) {
      map['statement_remaining'] = Variable<int>(statementRemaining);
    }
    if (!nullToAbsent || minimumPayment != null) {
      map['minimum_payment'] = Variable<int>(minimumPayment);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['archived'] = Variable<bool>(archived);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CreditCardsCompanion toCompanion(bool nullToAbsent) {
    return CreditCardsCompanion(
      id: Value(id),
      name: Value(name),
      bank: bank == null && nullToAbsent ? const Value.absent() : Value(bank),
      last4: last4 == null && nullToAbsent ? const Value.absent() : Value(last4),
      network: Value(network),
      colorIndex: Value(colorIndex),
      creditLimit: Value(creditLimit),
      cutoffDay: Value(cutoffDay),
      dueDay: Value(dueDay),
      openingBalance: Value(openingBalance),
      balanceDate: balanceDate == null && nullToAbsent ? const Value.absent() : Value(balanceDate),
      statementRemaining: statementRemaining == null && nullToAbsent
          ? const Value.absent()
          : Value(statementRemaining),
      minimumPayment: minimumPayment == null && nullToAbsent ? const Value.absent() : Value(minimumPayment),
      sortOrder: Value(sortOrder),
      archived: Value(archived),
      createdAt: Value(createdAt),
    );
  }

  factory CreditCardRow.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CreditCardRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      bank: serializer.fromJson<String?>(json['bank']),
      last4: serializer.fromJson<String?>(json['last4']),
      network: $CreditCardsTable.$converternetwork.fromJson(serializer.fromJson<String>(json['network'])),
      colorIndex: serializer.fromJson<int>(json['colorIndex']),
      creditLimit: serializer.fromJson<int>(json['creditLimit']),
      cutoffDay: serializer.fromJson<int>(json['cutoffDay']),
      dueDay: serializer.fromJson<int>(json['dueDay']),
      openingBalance: serializer.fromJson<int>(json['openingBalance']),
      balanceDate: serializer.fromJson<DateTime?>(json['balanceDate']),
      statementRemaining: serializer.fromJson<int?>(json['statementRemaining']),
      minimumPayment: serializer.fromJson<int?>(json['minimumPayment']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      archived: serializer.fromJson<bool>(json['archived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'bank': serializer.toJson<String?>(bank),
      'last4': serializer.toJson<String?>(last4),
      'network': serializer.toJson<String>($CreditCardsTable.$converternetwork.toJson(network)),
      'colorIndex': serializer.toJson<int>(colorIndex),
      'creditLimit': serializer.toJson<int>(creditLimit),
      'cutoffDay': serializer.toJson<int>(cutoffDay),
      'dueDay': serializer.toJson<int>(dueDay),
      'openingBalance': serializer.toJson<int>(openingBalance),
      'balanceDate': serializer.toJson<DateTime?>(balanceDate),
      'statementRemaining': serializer.toJson<int?>(statementRemaining),
      'minimumPayment': serializer.toJson<int?>(minimumPayment),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'archived': serializer.toJson<bool>(archived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CreditCardRow copyWith({
    int? id,
    String? name,
    Value<String?> bank = const Value.absent(),
    Value<String?> last4 = const Value.absent(),
    CardNetwork? network,
    int? colorIndex,
    int? creditLimit,
    int? cutoffDay,
    int? dueDay,
    int? openingBalance,
    Value<DateTime?> balanceDate = const Value.absent(),
    Value<int?> statementRemaining = const Value.absent(),
    Value<int?> minimumPayment = const Value.absent(),
    int? sortOrder,
    bool? archived,
    DateTime? createdAt,
  }) => CreditCardRow(
    id: id ?? this.id,
    name: name ?? this.name,
    bank: bank.present ? bank.value : this.bank,
    last4: last4.present ? last4.value : this.last4,
    network: network ?? this.network,
    colorIndex: colorIndex ?? this.colorIndex,
    creditLimit: creditLimit ?? this.creditLimit,
    cutoffDay: cutoffDay ?? this.cutoffDay,
    dueDay: dueDay ?? this.dueDay,
    openingBalance: openingBalance ?? this.openingBalance,
    balanceDate: balanceDate.present ? balanceDate.value : this.balanceDate,
    statementRemaining: statementRemaining.present ? statementRemaining.value : this.statementRemaining,
    minimumPayment: minimumPayment.present ? minimumPayment.value : this.minimumPayment,
    sortOrder: sortOrder ?? this.sortOrder,
    archived: archived ?? this.archived,
    createdAt: createdAt ?? this.createdAt,
  );
  CreditCardRow copyWithCompanion(CreditCardsCompanion data) {
    return CreditCardRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      bank: data.bank.present ? data.bank.value : this.bank,
      last4: data.last4.present ? data.last4.value : this.last4,
      network: data.network.present ? data.network.value : this.network,
      colorIndex: data.colorIndex.present ? data.colorIndex.value : this.colorIndex,
      creditLimit: data.creditLimit.present ? data.creditLimit.value : this.creditLimit,
      cutoffDay: data.cutoffDay.present ? data.cutoffDay.value : this.cutoffDay,
      dueDay: data.dueDay.present ? data.dueDay.value : this.dueDay,
      openingBalance: data.openingBalance.present ? data.openingBalance.value : this.openingBalance,
      balanceDate: data.balanceDate.present ? data.balanceDate.value : this.balanceDate,
      statementRemaining: data.statementRemaining.present
          ? data.statementRemaining.value
          : this.statementRemaining,
      minimumPayment: data.minimumPayment.present ? data.minimumPayment.value : this.minimumPayment,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      archived: data.archived.present ? data.archived.value : this.archived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CreditCardRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('bank: $bank, ')
          ..write('last4: $last4, ')
          ..write('network: $network, ')
          ..write('colorIndex: $colorIndex, ')
          ..write('creditLimit: $creditLimit, ')
          ..write('cutoffDay: $cutoffDay, ')
          ..write('dueDay: $dueDay, ')
          ..write('openingBalance: $openingBalance, ')
          ..write('balanceDate: $balanceDate, ')
          ..write('statementRemaining: $statementRemaining, ')
          ..write('minimumPayment: $minimumPayment, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    bank,
    last4,
    network,
    colorIndex,
    creditLimit,
    cutoffDay,
    dueDay,
    openingBalance,
    balanceDate,
    statementRemaining,
    minimumPayment,
    sortOrder,
    archived,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CreditCardRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.bank == this.bank &&
          other.last4 == this.last4 &&
          other.network == this.network &&
          other.colorIndex == this.colorIndex &&
          other.creditLimit == this.creditLimit &&
          other.cutoffDay == this.cutoffDay &&
          other.dueDay == this.dueDay &&
          other.openingBalance == this.openingBalance &&
          other.balanceDate == this.balanceDate &&
          other.statementRemaining == this.statementRemaining &&
          other.minimumPayment == this.minimumPayment &&
          other.sortOrder == this.sortOrder &&
          other.archived == this.archived &&
          other.createdAt == this.createdAt);
}

class CreditCardsCompanion extends UpdateCompanion<CreditCardRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> bank;
  final Value<String?> last4;
  final Value<CardNetwork> network;
  final Value<int> colorIndex;
  final Value<int> creditLimit;
  final Value<int> cutoffDay;
  final Value<int> dueDay;
  final Value<int> openingBalance;
  final Value<DateTime?> balanceDate;
  final Value<int?> statementRemaining;
  final Value<int?> minimumPayment;
  final Value<int> sortOrder;
  final Value<bool> archived;
  final Value<DateTime> createdAt;
  const CreditCardsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.bank = const Value.absent(),
    this.last4 = const Value.absent(),
    this.network = const Value.absent(),
    this.colorIndex = const Value.absent(),
    this.creditLimit = const Value.absent(),
    this.cutoffDay = const Value.absent(),
    this.dueDay = const Value.absent(),
    this.openingBalance = const Value.absent(),
    this.balanceDate = const Value.absent(),
    this.statementRemaining = const Value.absent(),
    this.minimumPayment = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.archived = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CreditCardsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.bank = const Value.absent(),
    this.last4 = const Value.absent(),
    required CardNetwork network,
    this.colorIndex = const Value.absent(),
    required int creditLimit,
    required int cutoffDay,
    required int dueDay,
    this.openingBalance = const Value.absent(),
    this.balanceDate = const Value.absent(),
    this.statementRemaining = const Value.absent(),
    this.minimumPayment = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.archived = const Value.absent(),
    required DateTime createdAt,
  }) : name = Value(name),
       network = Value(network),
       creditLimit = Value(creditLimit),
       cutoffDay = Value(cutoffDay),
       dueDay = Value(dueDay),
       createdAt = Value(createdAt);
  static Insertable<CreditCardRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? bank,
    Expression<String>? last4,
    Expression<String>? network,
    Expression<int>? colorIndex,
    Expression<int>? creditLimit,
    Expression<int>? cutoffDay,
    Expression<int>? dueDay,
    Expression<int>? openingBalance,
    Expression<DateTime>? balanceDate,
    Expression<int>? statementRemaining,
    Expression<int>? minimumPayment,
    Expression<int>? sortOrder,
    Expression<bool>? archived,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (bank != null) 'bank': bank,
      if (last4 != null) 'last4': last4,
      if (network != null) 'network': network,
      if (colorIndex != null) 'color_index': colorIndex,
      if (creditLimit != null) 'credit_limit': creditLimit,
      if (cutoffDay != null) 'cutoff_day': cutoffDay,
      if (dueDay != null) 'due_day': dueDay,
      if (openingBalance != null) 'opening_balance': openingBalance,
      if (balanceDate != null) 'balance_date': balanceDate,
      if (statementRemaining != null) 'statement_remaining': statementRemaining,
      if (minimumPayment != null) 'minimum_payment': minimumPayment,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (archived != null) 'archived': archived,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CreditCardsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? bank,
    Value<String?>? last4,
    Value<CardNetwork>? network,
    Value<int>? colorIndex,
    Value<int>? creditLimit,
    Value<int>? cutoffDay,
    Value<int>? dueDay,
    Value<int>? openingBalance,
    Value<DateTime?>? balanceDate,
    Value<int?>? statementRemaining,
    Value<int?>? minimumPayment,
    Value<int>? sortOrder,
    Value<bool>? archived,
    Value<DateTime>? createdAt,
  }) {
    return CreditCardsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      bank: bank ?? this.bank,
      last4: last4 ?? this.last4,
      network: network ?? this.network,
      colorIndex: colorIndex ?? this.colorIndex,
      creditLimit: creditLimit ?? this.creditLimit,
      cutoffDay: cutoffDay ?? this.cutoffDay,
      dueDay: dueDay ?? this.dueDay,
      openingBalance: openingBalance ?? this.openingBalance,
      balanceDate: balanceDate ?? this.balanceDate,
      statementRemaining: statementRemaining ?? this.statementRemaining,
      minimumPayment: minimumPayment ?? this.minimumPayment,
      sortOrder: sortOrder ?? this.sortOrder,
      archived: archived ?? this.archived,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (bank.present) {
      map['bank'] = Variable<String>(bank.value);
    }
    if (last4.present) {
      map['last4'] = Variable<String>(last4.value);
    }
    if (network.present) {
      map['network'] = Variable<String>($CreditCardsTable.$converternetwork.toSql(network.value));
    }
    if (colorIndex.present) {
      map['color_index'] = Variable<int>(colorIndex.value);
    }
    if (creditLimit.present) {
      map['credit_limit'] = Variable<int>(creditLimit.value);
    }
    if (cutoffDay.present) {
      map['cutoff_day'] = Variable<int>(cutoffDay.value);
    }
    if (dueDay.present) {
      map['due_day'] = Variable<int>(dueDay.value);
    }
    if (openingBalance.present) {
      map['opening_balance'] = Variable<int>(openingBalance.value);
    }
    if (balanceDate.present) {
      map['balance_date'] = Variable<DateTime>(balanceDate.value);
    }
    if (statementRemaining.present) {
      map['statement_remaining'] = Variable<int>(statementRemaining.value);
    }
    if (minimumPayment.present) {
      map['minimum_payment'] = Variable<int>(minimumPayment.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CreditCardsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('bank: $bank, ')
          ..write('last4: $last4, ')
          ..write('network: $network, ')
          ..write('colorIndex: $colorIndex, ')
          ..write('creditLimit: $creditLimit, ')
          ..write('cutoffDay: $cutoffDay, ')
          ..write('dueDay: $dueDay, ')
          ..write('openingBalance: $openingBalance, ')
          ..write('balanceDate: $balanceDate, ')
          ..write('statementRemaining: $statementRemaining, ')
          ..write('minimumPayment: $minimumPayment, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $InstallmentPlansTable extends InstallmentPlans
    with TableInfo<$InstallmentPlansTable, InstallmentPlanRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InstallmentPlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<int> cardId = GeneratedColumn<int>(
    'card_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES credit_cards (id)'),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<int> total = GeneratedColumn<int>(
    'total',
    aliasedName,
    false,
    check: () => ComparableExpr(total).isBiggerThanValue(0),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _monthsMeta = const VerificationMeta('months');
  @override
  late final GeneratedColumn<int> months = GeneratedColumn<int>(
    'months',
    aliasedName,
    false,
    check: () => ComparableExpr(months).isBiggerThanValue(1),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES categories (id)'),
  );
  static const VerificationMeta _purchaseDateMeta = const VerificationMeta('purchaseDate');
  @override
  late final GeneratedColumn<DateTime> purchaseDate = GeneratedColumn<DateTime>(
    'purchase_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, cardId, description, total, months, categoryId, purchaseDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'installment_plans';
  @override
  VerificationContext validateIntegrity(Insertable<InstallmentPlanRow> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('card_id')) {
      context.handle(_cardIdMeta, cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta));
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(data['description']!, _descriptionMeta),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('total')) {
      context.handle(_totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('months')) {
      context.handle(_monthsMeta, months.isAcceptableOrUnknown(data['months']!, _monthsMeta));
    } else if (isInserting) {
      context.missing(_monthsMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('purchase_date')) {
      context.handle(
        _purchaseDateMeta,
        purchaseDate.isAcceptableOrUnknown(data['purchase_date']!, _purchaseDateMeta),
      );
    } else if (isInserting) {
      context.missing(_purchaseDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InstallmentPlanRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InstallmentPlanRow(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      cardId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}card_id'])!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      total: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}total'])!,
      months: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}months'])!,
      categoryId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}category_id'])!,
      purchaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}purchase_date'],
      )!,
    );
  }

  @override
  $InstallmentPlansTable createAlias(String alias) {
    return $InstallmentPlansTable(attachedDatabase, alias);
  }
}

class InstallmentPlanRow extends DataClass implements Insertable<InstallmentPlanRow> {
  final int id;
  final int cardId;
  final String description;
  final int total;
  final int months;
  final int categoryId;
  final DateTime purchaseDate;
  const InstallmentPlanRow({
    required this.id,
    required this.cardId,
    required this.description,
    required this.total,
    required this.months,
    required this.categoryId,
    required this.purchaseDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['card_id'] = Variable<int>(cardId);
    map['description'] = Variable<String>(description);
    map['total'] = Variable<int>(total);
    map['months'] = Variable<int>(months);
    map['category_id'] = Variable<int>(categoryId);
    map['purchase_date'] = Variable<DateTime>(purchaseDate);
    return map;
  }

  InstallmentPlansCompanion toCompanion(bool nullToAbsent) {
    return InstallmentPlansCompanion(
      id: Value(id),
      cardId: Value(cardId),
      description: Value(description),
      total: Value(total),
      months: Value(months),
      categoryId: Value(categoryId),
      purchaseDate: Value(purchaseDate),
    );
  }

  factory InstallmentPlanRow.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InstallmentPlanRow(
      id: serializer.fromJson<int>(json['id']),
      cardId: serializer.fromJson<int>(json['cardId']),
      description: serializer.fromJson<String>(json['description']),
      total: serializer.fromJson<int>(json['total']),
      months: serializer.fromJson<int>(json['months']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      purchaseDate: serializer.fromJson<DateTime>(json['purchaseDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cardId': serializer.toJson<int>(cardId),
      'description': serializer.toJson<String>(description),
      'total': serializer.toJson<int>(total),
      'months': serializer.toJson<int>(months),
      'categoryId': serializer.toJson<int>(categoryId),
      'purchaseDate': serializer.toJson<DateTime>(purchaseDate),
    };
  }

  InstallmentPlanRow copyWith({
    int? id,
    int? cardId,
    String? description,
    int? total,
    int? months,
    int? categoryId,
    DateTime? purchaseDate,
  }) => InstallmentPlanRow(
    id: id ?? this.id,
    cardId: cardId ?? this.cardId,
    description: description ?? this.description,
    total: total ?? this.total,
    months: months ?? this.months,
    categoryId: categoryId ?? this.categoryId,
    purchaseDate: purchaseDate ?? this.purchaseDate,
  );
  InstallmentPlanRow copyWithCompanion(InstallmentPlansCompanion data) {
    return InstallmentPlanRow(
      id: data.id.present ? data.id.value : this.id,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      description: data.description.present ? data.description.value : this.description,
      total: data.total.present ? data.total.value : this.total,
      months: data.months.present ? data.months.value : this.months,
      categoryId: data.categoryId.present ? data.categoryId.value : this.categoryId,
      purchaseDate: data.purchaseDate.present ? data.purchaseDate.value : this.purchaseDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InstallmentPlanRow(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('description: $description, ')
          ..write('total: $total, ')
          ..write('months: $months, ')
          ..write('categoryId: $categoryId, ')
          ..write('purchaseDate: $purchaseDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, cardId, description, total, months, categoryId, purchaseDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InstallmentPlanRow &&
          other.id == this.id &&
          other.cardId == this.cardId &&
          other.description == this.description &&
          other.total == this.total &&
          other.months == this.months &&
          other.categoryId == this.categoryId &&
          other.purchaseDate == this.purchaseDate);
}

class InstallmentPlansCompanion extends UpdateCompanion<InstallmentPlanRow> {
  final Value<int> id;
  final Value<int> cardId;
  final Value<String> description;
  final Value<int> total;
  final Value<int> months;
  final Value<int> categoryId;
  final Value<DateTime> purchaseDate;
  const InstallmentPlansCompanion({
    this.id = const Value.absent(),
    this.cardId = const Value.absent(),
    this.description = const Value.absent(),
    this.total = const Value.absent(),
    this.months = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.purchaseDate = const Value.absent(),
  });
  InstallmentPlansCompanion.insert({
    this.id = const Value.absent(),
    required int cardId,
    required String description,
    required int total,
    required int months,
    required int categoryId,
    required DateTime purchaseDate,
  }) : cardId = Value(cardId),
       description = Value(description),
       total = Value(total),
       months = Value(months),
       categoryId = Value(categoryId),
       purchaseDate = Value(purchaseDate);
  static Insertable<InstallmentPlanRow> custom({
    Expression<int>? id,
    Expression<int>? cardId,
    Expression<String>? description,
    Expression<int>? total,
    Expression<int>? months,
    Expression<int>? categoryId,
    Expression<DateTime>? purchaseDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cardId != null) 'card_id': cardId,
      if (description != null) 'description': description,
      if (total != null) 'total': total,
      if (months != null) 'months': months,
      if (categoryId != null) 'category_id': categoryId,
      if (purchaseDate != null) 'purchase_date': purchaseDate,
    });
  }

  InstallmentPlansCompanion copyWith({
    Value<int>? id,
    Value<int>? cardId,
    Value<String>? description,
    Value<int>? total,
    Value<int>? months,
    Value<int>? categoryId,
    Value<DateTime>? purchaseDate,
  }) {
    return InstallmentPlansCompanion(
      id: id ?? this.id,
      cardId: cardId ?? this.cardId,
      description: description ?? this.description,
      total: total ?? this.total,
      months: months ?? this.months,
      categoryId: categoryId ?? this.categoryId,
      purchaseDate: purchaseDate ?? this.purchaseDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<int>(cardId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (total.present) {
      map['total'] = Variable<int>(total.value);
    }
    if (months.present) {
      map['months'] = Variable<int>(months.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (purchaseDate.present) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InstallmentPlansCompanion(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('description: $description, ')
          ..write('total: $total, ')
          ..write('months: $months, ')
          ..write('categoryId: $categoryId, ')
          ..write('purchaseDate: $purchaseDate')
          ..write(')'))
        .toString();
  }
}

class $MovementsTable extends Movements with TableInfo<$MovementsTable, MovementRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MovementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  @override
  late final GeneratedColumnWithTypeConverter<MovementKind, String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<MovementKind>($MovementsTable.$converterkind);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    check: () => ComparableExpr(amount).isBiggerThanValue(0),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES categories (id)'),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<PaymentMethod?, String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<PaymentMethod?>($MovementsTable.$converterpaymentMethodn);
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<int> cardId = GeneratedColumn<int>(
    'card_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isUnexpectedMeta = const VerificationMeta('isUnexpected');
  @override
  late final GeneratedColumn<bool> isUnexpected = GeneratedColumn<bool>(
    'is_unexpected',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("is_unexpected" IN (0, 1))'),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _incomeSourceMeta = const VerificationMeta('incomeSource');
  @override
  late final GeneratedColumn<String> incomeSource = GeneratedColumn<String>(
    'income_source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recurringRuleIdMeta = const VerificationMeta('recurringRuleId');
  @override
  late final GeneratedColumn<int> recurringRuleId = GeneratedColumn<int>(
    'recurring_rule_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recurring_rules (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _installmentPlanIdMeta = const VerificationMeta('installmentPlanId');
  @override
  late final GeneratedColumn<int> installmentPlanId = GeneratedColumn<int>(
    'installment_plan_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES installment_plans (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _installmentNumberMeta = const VerificationMeta('installmentNumber');
  @override
  late final GeneratedColumn<int> installmentNumber = GeneratedColumn<int>(
    'installment_number',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    kind,
    amount,
    categoryId,
    date,
    note,
    paymentMethod,
    cardId,
    isUnexpected,
    incomeSource,
    recurringRuleId,
    installmentPlanId,
    installmentNumber,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'movements';
  @override
  VerificationContext validateIntegrity(Insertable<MovementRow> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta, amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(_dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('note')) {
      context.handle(_noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('card_id')) {
      context.handle(_cardIdMeta, cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta));
    }
    if (data.containsKey('is_unexpected')) {
      context.handle(
        _isUnexpectedMeta,
        isUnexpected.isAcceptableOrUnknown(data['is_unexpected']!, _isUnexpectedMeta),
      );
    }
    if (data.containsKey('income_source')) {
      context.handle(
        _incomeSourceMeta,
        incomeSource.isAcceptableOrUnknown(data['income_source']!, _incomeSourceMeta),
      );
    }
    if (data.containsKey('recurring_rule_id')) {
      context.handle(
        _recurringRuleIdMeta,
        recurringRuleId.isAcceptableOrUnknown(data['recurring_rule_id']!, _recurringRuleIdMeta),
      );
    }
    if (data.containsKey('installment_plan_id')) {
      context.handle(
        _installmentPlanIdMeta,
        installmentPlanId.isAcceptableOrUnknown(data['installment_plan_id']!, _installmentPlanIdMeta),
      );
    }
    if (data.containsKey('installment_number')) {
      context.handle(
        _installmentNumberMeta,
        installmentNumber.isAcceptableOrUnknown(data['installment_number']!, _installmentNumberMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {recurringRuleId, date},
  ];
  @override
  MovementRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MovementRow(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      kind: $MovementsTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}kind'])!,
      ),
      amount: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      categoryId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}category_id'])!,
      date: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      note: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}note']),
      paymentMethod: $MovementsTable.$converterpaymentMethodn.fromSql(
        attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}payment_method']),
      ),
      cardId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}card_id']),
      isUnexpected: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_unexpected'],
      )!,
      incomeSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}income_source'],
      ),
      recurringRuleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recurring_rule_id'],
      ),
      installmentPlanId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}installment_plan_id'],
      ),
      installmentNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}installment_number'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MovementsTable createAlias(String alias) {
    return $MovementsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MovementKind, String, String> $converterkind =
      const EnumNameConverter<MovementKind>(MovementKind.values);
  static JsonTypeConverter2<PaymentMethod, String, String> $converterpaymentMethod =
      const EnumNameConverter<PaymentMethod>(PaymentMethod.values);
  static JsonTypeConverter2<PaymentMethod?, String?, String?> $converterpaymentMethodn =
      JsonTypeConverter2.asNullable($converterpaymentMethod);
}

class MovementRow extends DataClass implements Insertable<MovementRow> {
  final int id;
  final MovementKind kind;
  final int amount;
  final int categoryId;
  final DateTime date;
  final String? note;
  final PaymentMethod? paymentMethod;
  final int? cardId;
  final bool isUnexpected;
  final String? incomeSource;
  final int? recurringRuleId;

  /// Las mensualidades se borran junto con su compra a MSI.
  final int? installmentPlanId;
  final int? installmentNumber;
  final DateTime createdAt;
  const MovementRow({
    required this.id,
    required this.kind,
    required this.amount,
    required this.categoryId,
    required this.date,
    this.note,
    this.paymentMethod,
    this.cardId,
    required this.isUnexpected,
    this.incomeSource,
    this.recurringRuleId,
    this.installmentPlanId,
    this.installmentNumber,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['kind'] = Variable<String>($MovementsTable.$converterkind.toSql(kind));
    }
    map['amount'] = Variable<int>(amount);
    map['category_id'] = Variable<int>(categoryId);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || paymentMethod != null) {
      map['payment_method'] = Variable<String>($MovementsTable.$converterpaymentMethodn.toSql(paymentMethod));
    }
    if (!nullToAbsent || cardId != null) {
      map['card_id'] = Variable<int>(cardId);
    }
    map['is_unexpected'] = Variable<bool>(isUnexpected);
    if (!nullToAbsent || incomeSource != null) {
      map['income_source'] = Variable<String>(incomeSource);
    }
    if (!nullToAbsent || recurringRuleId != null) {
      map['recurring_rule_id'] = Variable<int>(recurringRuleId);
    }
    if (!nullToAbsent || installmentPlanId != null) {
      map['installment_plan_id'] = Variable<int>(installmentPlanId);
    }
    if (!nullToAbsent || installmentNumber != null) {
      map['installment_number'] = Variable<int>(installmentNumber);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MovementsCompanion toCompanion(bool nullToAbsent) {
    return MovementsCompanion(
      id: Value(id),
      kind: Value(kind),
      amount: Value(amount),
      categoryId: Value(categoryId),
      date: Value(date),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      paymentMethod: paymentMethod == null && nullToAbsent ? const Value.absent() : Value(paymentMethod),
      cardId: cardId == null && nullToAbsent ? const Value.absent() : Value(cardId),
      isUnexpected: Value(isUnexpected),
      incomeSource: incomeSource == null && nullToAbsent ? const Value.absent() : Value(incomeSource),
      recurringRuleId: recurringRuleId == null && nullToAbsent
          ? const Value.absent()
          : Value(recurringRuleId),
      installmentPlanId: installmentPlanId == null && nullToAbsent
          ? const Value.absent()
          : Value(installmentPlanId),
      installmentNumber: installmentNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(installmentNumber),
      createdAt: Value(createdAt),
    );
  }

  factory MovementRow.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MovementRow(
      id: serializer.fromJson<int>(json['id']),
      kind: $MovementsTable.$converterkind.fromJson(serializer.fromJson<String>(json['kind'])),
      amount: serializer.fromJson<int>(json['amount']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      date: serializer.fromJson<DateTime>(json['date']),
      note: serializer.fromJson<String?>(json['note']),
      paymentMethod: $MovementsTable.$converterpaymentMethodn.fromJson(
        serializer.fromJson<String?>(json['paymentMethod']),
      ),
      cardId: serializer.fromJson<int?>(json['cardId']),
      isUnexpected: serializer.fromJson<bool>(json['isUnexpected']),
      incomeSource: serializer.fromJson<String?>(json['incomeSource']),
      recurringRuleId: serializer.fromJson<int?>(json['recurringRuleId']),
      installmentPlanId: serializer.fromJson<int?>(json['installmentPlanId']),
      installmentNumber: serializer.fromJson<int?>(json['installmentNumber']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kind': serializer.toJson<String>($MovementsTable.$converterkind.toJson(kind)),
      'amount': serializer.toJson<int>(amount),
      'categoryId': serializer.toJson<int>(categoryId),
      'date': serializer.toJson<DateTime>(date),
      'note': serializer.toJson<String?>(note),
      'paymentMethod': serializer.toJson<String?>(
        $MovementsTable.$converterpaymentMethodn.toJson(paymentMethod),
      ),
      'cardId': serializer.toJson<int?>(cardId),
      'isUnexpected': serializer.toJson<bool>(isUnexpected),
      'incomeSource': serializer.toJson<String?>(incomeSource),
      'recurringRuleId': serializer.toJson<int?>(recurringRuleId),
      'installmentPlanId': serializer.toJson<int?>(installmentPlanId),
      'installmentNumber': serializer.toJson<int?>(installmentNumber),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MovementRow copyWith({
    int? id,
    MovementKind? kind,
    int? amount,
    int? categoryId,
    DateTime? date,
    Value<String?> note = const Value.absent(),
    Value<PaymentMethod?> paymentMethod = const Value.absent(),
    Value<int?> cardId = const Value.absent(),
    bool? isUnexpected,
    Value<String?> incomeSource = const Value.absent(),
    Value<int?> recurringRuleId = const Value.absent(),
    Value<int?> installmentPlanId = const Value.absent(),
    Value<int?> installmentNumber = const Value.absent(),
    DateTime? createdAt,
  }) => MovementRow(
    id: id ?? this.id,
    kind: kind ?? this.kind,
    amount: amount ?? this.amount,
    categoryId: categoryId ?? this.categoryId,
    date: date ?? this.date,
    note: note.present ? note.value : this.note,
    paymentMethod: paymentMethod.present ? paymentMethod.value : this.paymentMethod,
    cardId: cardId.present ? cardId.value : this.cardId,
    isUnexpected: isUnexpected ?? this.isUnexpected,
    incomeSource: incomeSource.present ? incomeSource.value : this.incomeSource,
    recurringRuleId: recurringRuleId.present ? recurringRuleId.value : this.recurringRuleId,
    installmentPlanId: installmentPlanId.present ? installmentPlanId.value : this.installmentPlanId,
    installmentNumber: installmentNumber.present ? installmentNumber.value : this.installmentNumber,
    createdAt: createdAt ?? this.createdAt,
  );
  MovementRow copyWithCompanion(MovementsCompanion data) {
    return MovementRow(
      id: data.id.present ? data.id.value : this.id,
      kind: data.kind.present ? data.kind.value : this.kind,
      amount: data.amount.present ? data.amount.value : this.amount,
      categoryId: data.categoryId.present ? data.categoryId.value : this.categoryId,
      date: data.date.present ? data.date.value : this.date,
      note: data.note.present ? data.note.value : this.note,
      paymentMethod: data.paymentMethod.present ? data.paymentMethod.value : this.paymentMethod,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      isUnexpected: data.isUnexpected.present ? data.isUnexpected.value : this.isUnexpected,
      incomeSource: data.incomeSource.present ? data.incomeSource.value : this.incomeSource,
      recurringRuleId: data.recurringRuleId.present ? data.recurringRuleId.value : this.recurringRuleId,
      installmentPlanId: data.installmentPlanId.present
          ? data.installmentPlanId.value
          : this.installmentPlanId,
      installmentNumber: data.installmentNumber.present
          ? data.installmentNumber.value
          : this.installmentNumber,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MovementRow(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('amount: $amount, ')
          ..write('categoryId: $categoryId, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('cardId: $cardId, ')
          ..write('isUnexpected: $isUnexpected, ')
          ..write('incomeSource: $incomeSource, ')
          ..write('recurringRuleId: $recurringRuleId, ')
          ..write('installmentPlanId: $installmentPlanId, ')
          ..write('installmentNumber: $installmentNumber, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    kind,
    amount,
    categoryId,
    date,
    note,
    paymentMethod,
    cardId,
    isUnexpected,
    incomeSource,
    recurringRuleId,
    installmentPlanId,
    installmentNumber,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MovementRow &&
          other.id == this.id &&
          other.kind == this.kind &&
          other.amount == this.amount &&
          other.categoryId == this.categoryId &&
          other.date == this.date &&
          other.note == this.note &&
          other.paymentMethod == this.paymentMethod &&
          other.cardId == this.cardId &&
          other.isUnexpected == this.isUnexpected &&
          other.incomeSource == this.incomeSource &&
          other.recurringRuleId == this.recurringRuleId &&
          other.installmentPlanId == this.installmentPlanId &&
          other.installmentNumber == this.installmentNumber &&
          other.createdAt == this.createdAt);
}

class MovementsCompanion extends UpdateCompanion<MovementRow> {
  final Value<int> id;
  final Value<MovementKind> kind;
  final Value<int> amount;
  final Value<int> categoryId;
  final Value<DateTime> date;
  final Value<String?> note;
  final Value<PaymentMethod?> paymentMethod;
  final Value<int?> cardId;
  final Value<bool> isUnexpected;
  final Value<String?> incomeSource;
  final Value<int?> recurringRuleId;
  final Value<int?> installmentPlanId;
  final Value<int?> installmentNumber;
  final Value<DateTime> createdAt;
  const MovementsCompanion({
    this.id = const Value.absent(),
    this.kind = const Value.absent(),
    this.amount = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.date = const Value.absent(),
    this.note = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.cardId = const Value.absent(),
    this.isUnexpected = const Value.absent(),
    this.incomeSource = const Value.absent(),
    this.recurringRuleId = const Value.absent(),
    this.installmentPlanId = const Value.absent(),
    this.installmentNumber = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MovementsCompanion.insert({
    this.id = const Value.absent(),
    required MovementKind kind,
    required int amount,
    required int categoryId,
    required DateTime date,
    this.note = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.cardId = const Value.absent(),
    this.isUnexpected = const Value.absent(),
    this.incomeSource = const Value.absent(),
    this.recurringRuleId = const Value.absent(),
    this.installmentPlanId = const Value.absent(),
    this.installmentNumber = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : kind = Value(kind),
       amount = Value(amount),
       categoryId = Value(categoryId),
       date = Value(date);
  static Insertable<MovementRow> custom({
    Expression<int>? id,
    Expression<String>? kind,
    Expression<int>? amount,
    Expression<int>? categoryId,
    Expression<DateTime>? date,
    Expression<String>? note,
    Expression<String>? paymentMethod,
    Expression<int>? cardId,
    Expression<bool>? isUnexpected,
    Expression<String>? incomeSource,
    Expression<int>? recurringRuleId,
    Expression<int>? installmentPlanId,
    Expression<int>? installmentNumber,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kind != null) 'kind': kind,
      if (amount != null) 'amount': amount,
      if (categoryId != null) 'category_id': categoryId,
      if (date != null) 'date': date,
      if (note != null) 'note': note,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (cardId != null) 'card_id': cardId,
      if (isUnexpected != null) 'is_unexpected': isUnexpected,
      if (incomeSource != null) 'income_source': incomeSource,
      if (recurringRuleId != null) 'recurring_rule_id': recurringRuleId,
      if (installmentPlanId != null) 'installment_plan_id': installmentPlanId,
      if (installmentNumber != null) 'installment_number': installmentNumber,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MovementsCompanion copyWith({
    Value<int>? id,
    Value<MovementKind>? kind,
    Value<int>? amount,
    Value<int>? categoryId,
    Value<DateTime>? date,
    Value<String?>? note,
    Value<PaymentMethod?>? paymentMethod,
    Value<int?>? cardId,
    Value<bool>? isUnexpected,
    Value<String?>? incomeSource,
    Value<int?>? recurringRuleId,
    Value<int?>? installmentPlanId,
    Value<int?>? installmentNumber,
    Value<DateTime>? createdAt,
  }) {
    return MovementsCompanion(
      id: id ?? this.id,
      kind: kind ?? this.kind,
      amount: amount ?? this.amount,
      categoryId: categoryId ?? this.categoryId,
      date: date ?? this.date,
      note: note ?? this.note,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      cardId: cardId ?? this.cardId,
      isUnexpected: isUnexpected ?? this.isUnexpected,
      incomeSource: incomeSource ?? this.incomeSource,
      recurringRuleId: recurringRuleId ?? this.recurringRuleId,
      installmentPlanId: installmentPlanId ?? this.installmentPlanId,
      installmentNumber: installmentNumber ?? this.installmentNumber,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>($MovementsTable.$converterkind.toSql(kind.value));
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(
        $MovementsTable.$converterpaymentMethodn.toSql(paymentMethod.value),
      );
    }
    if (cardId.present) {
      map['card_id'] = Variable<int>(cardId.value);
    }
    if (isUnexpected.present) {
      map['is_unexpected'] = Variable<bool>(isUnexpected.value);
    }
    if (incomeSource.present) {
      map['income_source'] = Variable<String>(incomeSource.value);
    }
    if (recurringRuleId.present) {
      map['recurring_rule_id'] = Variable<int>(recurringRuleId.value);
    }
    if (installmentPlanId.present) {
      map['installment_plan_id'] = Variable<int>(installmentPlanId.value);
    }
    if (installmentNumber.present) {
      map['installment_number'] = Variable<int>(installmentNumber.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovementsCompanion(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('amount: $amount, ')
          ..write('categoryId: $categoryId, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('cardId: $cardId, ')
          ..write('isUnexpected: $isUnexpected, ')
          ..write('incomeSource: $incomeSource, ')
          ..write('recurringRuleId: $recurringRuleId, ')
          ..write('installmentPlanId: $installmentPlanId, ')
          ..write('installmentNumber: $installmentNumber, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CardPaymentsTable extends CardPayments with TableInfo<$CardPaymentsTable, CardPaymentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardPaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<int> cardId = GeneratedColumn<int>(
    'card_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES credit_cards (id) ON DELETE CASCADE'),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    check: () => ComparableExpr(amount).isBiggerThanValue(0),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, cardId, amount, date, note, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'card_payments';
  @override
  VerificationContext validateIntegrity(Insertable<CardPaymentRow> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('card_id')) {
      context.handle(_cardIdMeta, cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta));
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta, amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('date')) {
      context.handle(_dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('note')) {
      context.handle(_noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CardPaymentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CardPaymentRow(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      cardId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}card_id'])!,
      amount: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      date: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      note: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}note']),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CardPaymentsTable createAlias(String alias) {
    return $CardPaymentsTable(attachedDatabase, alias);
  }
}

class CardPaymentRow extends DataClass implements Insertable<CardPaymentRow> {
  final int id;
  final int cardId;
  final int amount;
  final DateTime date;
  final String? note;
  final DateTime createdAt;
  const CardPaymentRow({
    required this.id,
    required this.cardId,
    required this.amount,
    required this.date,
    this.note,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['card_id'] = Variable<int>(cardId);
    map['amount'] = Variable<int>(amount);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CardPaymentsCompanion toCompanion(bool nullToAbsent) {
    return CardPaymentsCompanion(
      id: Value(id),
      cardId: Value(cardId),
      amount: Value(amount),
      date: Value(date),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory CardPaymentRow.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CardPaymentRow(
      id: serializer.fromJson<int>(json['id']),
      cardId: serializer.fromJson<int>(json['cardId']),
      amount: serializer.fromJson<int>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cardId': serializer.toJson<int>(cardId),
      'amount': serializer.toJson<int>(amount),
      'date': serializer.toJson<DateTime>(date),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CardPaymentRow copyWith({
    int? id,
    int? cardId,
    int? amount,
    DateTime? date,
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
  }) => CardPaymentRow(
    id: id ?? this.id,
    cardId: cardId ?? this.cardId,
    amount: amount ?? this.amount,
    date: date ?? this.date,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
  );
  CardPaymentRow copyWithCompanion(CardPaymentsCompanion data) {
    return CardPaymentRow(
      id: data.id.present ? data.id.value : this.id,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      amount: data.amount.present ? data.amount.value : this.amount,
      date: data.date.present ? data.date.value : this.date,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CardPaymentRow(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, cardId, amount, date, note, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CardPaymentRow &&
          other.id == this.id &&
          other.cardId == this.cardId &&
          other.amount == this.amount &&
          other.date == this.date &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class CardPaymentsCompanion extends UpdateCompanion<CardPaymentRow> {
  final Value<int> id;
  final Value<int> cardId;
  final Value<int> amount;
  final Value<DateTime> date;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  const CardPaymentsCompanion({
    this.id = const Value.absent(),
    this.cardId = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CardPaymentsCompanion.insert({
    this.id = const Value.absent(),
    required int cardId,
    required int amount,
    required DateTime date,
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : cardId = Value(cardId),
       amount = Value(amount),
       date = Value(date);
  static Insertable<CardPaymentRow> custom({
    Expression<int>? id,
    Expression<int>? cardId,
    Expression<int>? amount,
    Expression<DateTime>? date,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cardId != null) 'card_id': cardId,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CardPaymentsCompanion copyWith({
    Value<int>? id,
    Value<int>? cardId,
    Value<int>? amount,
    Value<DateTime>? date,
    Value<String?>? note,
    Value<DateTime>? createdAt,
  }) {
    return CardPaymentsCompanion(
      id: id ?? this.id,
      cardId: cardId ?? this.cardId,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<int>(cardId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardPaymentsCompanion(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SettingsEntriesTable settingsEntries = $SettingsEntriesTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $RecurringRulesTable recurringRules = $RecurringRulesTable(this);
  late final $CreditCardsTable creditCards = $CreditCardsTable(this);
  late final $InstallmentPlansTable installmentPlans = $InstallmentPlansTable(this);
  late final $MovementsTable movements = $MovementsTable(this);
  late final $CardPaymentsTable cardPayments = $CardPaymentsTable(this);
  late final Index movementsDate = Index('movements_date', 'CREATE INDEX movements_date ON movements (date)');
  late final Index cardPaymentsCard = Index(
    'card_payments_card',
    'CREATE INDEX card_payments_card ON card_payments (card_id, date)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    settingsEntries,
    categories,
    recurringRules,
    creditCards,
    installmentPlans,
    movements,
    cardPayments,
    movementsDate,
    cardPaymentsCard,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName('recurring_rules', limitUpdateKind: UpdateKind.delete),
      result: [TableUpdate('movements', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName('installment_plans', limitUpdateKind: UpdateKind.delete),
      result: [TableUpdate('movements', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName('credit_cards', limitUpdateKind: UpdateKind.delete),
      result: [TableUpdate('card_payments', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$SettingsEntriesTableCreateCompanionBuilder = SettingsEntriesCompanion Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$SettingsEntriesTableUpdateCompanionBuilder = SettingsEntriesCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$SettingsEntriesTableFilterComposer extends Composer<_$AppDatabase, $SettingsEntriesTable> {
  $$SettingsEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => ColumnFilters(column));
}

class $$SettingsEntriesTableOrderingComposer extends Composer<_$AppDatabase, $SettingsEntriesTable> {
  $$SettingsEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => ColumnOrderings(column));
}

class $$SettingsEntriesTableAnnotationComposer extends Composer<_$AppDatabase, $SettingsEntriesTable> {
  $$SettingsEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key => $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value => $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$SettingsEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsEntriesTable,
          SettingsEntry,
          $$SettingsEntriesTableFilterComposer,
          $$SettingsEntriesTableOrderingComposer,
          $$SettingsEntriesTableAnnotationComposer,
          $$SettingsEntriesTableCreateCompanionBuilder,
          $$SettingsEntriesTableUpdateCompanionBuilder,
          (SettingsEntry, BaseReferences<_$AppDatabase, $SettingsEntriesTable, SettingsEntry>),
          SettingsEntry,
          PrefetchHooks Function()
        > {
  $$SettingsEntriesTableTableManager(_$AppDatabase db, $SettingsEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$SettingsEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$SettingsEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$SettingsEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => SettingsEntriesCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) => SettingsEntriesCompanion.insert(key: key, value: value, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SettingsEntriesTable, SettingsEntry>(table),
                  BaseReferences<_$AppDatabase, $SettingsEntriesTable, SettingsEntry>(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsEntriesTable,
      SettingsEntry,
      $$SettingsEntriesTableFilterComposer,
      $$SettingsEntriesTableOrderingComposer,
      $$SettingsEntriesTableAnnotationComposer,
      $$SettingsEntriesTableCreateCompanionBuilder,
      $$SettingsEntriesTableUpdateCompanionBuilder,
      (SettingsEntry, BaseReferences<_$AppDatabase, $SettingsEntriesTable, SettingsEntry>),
      SettingsEntry,
      PrefetchHooks Function()
    >;
typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  Value<int> id,
  required String name,
  required String icon,
  required int color,
  required MovementKind kind,
  Value<int> sortOrder,
  Value<bool> archived,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> icon,
  Value<int> color,
  Value<MovementKind> kind,
  Value<int> sortOrder,
  Value<bool> archived,
});

final class $$CategoriesTableReferences extends BaseReferences<_$AppDatabase, $CategoriesTable, CategoryRow> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RecurringRulesTable, List<RecurringRuleRow>> _recurringRulesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.recurringRules,
    aliasName: 'categories__id__recurring_rules__category_id',
  );

  $$RecurringRulesTableProcessedTableManager get recurringRulesRefs {
    final manager = $$RecurringRulesTableTableManager(
      $_db,
      $_db.recurringRules,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_recurringRulesRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$InstallmentPlansTable, List<InstallmentPlanRow>> _installmentPlansRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.installmentPlans,
    aliasName: 'categories__id__installment_plans__category_id',
  );

  $$InstallmentPlansTableProcessedTableManager get installmentPlansRefs {
    final manager = $$InstallmentPlansTableTableManager(
      $_db,
      $_db.installmentPlans,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_installmentPlansRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MovementsTable, List<MovementRow>> _movementsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.movements, aliasName: 'categories__id__movements__category_id');

  $$MovementsTableProcessedTableManager get movementsRefs {
    final manager = $$MovementsTableTableManager(
      $_db,
      $_db.movements,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_movementsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CategoriesTableFilterComposer extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<MovementKind, MovementKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => ColumnFilters(column));

  Expression<bool> recurringRulesRefs(Expression<bool> Function($$RecurringRulesTableFilterComposer f) f) {
    final $$RecurringRulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recurringRules,
      getReferencedColumn: (t) => t.categoryId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$RecurringRulesTableFilterComposer(
            $db: $db,
            $table: $db.recurringRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> installmentPlansRefs(
    Expression<bool> Function($$InstallmentPlansTableFilterComposer f) f,
  ) {
    final $$InstallmentPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.installmentPlans,
      getReferencedColumn: (t) => t.categoryId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$InstallmentPlansTableFilterComposer(
            $db: $db,
            $table: $db.installmentPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> movementsRefs(Expression<bool> Function($$MovementsTableFilterComposer f) f) {
    final $$MovementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movements,
      getReferencedColumn: (t) => t.categoryId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MovementsTableFilterComposer(
            $db: $db,
            $table: $db.movements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => ColumnOrderings(column));
}

class $$CategoriesTableAnnotationComposer extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name => $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get icon => $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<int> get color => $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MovementKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);

  Expression<T> recurringRulesRefs<T extends Object>(
    Expression<T> Function($$RecurringRulesTableAnnotationComposer a) f,
  ) {
    final $$RecurringRulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recurringRules,
      getReferencedColumn: (t) => t.categoryId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$RecurringRulesTableAnnotationComposer(
            $db: $db,
            $table: $db.recurringRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> installmentPlansRefs<T extends Object>(
    Expression<T> Function($$InstallmentPlansTableAnnotationComposer a) f,
  ) {
    final $$InstallmentPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.installmentPlans,
      getReferencedColumn: (t) => t.categoryId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$InstallmentPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.installmentPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> movementsRefs<T extends Object>(
    Expression<T> Function($$MovementsTableAnnotationComposer a) f,
  ) {
    final $$MovementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movements,
      getReferencedColumn: (t) => t.categoryId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MovementsTableAnnotationComposer(
            $db: $db,
            $table: $db.movements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          CategoryRow,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (CategoryRow, $$CategoriesTableReferences),
          CategoryRow,
          PrefetchHooks Function({bool recurringRulesRefs, bool installmentPlansRefs, bool movementsRefs})
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<MovementKind> kind = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> archived = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                name: name,
                icon: icon,
                color: color,
                kind: kind,
                sortOrder: sortOrder,
                archived: archived,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String icon,
                required int color,
                required MovementKind kind,
                Value<int> sortOrder = const Value.absent(),
                Value<bool> archived = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                name: name,
                icon: icon,
                color: color,
                kind: kind,
                sortOrder: sortOrder,
                archived: archived,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CategoriesTable, CategoryRow>(table),
                  $$CategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({recurringRulesRefs = false, installmentPlansRefs = false, movementsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (recurringRulesRefs) db.recurringRules,
                    if (installmentPlansRefs) db.installmentPlans,
                    if (movementsRefs) db.movements,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (recurringRulesRefs)
                        await $_getPrefetchedData<CategoryRow, $CategoriesTable, RecurringRuleRow>(
                          currentTable: table,
                          referencedTable: $$CategoriesTableReferences._recurringRulesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableReferences(db, table, p0).recurringRulesRefs,
                          referencedItemsForCurrentItem: (item, referencedItems) =>
                              referencedItems.where((e) => e.categoryId == item.id),
                          typedResults: items,
                        ),
                      if (installmentPlansRefs)
                        await $_getPrefetchedData<CategoryRow, $CategoriesTable, InstallmentPlanRow>(
                          currentTable: table,
                          referencedTable: $$CategoriesTableReferences._installmentPlansRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableReferences(db, table, p0).installmentPlansRefs,
                          referencedItemsForCurrentItem: (item, referencedItems) =>
                              referencedItems.where((e) => e.categoryId == item.id),
                          typedResults: items,
                        ),
                      if (movementsRefs)
                        await $_getPrefetchedData<CategoryRow, $CategoriesTable, MovementRow>(
                          currentTable: table,
                          referencedTable: $$CategoriesTableReferences._movementsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableReferences(db, table, p0).movementsRefs,
                          referencedItemsForCurrentItem: (item, referencedItems) =>
                              referencedItems.where((e) => e.categoryId == item.id),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      CategoryRow,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (CategoryRow, $$CategoriesTableReferences),
      CategoryRow,
      PrefetchHooks Function({bool recurringRulesRefs, bool installmentPlansRefs, bool movementsRefs})
    >;
typedef $$RecurringRulesTableCreateCompanionBuilder = RecurringRulesCompanion Function({
  Value<int> id,
  required MovementKind kind,
  required String name,
  required int amount,
  required int categoryId,
  required Frequency frequency,
  required DateTime startDate,
  Value<DateTime?> endDate,
  Value<PaymentMethod?> paymentMethod,
  Value<int?> cardId,
  Value<String?> incomeSource,
  Value<DateTime?> lastGeneratedDate,
  Value<bool> active,
});
typedef $$RecurringRulesTableUpdateCompanionBuilder = RecurringRulesCompanion Function({
  Value<int> id,
  Value<MovementKind> kind,
  Value<String> name,
  Value<int> amount,
  Value<int> categoryId,
  Value<Frequency> frequency,
  Value<DateTime> startDate,
  Value<DateTime?> endDate,
  Value<PaymentMethod?> paymentMethod,
  Value<int?> cardId,
  Value<String?> incomeSource,
  Value<DateTime?> lastGeneratedDate,
  Value<bool> active,
});

final class $$RecurringRulesTableReferences
    extends BaseReferences<_$AppDatabase, $RecurringRulesTable, RecurringRuleRow> {
  $$RecurringRulesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias('recurring_rules__category_id__categories__id');

  $$CategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<int>('category_id')!;

    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$MovementsTable, List<MovementRow>> _movementsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.movements,
        aliasName: 'recurring_rules__id__movements__recurring_rule_id',
      );

  $$MovementsTableProcessedTableManager get movementsRefs {
    final manager = $$MovementsTableTableManager(
      $_db,
      $_db.movements,
    ).filter((f) => f.recurringRuleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_movementsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$RecurringRulesTableFilterComposer extends Composer<_$AppDatabase, $RecurringRulesTable> {
  $$RecurringRulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<MovementKind, MovementKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Frequency, Frequency, String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<PaymentMethod?, PaymentMethod, String> get paymentMethod =>
      $composableBuilder(
        column: $table.paymentMethod,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get cardId =>
      $composableBuilder(column: $table.cardId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get incomeSource =>
      $composableBuilder(column: $table.incomeSource, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastGeneratedDate =>
      $composableBuilder(column: $table.lastGeneratedDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => ColumnFilters(column));

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> movementsRefs(Expression<bool> Function($$MovementsTableFilterComposer f) f) {
    final $$MovementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movements,
      getReferencedColumn: (t) => t.recurringRuleId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MovementsTableFilterComposer(
            $db: $db,
            $table: $db.movements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecurringRulesTableOrderingComposer extends Composer<_$AppDatabase, $RecurringRulesTable> {
  $$RecurringRulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paymentMethod =>
      $composableBuilder(column: $table.paymentMethod, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cardId =>
      $composableBuilder(column: $table.cardId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get incomeSource =>
      $composableBuilder(column: $table.incomeSource, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastGeneratedDate =>
      $composableBuilder(column: $table.lastGeneratedDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => ColumnOrderings(column));

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecurringRulesTableAnnotationComposer extends Composer<_$AppDatabase, $RecurringRulesTable> {
  $$RecurringRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MovementKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get name => $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get amount => $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Frequency, String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PaymentMethod?, String> get paymentMethod =>
      $composableBuilder(column: $table.paymentMethod, builder: (column) => column);

  GeneratedColumn<int> get cardId => $composableBuilder(column: $table.cardId, builder: (column) => column);

  GeneratedColumn<String> get incomeSource =>
      $composableBuilder(column: $table.incomeSource, builder: (column) => column);

  GeneratedColumn<DateTime> get lastGeneratedDate =>
      $composableBuilder(column: $table.lastGeneratedDate, builder: (column) => column);

  GeneratedColumn<bool> get active => $composableBuilder(column: $table.active, builder: (column) => column);

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> movementsRefs<T extends Object>(
    Expression<T> Function($$MovementsTableAnnotationComposer a) f,
  ) {
    final $$MovementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movements,
      getReferencedColumn: (t) => t.recurringRuleId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MovementsTableAnnotationComposer(
            $db: $db,
            $table: $db.movements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecurringRulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecurringRulesTable,
          RecurringRuleRow,
          $$RecurringRulesTableFilterComposer,
          $$RecurringRulesTableOrderingComposer,
          $$RecurringRulesTableAnnotationComposer,
          $$RecurringRulesTableCreateCompanionBuilder,
          $$RecurringRulesTableUpdateCompanionBuilder,
          (RecurringRuleRow, $$RecurringRulesTableReferences),
          RecurringRuleRow,
          PrefetchHooks Function({bool categoryId, bool movementsRefs})
        > {
  $$RecurringRulesTableTableManager(_$AppDatabase db, $RecurringRulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$RecurringRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$RecurringRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$RecurringRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<MovementKind> kind = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
                Value<Frequency> frequency = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<PaymentMethod?> paymentMethod = const Value.absent(),
                Value<int?> cardId = const Value.absent(),
                Value<String?> incomeSource = const Value.absent(),
                Value<DateTime?> lastGeneratedDate = const Value.absent(),
                Value<bool> active = const Value.absent(),
              }) => RecurringRulesCompanion(
                id: id,
                kind: kind,
                name: name,
                amount: amount,
                categoryId: categoryId,
                frequency: frequency,
                startDate: startDate,
                endDate: endDate,
                paymentMethod: paymentMethod,
                cardId: cardId,
                incomeSource: incomeSource,
                lastGeneratedDate: lastGeneratedDate,
                active: active,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required MovementKind kind,
                required String name,
                required int amount,
                required int categoryId,
                required Frequency frequency,
                required DateTime startDate,
                Value<DateTime?> endDate = const Value.absent(),
                Value<PaymentMethod?> paymentMethod = const Value.absent(),
                Value<int?> cardId = const Value.absent(),
                Value<String?> incomeSource = const Value.absent(),
                Value<DateTime?> lastGeneratedDate = const Value.absent(),
                Value<bool> active = const Value.absent(),
              }) => RecurringRulesCompanion.insert(
                id: id,
                kind: kind,
                name: name,
                amount: amount,
                categoryId: categoryId,
                frequency: frequency,
                startDate: startDate,
                endDate: endDate,
                paymentMethod: paymentMethod,
                cardId: cardId,
                incomeSource: incomeSource,
                lastGeneratedDate: lastGeneratedDate,
                active: active,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RecurringRulesTable, RecurringRuleRow>(table),
                  $$RecurringRulesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({categoryId = false, movementsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (movementsRefs) db.movements],
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
                    if (categoryId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.categoryId,
                        referencedTable: $$RecurringRulesTableReferences._categoryIdTable(db),
                        referencedColumn: $$RecurringRulesTableReferences._categoryIdTable(db).id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (movementsRefs)
                    await $_getPrefetchedData<RecurringRuleRow, $RecurringRulesTable, MovementRow>(
                      currentTable: table,
                      referencedTable: $$RecurringRulesTableReferences._movementsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$RecurringRulesTableReferences(db, table, p0).movementsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.recurringRuleId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RecurringRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecurringRulesTable,
      RecurringRuleRow,
      $$RecurringRulesTableFilterComposer,
      $$RecurringRulesTableOrderingComposer,
      $$RecurringRulesTableAnnotationComposer,
      $$RecurringRulesTableCreateCompanionBuilder,
      $$RecurringRulesTableUpdateCompanionBuilder,
      (RecurringRuleRow, $$RecurringRulesTableReferences),
      RecurringRuleRow,
      PrefetchHooks Function({bool categoryId, bool movementsRefs})
    >;
typedef $$CreditCardsTableCreateCompanionBuilder = CreditCardsCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> bank,
  Value<String?> last4,
  required CardNetwork network,
  Value<int> colorIndex,
  required int creditLimit,
  required int cutoffDay,
  required int dueDay,
  Value<int> openingBalance,
  Value<DateTime?> balanceDate,
  Value<int?> statementRemaining,
  Value<int?> minimumPayment,
  Value<int> sortOrder,
  Value<bool> archived,
  required DateTime createdAt,
});
typedef $$CreditCardsTableUpdateCompanionBuilder = CreditCardsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> bank,
  Value<String?> last4,
  Value<CardNetwork> network,
  Value<int> colorIndex,
  Value<int> creditLimit,
  Value<int> cutoffDay,
  Value<int> dueDay,
  Value<int> openingBalance,
  Value<DateTime?> balanceDate,
  Value<int?> statementRemaining,
  Value<int?> minimumPayment,
  Value<int> sortOrder,
  Value<bool> archived,
  Value<DateTime> createdAt,
});

final class $$CreditCardsTableReferences
    extends BaseReferences<_$AppDatabase, $CreditCardsTable, CreditCardRow> {
  $$CreditCardsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$InstallmentPlansTable, List<InstallmentPlanRow>> _installmentPlansRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.installmentPlans,
    aliasName: 'credit_cards__id__installment_plans__card_id',
  );

  $$InstallmentPlansTableProcessedTableManager get installmentPlansRefs {
    final manager = $$InstallmentPlansTableTableManager(
      $_db,
      $_db.installmentPlans,
    ).filter((f) => f.cardId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_installmentPlansRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$CardPaymentsTable, List<CardPaymentRow>> _cardPaymentsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(db.cardPayments, aliasName: 'credit_cards__id__card_payments__card_id');

  $$CardPaymentsTableProcessedTableManager get cardPaymentsRefs {
    final manager = $$CardPaymentsTableTableManager(
      $_db,
      $_db.cardPayments,
    ).filter((f) => f.cardId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_cardPaymentsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CreditCardsTableFilterComposer extends Composer<_$AppDatabase, $CreditCardsTable> {
  $$CreditCardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bank =>
      $composableBuilder(column: $table.bank, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get last4 =>
      $composableBuilder(column: $table.last4, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<CardNetwork, CardNetwork, String> get network =>
      $composableBuilder(column: $table.network, builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get colorIndex =>
      $composableBuilder(column: $table.colorIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get creditLimit =>
      $composableBuilder(column: $table.creditLimit, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cutoffDay =>
      $composableBuilder(column: $table.cutoffDay, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dueDay =>
      $composableBuilder(column: $table.dueDay, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get openingBalance =>
      $composableBuilder(column: $table.openingBalance, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get balanceDate =>
      $composableBuilder(column: $table.balanceDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get statementRemaining =>
      $composableBuilder(column: $table.statementRemaining, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get minimumPayment =>
      $composableBuilder(column: $table.minimumPayment, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> installmentPlansRefs(
    Expression<bool> Function($$InstallmentPlansTableFilterComposer f) f,
  ) {
    final $$InstallmentPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.installmentPlans,
      getReferencedColumn: (t) => t.cardId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$InstallmentPlansTableFilterComposer(
            $db: $db,
            $table: $db.installmentPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> cardPaymentsRefs(Expression<bool> Function($$CardPaymentsTableFilterComposer f) f) {
    final $$CardPaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cardPayments,
      getReferencedColumn: (t) => t.cardId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CardPaymentsTableFilterComposer(
            $db: $db,
            $table: $db.cardPayments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CreditCardsTableOrderingComposer extends Composer<_$AppDatabase, $CreditCardsTable> {
  $$CreditCardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bank =>
      $composableBuilder(column: $table.bank, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get last4 =>
      $composableBuilder(column: $table.last4, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get network =>
      $composableBuilder(column: $table.network, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get colorIndex =>
      $composableBuilder(column: $table.colorIndex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get creditLimit =>
      $composableBuilder(column: $table.creditLimit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cutoffDay =>
      $composableBuilder(column: $table.cutoffDay, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dueDay =>
      $composableBuilder(column: $table.dueDay, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get openingBalance =>
      $composableBuilder(column: $table.openingBalance, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get balanceDate =>
      $composableBuilder(column: $table.balanceDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get statementRemaining =>
      $composableBuilder(column: $table.statementRemaining, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get minimumPayment =>
      $composableBuilder(column: $table.minimumPayment, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$CreditCardsTableAnnotationComposer extends Composer<_$AppDatabase, $CreditCardsTable> {
  $$CreditCardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name => $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get bank => $composableBuilder(column: $table.bank, builder: (column) => column);

  GeneratedColumn<String> get last4 => $composableBuilder(column: $table.last4, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CardNetwork, String> get network =>
      $composableBuilder(column: $table.network, builder: (column) => column);

  GeneratedColumn<int> get colorIndex =>
      $composableBuilder(column: $table.colorIndex, builder: (column) => column);

  GeneratedColumn<int> get creditLimit =>
      $composableBuilder(column: $table.creditLimit, builder: (column) => column);

  GeneratedColumn<int> get cutoffDay =>
      $composableBuilder(column: $table.cutoffDay, builder: (column) => column);

  GeneratedColumn<int> get dueDay => $composableBuilder(column: $table.dueDay, builder: (column) => column);

  GeneratedColumn<int> get openingBalance =>
      $composableBuilder(column: $table.openingBalance, builder: (column) => column);

  GeneratedColumn<DateTime> get balanceDate =>
      $composableBuilder(column: $table.balanceDate, builder: (column) => column);

  GeneratedColumn<int> get statementRemaining =>
      $composableBuilder(column: $table.statementRemaining, builder: (column) => column);

  GeneratedColumn<int> get minimumPayment =>
      $composableBuilder(column: $table.minimumPayment, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> installmentPlansRefs<T extends Object>(
    Expression<T> Function($$InstallmentPlansTableAnnotationComposer a) f,
  ) {
    final $$InstallmentPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.installmentPlans,
      getReferencedColumn: (t) => t.cardId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$InstallmentPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.installmentPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> cardPaymentsRefs<T extends Object>(
    Expression<T> Function($$CardPaymentsTableAnnotationComposer a) f,
  ) {
    final $$CardPaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cardPayments,
      getReferencedColumn: (t) => t.cardId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CardPaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.cardPayments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CreditCardsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CreditCardsTable,
          CreditCardRow,
          $$CreditCardsTableFilterComposer,
          $$CreditCardsTableOrderingComposer,
          $$CreditCardsTableAnnotationComposer,
          $$CreditCardsTableCreateCompanionBuilder,
          $$CreditCardsTableUpdateCompanionBuilder,
          (CreditCardRow, $$CreditCardsTableReferences),
          CreditCardRow,
          PrefetchHooks Function({bool installmentPlansRefs, bool cardPaymentsRefs})
        > {
  $$CreditCardsTableTableManager(_$AppDatabase db, $CreditCardsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$CreditCardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$CreditCardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$CreditCardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> bank = const Value.absent(),
                Value<String?> last4 = const Value.absent(),
                Value<CardNetwork> network = const Value.absent(),
                Value<int> colorIndex = const Value.absent(),
                Value<int> creditLimit = const Value.absent(),
                Value<int> cutoffDay = const Value.absent(),
                Value<int> dueDay = const Value.absent(),
                Value<int> openingBalance = const Value.absent(),
                Value<DateTime?> balanceDate = const Value.absent(),
                Value<int?> statementRemaining = const Value.absent(),
                Value<int?> minimumPayment = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CreditCardsCompanion(
                id: id,
                name: name,
                bank: bank,
                last4: last4,
                network: network,
                colorIndex: colorIndex,
                creditLimit: creditLimit,
                cutoffDay: cutoffDay,
                dueDay: dueDay,
                openingBalance: openingBalance,
                balanceDate: balanceDate,
                statementRemaining: statementRemaining,
                minimumPayment: minimumPayment,
                sortOrder: sortOrder,
                archived: archived,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> bank = const Value.absent(),
                Value<String?> last4 = const Value.absent(),
                required CardNetwork network,
                Value<int> colorIndex = const Value.absent(),
                required int creditLimit,
                required int cutoffDay,
                required int dueDay,
                Value<int> openingBalance = const Value.absent(),
                Value<DateTime?> balanceDate = const Value.absent(),
                Value<int?> statementRemaining = const Value.absent(),
                Value<int?> minimumPayment = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                required DateTime createdAt,
              }) => CreditCardsCompanion.insert(
                id: id,
                name: name,
                bank: bank,
                last4: last4,
                network: network,
                colorIndex: colorIndex,
                creditLimit: creditLimit,
                cutoffDay: cutoffDay,
                dueDay: dueDay,
                openingBalance: openingBalance,
                balanceDate: balanceDate,
                statementRemaining: statementRemaining,
                minimumPayment: minimumPayment,
                sortOrder: sortOrder,
                archived: archived,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CreditCardsTable, CreditCardRow>(table),
                  $$CreditCardsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({installmentPlansRefs = false, cardPaymentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (installmentPlansRefs) db.installmentPlans,
                if (cardPaymentsRefs) db.cardPayments,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (installmentPlansRefs)
                    await $_getPrefetchedData<CreditCardRow, $CreditCardsTable, InstallmentPlanRow>(
                      currentTable: table,
                      referencedTable: $$CreditCardsTableReferences._installmentPlansRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CreditCardsTableReferences(db, table, p0).installmentPlansRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.cardId == item.id),
                      typedResults: items,
                    ),
                  if (cardPaymentsRefs)
                    await $_getPrefetchedData<CreditCardRow, $CreditCardsTable, CardPaymentRow>(
                      currentTable: table,
                      referencedTable: $$CreditCardsTableReferences._cardPaymentsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CreditCardsTableReferences(db, table, p0).cardPaymentsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.cardId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CreditCardsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CreditCardsTable,
      CreditCardRow,
      $$CreditCardsTableFilterComposer,
      $$CreditCardsTableOrderingComposer,
      $$CreditCardsTableAnnotationComposer,
      $$CreditCardsTableCreateCompanionBuilder,
      $$CreditCardsTableUpdateCompanionBuilder,
      (CreditCardRow, $$CreditCardsTableReferences),
      CreditCardRow,
      PrefetchHooks Function({bool installmentPlansRefs, bool cardPaymentsRefs})
    >;
typedef $$InstallmentPlansTableCreateCompanionBuilder = InstallmentPlansCompanion Function({
  Value<int> id,
  required int cardId,
  required String description,
  required int total,
  required int months,
  required int categoryId,
  required DateTime purchaseDate,
});
typedef $$InstallmentPlansTableUpdateCompanionBuilder = InstallmentPlansCompanion Function({
  Value<int> id,
  Value<int> cardId,
  Value<String> description,
  Value<int> total,
  Value<int> months,
  Value<int> categoryId,
  Value<DateTime> purchaseDate,
});

final class $$InstallmentPlansTableReferences
    extends BaseReferences<_$AppDatabase, $InstallmentPlansTable, InstallmentPlanRow> {
  $$InstallmentPlansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CreditCardsTable _cardIdTable(_$AppDatabase db) =>
      db.creditCards.createAlias('installment_plans__card_id__credit_cards__id');

  $$CreditCardsTableProcessedTableManager get cardId {
    final $_column = $_itemColumn<int>('card_id')!;

    final manager = $$CreditCardsTableTableManager(
      $_db,
      $_db.creditCards,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias('installment_plans__category_id__categories__id');

  $$CategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<int>('category_id')!;

    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$MovementsTable, List<MovementRow>> _movementsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.movements,
        aliasName: 'installment_plans__id__movements__installment_plan_id',
      );

  $$MovementsTableProcessedTableManager get movementsRefs {
    final manager = $$MovementsTableTableManager(
      $_db,
      $_db.movements,
    ).filter((f) => f.installmentPlanId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_movementsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$InstallmentPlansTableFilterComposer extends Composer<_$AppDatabase, $InstallmentPlansTable> {
  $$InstallmentPlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description =>
      $composableBuilder(column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get total =>
      $composableBuilder(column: $table.total, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get months =>
      $composableBuilder(column: $table.months, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get purchaseDate =>
      $composableBuilder(column: $table.purchaseDate, builder: (column) => ColumnFilters(column));

  $$CreditCardsTableFilterComposer get cardId {
    final $$CreditCardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.creditCards,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CreditCardsTableFilterComposer(
            $db: $db,
            $table: $db.creditCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> movementsRefs(Expression<bool> Function($$MovementsTableFilterComposer f) f) {
    final $$MovementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movements,
      getReferencedColumn: (t) => t.installmentPlanId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MovementsTableFilterComposer(
            $db: $db,
            $table: $db.movements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InstallmentPlansTableOrderingComposer extends Composer<_$AppDatabase, $InstallmentPlansTable> {
  $$InstallmentPlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description =>
      $composableBuilder(column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get total =>
      $composableBuilder(column: $table.total, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get months =>
      $composableBuilder(column: $table.months, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get purchaseDate =>
      $composableBuilder(column: $table.purchaseDate, builder: (column) => ColumnOrderings(column));

  $$CreditCardsTableOrderingComposer get cardId {
    final $$CreditCardsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.creditCards,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CreditCardsTableOrderingComposer(
            $db: $db,
            $table: $db.creditCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InstallmentPlansTableAnnotationComposer extends Composer<_$AppDatabase, $InstallmentPlansTable> {
  $$InstallmentPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get description =>
      $composableBuilder(column: $table.description, builder: (column) => column);

  GeneratedColumn<int> get total => $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<int> get months => $composableBuilder(column: $table.months, builder: (column) => column);

  GeneratedColumn<DateTime> get purchaseDate =>
      $composableBuilder(column: $table.purchaseDate, builder: (column) => column);

  $$CreditCardsTableAnnotationComposer get cardId {
    final $$CreditCardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.creditCards,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CreditCardsTableAnnotationComposer(
            $db: $db,
            $table: $db.creditCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> movementsRefs<T extends Object>(
    Expression<T> Function($$MovementsTableAnnotationComposer a) f,
  ) {
    final $$MovementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movements,
      getReferencedColumn: (t) => t.installmentPlanId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MovementsTableAnnotationComposer(
            $db: $db,
            $table: $db.movements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InstallmentPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InstallmentPlansTable,
          InstallmentPlanRow,
          $$InstallmentPlansTableFilterComposer,
          $$InstallmentPlansTableOrderingComposer,
          $$InstallmentPlansTableAnnotationComposer,
          $$InstallmentPlansTableCreateCompanionBuilder,
          $$InstallmentPlansTableUpdateCompanionBuilder,
          (InstallmentPlanRow, $$InstallmentPlansTableReferences),
          InstallmentPlanRow,
          PrefetchHooks Function({bool cardId, bool categoryId, bool movementsRefs})
        > {
  $$InstallmentPlansTableTableManager(_$AppDatabase db, $InstallmentPlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$InstallmentPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$InstallmentPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InstallmentPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> cardId = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> total = const Value.absent(),
                Value<int> months = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
                Value<DateTime> purchaseDate = const Value.absent(),
              }) => InstallmentPlansCompanion(
                id: id,
                cardId: cardId,
                description: description,
                total: total,
                months: months,
                categoryId: categoryId,
                purchaseDate: purchaseDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int cardId,
                required String description,
                required int total,
                required int months,
                required int categoryId,
                required DateTime purchaseDate,
              }) => InstallmentPlansCompanion.insert(
                id: id,
                cardId: cardId,
                description: description,
                total: total,
                months: months,
                categoryId: categoryId,
                purchaseDate: purchaseDate,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$InstallmentPlansTable, InstallmentPlanRow>(table),
                  $$InstallmentPlansTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({cardId = false, categoryId = false, movementsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (movementsRefs) db.movements],
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
                    if (cardId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.cardId,
                        referencedTable: $$InstallmentPlansTableReferences._cardIdTable(db),
                        referencedColumn: $$InstallmentPlansTableReferences._cardIdTable(db).id,
                      ) as T;
                    }
                    if (categoryId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.categoryId,
                        referencedTable: $$InstallmentPlansTableReferences._categoryIdTable(db),
                        referencedColumn: $$InstallmentPlansTableReferences._categoryIdTable(db).id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (movementsRefs)
                    await $_getPrefetchedData<InstallmentPlanRow, $InstallmentPlansTable, MovementRow>(
                      currentTable: table,
                      referencedTable: $$InstallmentPlansTableReferences._movementsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$InstallmentPlansTableReferences(db, table, p0).movementsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.installmentPlanId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$InstallmentPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InstallmentPlansTable,
      InstallmentPlanRow,
      $$InstallmentPlansTableFilterComposer,
      $$InstallmentPlansTableOrderingComposer,
      $$InstallmentPlansTableAnnotationComposer,
      $$InstallmentPlansTableCreateCompanionBuilder,
      $$InstallmentPlansTableUpdateCompanionBuilder,
      (InstallmentPlanRow, $$InstallmentPlansTableReferences),
      InstallmentPlanRow,
      PrefetchHooks Function({bool cardId, bool categoryId, bool movementsRefs})
    >;
typedef $$MovementsTableCreateCompanionBuilder = MovementsCompanion Function({
  Value<int> id,
  required MovementKind kind,
  required int amount,
  required int categoryId,
  required DateTime date,
  Value<String?> note,
  Value<PaymentMethod?> paymentMethod,
  Value<int?> cardId,
  Value<bool> isUnexpected,
  Value<String?> incomeSource,
  Value<int?> recurringRuleId,
  Value<int?> installmentPlanId,
  Value<int?> installmentNumber,
  Value<DateTime> createdAt,
});
typedef $$MovementsTableUpdateCompanionBuilder = MovementsCompanion Function({
  Value<int> id,
  Value<MovementKind> kind,
  Value<int> amount,
  Value<int> categoryId,
  Value<DateTime> date,
  Value<String?> note,
  Value<PaymentMethod?> paymentMethod,
  Value<int?> cardId,
  Value<bool> isUnexpected,
  Value<String?> incomeSource,
  Value<int?> recurringRuleId,
  Value<int?> installmentPlanId,
  Value<int?> installmentNumber,
  Value<DateTime> createdAt,
});

final class $$MovementsTableReferences extends BaseReferences<_$AppDatabase, $MovementsTable, MovementRow> {
  $$MovementsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias('movements__category_id__categories__id');

  $$CategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<int>('category_id')!;

    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $RecurringRulesTable _recurringRuleIdTable(_$AppDatabase db) =>
      db.recurringRules.createAlias('movements__recurring_rule_id__recurring_rules__id');

  $$RecurringRulesTableProcessedTableManager? get recurringRuleId {
    final $_column = $_itemColumn<int>('recurring_rule_id');
    if ($_column == null) return null;
    final manager = $$RecurringRulesTableTableManager(
      $_db,
      $_db.recurringRules,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recurringRuleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $InstallmentPlansTable _installmentPlanIdTable(_$AppDatabase db) =>
      db.installmentPlans.createAlias('movements__installment_plan_id__installment_plans__id');

  $$InstallmentPlansTableProcessedTableManager? get installmentPlanId {
    final $_column = $_itemColumn<int>('installment_plan_id');
    if ($_column == null) return null;
    final manager = $$InstallmentPlansTableTableManager(
      $_db,
      $_db.installmentPlans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_installmentPlanIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$MovementsTableFilterComposer extends Composer<_$AppDatabase, $MovementsTable> {
  $$MovementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<MovementKind, MovementKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<PaymentMethod?, PaymentMethod, String> get paymentMethod =>
      $composableBuilder(
        column: $table.paymentMethod,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get cardId =>
      $composableBuilder(column: $table.cardId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isUnexpected =>
      $composableBuilder(column: $table.isUnexpected, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get incomeSource =>
      $composableBuilder(column: $table.incomeSource, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get installmentNumber =>
      $composableBuilder(column: $table.installmentNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecurringRulesTableFilterComposer get recurringRuleId {
    final $$RecurringRulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recurringRuleId,
      referencedTable: $db.recurringRules,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$RecurringRulesTableFilterComposer(
            $db: $db,
            $table: $db.recurringRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InstallmentPlansTableFilterComposer get installmentPlanId {
    final $$InstallmentPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.installmentPlanId,
      referencedTable: $db.installmentPlans,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$InstallmentPlansTableFilterComposer(
            $db: $db,
            $table: $db.installmentPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovementsTableOrderingComposer extends Composer<_$AppDatabase, $MovementsTable> {
  $$MovementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paymentMethod =>
      $composableBuilder(column: $table.paymentMethod, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cardId =>
      $composableBuilder(column: $table.cardId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isUnexpected =>
      $composableBuilder(column: $table.isUnexpected, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get incomeSource =>
      $composableBuilder(column: $table.incomeSource, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get installmentNumber =>
      $composableBuilder(column: $table.installmentNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecurringRulesTableOrderingComposer get recurringRuleId {
    final $$RecurringRulesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recurringRuleId,
      referencedTable: $db.recurringRules,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$RecurringRulesTableOrderingComposer(
            $db: $db,
            $table: $db.recurringRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InstallmentPlansTableOrderingComposer get installmentPlanId {
    final $$InstallmentPlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.installmentPlanId,
      referencedTable: $db.installmentPlans,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$InstallmentPlansTableOrderingComposer(
            $db: $db,
            $table: $db.installmentPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovementsTableAnnotationComposer extends Composer<_$AppDatabase, $MovementsTable> {
  $$MovementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MovementKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get amount => $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get date => $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get note => $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PaymentMethod?, String> get paymentMethod =>
      $composableBuilder(column: $table.paymentMethod, builder: (column) => column);

  GeneratedColumn<int> get cardId => $composableBuilder(column: $table.cardId, builder: (column) => column);

  GeneratedColumn<bool> get isUnexpected =>
      $composableBuilder(column: $table.isUnexpected, builder: (column) => column);

  GeneratedColumn<String> get incomeSource =>
      $composableBuilder(column: $table.incomeSource, builder: (column) => column);

  GeneratedColumn<int> get installmentNumber =>
      $composableBuilder(column: $table.installmentNumber, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecurringRulesTableAnnotationComposer get recurringRuleId {
    final $$RecurringRulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recurringRuleId,
      referencedTable: $db.recurringRules,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$RecurringRulesTableAnnotationComposer(
            $db: $db,
            $table: $db.recurringRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InstallmentPlansTableAnnotationComposer get installmentPlanId {
    final $$InstallmentPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.installmentPlanId,
      referencedTable: $db.installmentPlans,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$InstallmentPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.installmentPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MovementsTable,
          MovementRow,
          $$MovementsTableFilterComposer,
          $$MovementsTableOrderingComposer,
          $$MovementsTableAnnotationComposer,
          $$MovementsTableCreateCompanionBuilder,
          $$MovementsTableUpdateCompanionBuilder,
          (MovementRow, $$MovementsTableReferences),
          MovementRow,
          PrefetchHooks Function({bool categoryId, bool recurringRuleId, bool installmentPlanId})
        > {
  $$MovementsTableTableManager(_$AppDatabase db, $MovementsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$MovementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$MovementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$MovementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<MovementKind> kind = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<PaymentMethod?> paymentMethod = const Value.absent(),
                Value<int?> cardId = const Value.absent(),
                Value<bool> isUnexpected = const Value.absent(),
                Value<String?> incomeSource = const Value.absent(),
                Value<int?> recurringRuleId = const Value.absent(),
                Value<int?> installmentPlanId = const Value.absent(),
                Value<int?> installmentNumber = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MovementsCompanion(
                id: id,
                kind: kind,
                amount: amount,
                categoryId: categoryId,
                date: date,
                note: note,
                paymentMethod: paymentMethod,
                cardId: cardId,
                isUnexpected: isUnexpected,
                incomeSource: incomeSource,
                recurringRuleId: recurringRuleId,
                installmentPlanId: installmentPlanId,
                installmentNumber: installmentNumber,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required MovementKind kind,
                required int amount,
                required int categoryId,
                required DateTime date,
                Value<String?> note = const Value.absent(),
                Value<PaymentMethod?> paymentMethod = const Value.absent(),
                Value<int?> cardId = const Value.absent(),
                Value<bool> isUnexpected = const Value.absent(),
                Value<String?> incomeSource = const Value.absent(),
                Value<int?> recurringRuleId = const Value.absent(),
                Value<int?> installmentPlanId = const Value.absent(),
                Value<int?> installmentNumber = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MovementsCompanion.insert(
                id: id,
                kind: kind,
                amount: amount,
                categoryId: categoryId,
                date: date,
                note: note,
                paymentMethod: paymentMethod,
                cardId: cardId,
                isUnexpected: isUnexpected,
                incomeSource: incomeSource,
                recurringRuleId: recurringRuleId,
                installmentPlanId: installmentPlanId,
                installmentNumber: installmentNumber,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MovementsTable, MovementRow>(table),
                  $$MovementsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({categoryId = false, recurringRuleId = false, installmentPlanId = false}) {
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
                    if (categoryId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.categoryId,
                        referencedTable: $$MovementsTableReferences._categoryIdTable(db),
                        referencedColumn: $$MovementsTableReferences._categoryIdTable(db).id,
                      ) as T;
                    }
                    if (recurringRuleId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.recurringRuleId,
                        referencedTable: $$MovementsTableReferences._recurringRuleIdTable(db),
                        referencedColumn: $$MovementsTableReferences._recurringRuleIdTable(db).id,
                      ) as T;
                    }
                    if (installmentPlanId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.installmentPlanId,
                        referencedTable: $$MovementsTableReferences._installmentPlanIdTable(db),
                        referencedColumn: $$MovementsTableReferences._installmentPlanIdTable(db).id,
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

typedef $$MovementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MovementsTable,
      MovementRow,
      $$MovementsTableFilterComposer,
      $$MovementsTableOrderingComposer,
      $$MovementsTableAnnotationComposer,
      $$MovementsTableCreateCompanionBuilder,
      $$MovementsTableUpdateCompanionBuilder,
      (MovementRow, $$MovementsTableReferences),
      MovementRow,
      PrefetchHooks Function({bool categoryId, bool recurringRuleId, bool installmentPlanId})
    >;
typedef $$CardPaymentsTableCreateCompanionBuilder = CardPaymentsCompanion Function({
  Value<int> id,
  required int cardId,
  required int amount,
  required DateTime date,
  Value<String?> note,
  Value<DateTime> createdAt,
});
typedef $$CardPaymentsTableUpdateCompanionBuilder = CardPaymentsCompanion Function({
  Value<int> id,
  Value<int> cardId,
  Value<int> amount,
  Value<DateTime> date,
  Value<String?> note,
  Value<DateTime> createdAt,
});

final class $$CardPaymentsTableReferences
    extends BaseReferences<_$AppDatabase, $CardPaymentsTable, CardPaymentRow> {
  $$CardPaymentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CreditCardsTable _cardIdTable(_$AppDatabase db) =>
      db.creditCards.createAlias('card_payments__card_id__credit_cards__id');

  $$CreditCardsTableProcessedTableManager get cardId {
    final $_column = $_itemColumn<int>('card_id')!;

    final manager = $$CreditCardsTableTableManager(
      $_db,
      $_db.creditCards,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CardPaymentsTableFilterComposer extends Composer<_$AppDatabase, $CardPaymentsTable> {
  $$CardPaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$CreditCardsTableFilterComposer get cardId {
    final $$CreditCardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.creditCards,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CreditCardsTableFilterComposer(
            $db: $db,
            $table: $db.creditCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CardPaymentsTableOrderingComposer extends Composer<_$AppDatabase, $CardPaymentsTable> {
  $$CardPaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$CreditCardsTableOrderingComposer get cardId {
    final $$CreditCardsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.creditCards,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CreditCardsTableOrderingComposer(
            $db: $db,
            $table: $db.creditCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CardPaymentsTableAnnotationComposer extends Composer<_$AppDatabase, $CardPaymentsTable> {
  $$CardPaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amount => $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get date => $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get note => $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CreditCardsTableAnnotationComposer get cardId {
    final $$CreditCardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.creditCards,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CreditCardsTableAnnotationComposer(
            $db: $db,
            $table: $db.creditCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CardPaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CardPaymentsTable,
          CardPaymentRow,
          $$CardPaymentsTableFilterComposer,
          $$CardPaymentsTableOrderingComposer,
          $$CardPaymentsTableAnnotationComposer,
          $$CardPaymentsTableCreateCompanionBuilder,
          $$CardPaymentsTableUpdateCompanionBuilder,
          (CardPaymentRow, $$CardPaymentsTableReferences),
          CardPaymentRow,
          PrefetchHooks Function({bool cardId})
        > {
  $$CardPaymentsTableTableManager(_$AppDatabase db, $CardPaymentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$CardPaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$CardPaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$CardPaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> cardId = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CardPaymentsCompanion(
                id: id,
                cardId: cardId,
                amount: amount,
                date: date,
                note: note,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int cardId,
                required int amount,
                required DateTime date,
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CardPaymentsCompanion.insert(
                id: id,
                cardId: cardId,
                amount: amount,
                date: date,
                note: note,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CardPaymentsTable, CardPaymentRow>(table),
                  $$CardPaymentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({cardId = false}) {
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
                    if (cardId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.cardId,
                        referencedTable: $$CardPaymentsTableReferences._cardIdTable(db),
                        referencedColumn: $$CardPaymentsTableReferences._cardIdTable(db).id,
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

typedef $$CardPaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CardPaymentsTable,
      CardPaymentRow,
      $$CardPaymentsTableFilterComposer,
      $$CardPaymentsTableOrderingComposer,
      $$CardPaymentsTableAnnotationComposer,
      $$CardPaymentsTableCreateCompanionBuilder,
      $$CardPaymentsTableUpdateCompanionBuilder,
      (CardPaymentRow, $$CardPaymentsTableReferences),
      CardPaymentRow,
      PrefetchHooks Function({bool cardId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SettingsEntriesTableTableManager get settingsEntries =>
      $$SettingsEntriesTableTableManager(_db, _db.settingsEntries);
  $$CategoriesTableTableManager get categories => $$CategoriesTableTableManager(_db, _db.categories);
  $$RecurringRulesTableTableManager get recurringRules =>
      $$RecurringRulesTableTableManager(_db, _db.recurringRules);
  $$CreditCardsTableTableManager get creditCards => $$CreditCardsTableTableManager(_db, _db.creditCards);
  $$InstallmentPlansTableTableManager get installmentPlans =>
      $$InstallmentPlansTableTableManager(_db, _db.installmentPlans);
  $$MovementsTableTableManager get movements => $$MovementsTableTableManager(_db, _db.movements);
  $$CardPaymentsTableTableManager get cardPayments => $$CardPaymentsTableTableManager(_db, _db.cardPayments);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Se abre en `main()` antes de pintar la app y se inyecta con un override.

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

/// Se abre en `main()` antes de pintar la app y se inyecta con un override.

final class AppDatabaseProvider extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  /// Se abre en `main()` antes de pintar la app y se inyecta con un override.
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<AppDatabase>(value));
  }
}

String _$appDatabaseHash() => r'ebd06abd1f8b77d4c3329ee3f3674b69bf4e1588';
