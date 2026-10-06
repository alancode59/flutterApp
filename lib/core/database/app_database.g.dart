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
  late final $MovementsTable movements = $MovementsTable(this);
  late final Index movementsDate = Index('movements_date', 'CREATE INDEX movements_date ON movements (date)');
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    settingsEntries,
    categories,
    recurringRules,
    movements,
    movementsDate,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName('recurring_rules', limitUpdateKind: UpdateKind.delete),
      result: [TableUpdate('movements', kind: UpdateKind.update)],
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
          PrefetchHooks Function({bool recurringRulesRefs, bool movementsRefs})
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
          prefetchHooksCallback: ({recurringRulesRefs = false, movementsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (recurringRulesRefs) db.recurringRules,
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
      PrefetchHooks Function({bool recurringRulesRefs, bool movementsRefs})
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
          PrefetchHooks Function({bool categoryId, bool recurringRuleId})
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
          prefetchHooksCallback: ({categoryId = false, recurringRuleId = false}) {
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
      PrefetchHooks Function({bool categoryId, bool recurringRuleId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SettingsEntriesTableTableManager get settingsEntries =>
      $$SettingsEntriesTableTableManager(_db, _db.settingsEntries);
  $$CategoriesTableTableManager get categories => $$CategoriesTableTableManager(_db, _db.categories);
  $$RecurringRulesTableTableManager get recurringRules =>
      $$RecurringRulesTableTableManager(_db, _db.recurringRules);
  $$MovementsTableTableManager get movements => $$MovementsTableTableManager(_db, _db.movements);
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
