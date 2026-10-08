// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credit_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreditCard {

 int get id;/// Alias que eligió el usuario ("Oro", "La de los viajes"…).
 String get name; String? get bank;/// Últimos 4 dígitos, solo para reconocerla. Nunca el número completo.
 String? get last4; CardNetwork get network; int get colorIndex; int get limitCents;/// Día del mes del corte (1–31; en meses cortos se usa el último día).
 int get cutoffDay;/// Día del mes de la fecha límite de pago, posterior al corte.
 int get dueDay;/// Deuda total según el banco en [balanceDate] (incluye compras del
/// periodo y MSI pendientes). Sin [balanceDate] es el saldo que ya debía
/// al darla de alta y se considera parte del corte anterior a [createdAt].
 int get openingBalanceCents;/// Cuándo se copiaron los saldos del banco. Las compras y pagos
/// registrados antes de esta fecha ya están incluidos en ellos.
 DateTime? get balanceDate;/// Pago para no generar intereses que faltaba en [balanceDate].
 int? get statementRemainingCents;/// Pago mínimo que faltaba en [balanceDate]. Si no se da, se estima.
 int? get minimumPaymentCents; DateTime get createdAt; bool get archived;
/// Create a copy of CreditCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreditCardCopyWith<CreditCard> get copyWith => _$CreditCardCopyWithImpl<CreditCard>(this as CreditCard, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CreditCard;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreditCard&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.bank, _this.bank) || other.bank == _this.bank)&&(identical(other.last4, _this.last4) || other.last4 == _this.last4)&&(identical(other.network, _this.network) || other.network == _this.network)&&(identical(other.colorIndex, _this.colorIndex) || other.colorIndex == _this.colorIndex)&&(identical(other.limitCents, _this.limitCents) || other.limitCents == _this.limitCents)&&(identical(other.cutoffDay, _this.cutoffDay) || other.cutoffDay == _this.cutoffDay)&&(identical(other.dueDay, _this.dueDay) || other.dueDay == _this.dueDay)&&(identical(other.openingBalanceCents, _this.openingBalanceCents) || other.openingBalanceCents == _this.openingBalanceCents)&&(identical(other.balanceDate, _this.balanceDate) || other.balanceDate == _this.balanceDate)&&(identical(other.statementRemainingCents, _this.statementRemainingCents) || other.statementRemainingCents == _this.statementRemainingCents)&&(identical(other.minimumPaymentCents, _this.minimumPaymentCents) || other.minimumPaymentCents == _this.minimumPaymentCents)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.archived, _this.archived) || other.archived == _this.archived));
}


@override
int get hashCode {
  final _this = this as CreditCard;
  return Object.hash(runtimeType,_this.id,_this.name,_this.bank,_this.last4,_this.network,_this.colorIndex,_this.limitCents,_this.cutoffDay,_this.dueDay,_this.openingBalanceCents,_this.balanceDate,_this.statementRemainingCents,_this.minimumPaymentCents,_this.createdAt,_this.archived);
}

@override
String toString() {
  final _this = this as CreditCard;
  return 'CreditCard(id: ${_this.id}, name: ${_this.name}, bank: ${_this.bank}, last4: ${_this.last4}, network: ${_this.network}, colorIndex: ${_this.colorIndex}, limitCents: ${_this.limitCents}, cutoffDay: ${_this.cutoffDay}, dueDay: ${_this.dueDay}, openingBalanceCents: ${_this.openingBalanceCents}, balanceDate: ${_this.balanceDate}, statementRemainingCents: ${_this.statementRemainingCents}, minimumPaymentCents: ${_this.minimumPaymentCents}, createdAt: ${_this.createdAt}, archived: ${_this.archived})';
}


}

/// @nodoc
abstract mixin class $CreditCardCopyWith<$Res>  {
  factory $CreditCardCopyWith(CreditCard value, $Res Function(CreditCard) _then) = _$CreditCardCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? bank, String? last4, CardNetwork network, int colorIndex, int limitCents, int cutoffDay, int dueDay, int openingBalanceCents, DateTime? balanceDate, int? statementRemainingCents, int? minimumPaymentCents, DateTime createdAt, bool archived
});




}
/// @nodoc
class _$CreditCardCopyWithImpl<$Res>
    implements $CreditCardCopyWith<$Res> {
  _$CreditCardCopyWithImpl(this._self, this._then);

  final CreditCard _self;
  final $Res Function(CreditCard) _then;

/// Create a copy of CreditCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? bank = freezed,Object? last4 = freezed,Object? network = null,Object? colorIndex = null,Object? limitCents = null,Object? cutoffDay = null,Object? dueDay = null,Object? openingBalanceCents = null,Object? balanceDate = freezed,Object? statementRemainingCents = freezed,Object? minimumPaymentCents = freezed,Object? createdAt = null,Object? archived = null,}) {
  return _then(CreditCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,bank: freezed == bank ? _self.bank : bank // ignore: cast_nullable_to_non_nullable
as String?,last4: freezed == last4 ? _self.last4 : last4 // ignore: cast_nullable_to_non_nullable
as String?,network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as CardNetwork,colorIndex: null == colorIndex ? _self.colorIndex : colorIndex // ignore: cast_nullable_to_non_nullable
as int,limitCents: null == limitCents ? _self.limitCents : limitCents // ignore: cast_nullable_to_non_nullable
as int,cutoffDay: null == cutoffDay ? _self.cutoffDay : cutoffDay // ignore: cast_nullable_to_non_nullable
as int,dueDay: null == dueDay ? _self.dueDay : dueDay // ignore: cast_nullable_to_non_nullable
as int,openingBalanceCents: null == openingBalanceCents ? _self.openingBalanceCents : openingBalanceCents // ignore: cast_nullable_to_non_nullable
as int,balanceDate: freezed == balanceDate ? _self.balanceDate : balanceDate // ignore: cast_nullable_to_non_nullable
as DateTime?,statementRemainingCents: freezed == statementRemainingCents ? _self.statementRemainingCents : statementRemainingCents // ignore: cast_nullable_to_non_nullable
as int?,minimumPaymentCents: freezed == minimumPaymentCents ? _self.minimumPaymentCents : minimumPaymentCents // ignore: cast_nullable_to_non_nullable
as int?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,archived: null == archived ? _self.archived : archived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CreditCard].
extension CreditCardPatterns on CreditCard {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreditCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreditCard() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreditCard value)  $default,){
final _that = this;
switch (_that) {
case _CreditCard():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreditCard value)?  $default,){
final _that = this;
switch (_that) {
case _CreditCard() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? bank,  String? last4,  CardNetwork network,  int colorIndex,  int limitCents,  int cutoffDay,  int dueDay,  int openingBalanceCents,  DateTime? balanceDate,  int? statementRemainingCents,  int? minimumPaymentCents,  DateTime createdAt,  bool archived)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreditCard() when $default != null:
return $default(_that.id,_that.name,_that.bank,_that.last4,_that.network,_that.colorIndex,_that.limitCents,_that.cutoffDay,_that.dueDay,_that.openingBalanceCents,_that.balanceDate,_that.statementRemainingCents,_that.minimumPaymentCents,_that.createdAt,_that.archived);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? bank,  String? last4,  CardNetwork network,  int colorIndex,  int limitCents,  int cutoffDay,  int dueDay,  int openingBalanceCents,  DateTime? balanceDate,  int? statementRemainingCents,  int? minimumPaymentCents,  DateTime createdAt,  bool archived)  $default,) {final _that = this;
switch (_that) {
case _CreditCard():
return $default(_that.id,_that.name,_that.bank,_that.last4,_that.network,_that.colorIndex,_that.limitCents,_that.cutoffDay,_that.dueDay,_that.openingBalanceCents,_that.balanceDate,_that.statementRemainingCents,_that.minimumPaymentCents,_that.createdAt,_that.archived);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? bank,  String? last4,  CardNetwork network,  int colorIndex,  int limitCents,  int cutoffDay,  int dueDay,  int openingBalanceCents,  DateTime? balanceDate,  int? statementRemainingCents,  int? minimumPaymentCents,  DateTime createdAt,  bool archived)?  $default,) {final _that = this;
switch (_that) {
case _CreditCard() when $default != null:
return $default(_that.id,_that.name,_that.bank,_that.last4,_that.network,_that.colorIndex,_that.limitCents,_that.cutoffDay,_that.dueDay,_that.openingBalanceCents,_that.balanceDate,_that.statementRemainingCents,_that.minimumPaymentCents,_that.createdAt,_that.archived);case _:
  return null;

}
}

}

/// @nodoc


class _CreditCard extends CreditCard {
  const _CreditCard({this.id = 0, required this.name, this.bank, this.last4, this.network = CardNetwork.visa, this.colorIndex = 0, required this.limitCents, required this.cutoffDay, required this.dueDay, this.openingBalanceCents = 0, this.balanceDate, this.statementRemainingCents, this.minimumPaymentCents, required this.createdAt, this.archived = false}): super._();
  

@override@JsonKey() final  int id;
/// Alias que eligió el usuario ("Oro", "La de los viajes"…).
@override final  String name;
@override final  String? bank;
/// Últimos 4 dígitos, solo para reconocerla. Nunca el número completo.
@override final  String? last4;
@override@JsonKey() final  CardNetwork network;
@override@JsonKey() final  int colorIndex;
@override final  int limitCents;
/// Día del mes del corte (1–31; en meses cortos se usa el último día).
@override final  int cutoffDay;
/// Día del mes de la fecha límite de pago, posterior al corte.
@override final  int dueDay;
/// Deuda total según el banco en [balanceDate] (incluye compras del
/// periodo y MSI pendientes). Sin [balanceDate] es el saldo que ya debía
/// al darla de alta y se considera parte del corte anterior a [createdAt].
@override@JsonKey() final  int openingBalanceCents;
/// Cuándo se copiaron los saldos del banco. Las compras y pagos
/// registrados antes de esta fecha ya están incluidos en ellos.
@override final  DateTime? balanceDate;
/// Pago para no generar intereses que faltaba en [balanceDate].
@override final  int? statementRemainingCents;
/// Pago mínimo que faltaba en [balanceDate]. Si no se da, se estima.
@override final  int? minimumPaymentCents;
@override final  DateTime createdAt;
@override@JsonKey() final  bool archived;

/// Create a copy of CreditCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreditCardCopyWith<_CreditCard> get copyWith => __$CreditCardCopyWithImpl<_CreditCard>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreditCard&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.bank, bank) || other.bank == bank)&&(identical(other.last4, last4) || other.last4 == last4)&&(identical(other.network, network) || other.network == network)&&(identical(other.colorIndex, colorIndex) || other.colorIndex == colorIndex)&&(identical(other.limitCents, limitCents) || other.limitCents == limitCents)&&(identical(other.cutoffDay, cutoffDay) || other.cutoffDay == cutoffDay)&&(identical(other.dueDay, dueDay) || other.dueDay == dueDay)&&(identical(other.openingBalanceCents, openingBalanceCents) || other.openingBalanceCents == openingBalanceCents)&&(identical(other.balanceDate, balanceDate) || other.balanceDate == balanceDate)&&(identical(other.statementRemainingCents, statementRemainingCents) || other.statementRemainingCents == statementRemainingCents)&&(identical(other.minimumPaymentCents, minimumPaymentCents) || other.minimumPaymentCents == minimumPaymentCents)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.archived, archived) || other.archived == archived));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,bank,last4,network,colorIndex,limitCents,cutoffDay,dueDay,openingBalanceCents,balanceDate,statementRemainingCents,minimumPaymentCents,createdAt,archived);
}

@override
String toString() {
    return 'CreditCard(id: $id, name: $name, bank: $bank, last4: $last4, network: $network, colorIndex: $colorIndex, limitCents: $limitCents, cutoffDay: $cutoffDay, dueDay: $dueDay, openingBalanceCents: $openingBalanceCents, balanceDate: $balanceDate, statementRemainingCents: $statementRemainingCents, minimumPaymentCents: $minimumPaymentCents, createdAt: $createdAt, archived: $archived)';
}


}

/// @nodoc
abstract mixin class _$CreditCardCopyWith<$Res> implements $CreditCardCopyWith<$Res> {
  factory _$CreditCardCopyWith(_CreditCard value, $Res Function(_CreditCard) _then) = __$CreditCardCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? bank, String? last4, CardNetwork network, int colorIndex, int limitCents, int cutoffDay, int dueDay, int openingBalanceCents, DateTime? balanceDate, int? statementRemainingCents, int? minimumPaymentCents, DateTime createdAt, bool archived
});




}
/// @nodoc
class __$CreditCardCopyWithImpl<$Res>
    implements _$CreditCardCopyWith<$Res> {
  __$CreditCardCopyWithImpl(this._self, this._then);

  final _CreditCard _self;
  final $Res Function(_CreditCard) _then;

/// Create a copy of CreditCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? bank = freezed,Object? last4 = freezed,Object? network = null,Object? colorIndex = null,Object? limitCents = null,Object? cutoffDay = null,Object? dueDay = null,Object? openingBalanceCents = null,Object? balanceDate = freezed,Object? statementRemainingCents = freezed,Object? minimumPaymentCents = freezed,Object? createdAt = null,Object? archived = null,}) {
  return _then(_CreditCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,bank: freezed == bank ? _self.bank : bank // ignore: cast_nullable_to_non_nullable
as String?,last4: freezed == last4 ? _self.last4 : last4 // ignore: cast_nullable_to_non_nullable
as String?,network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as CardNetwork,colorIndex: null == colorIndex ? _self.colorIndex : colorIndex // ignore: cast_nullable_to_non_nullable
as int,limitCents: null == limitCents ? _self.limitCents : limitCents // ignore: cast_nullable_to_non_nullable
as int,cutoffDay: null == cutoffDay ? _self.cutoffDay : cutoffDay // ignore: cast_nullable_to_non_nullable
as int,dueDay: null == dueDay ? _self.dueDay : dueDay // ignore: cast_nullable_to_non_nullable
as int,openingBalanceCents: null == openingBalanceCents ? _self.openingBalanceCents : openingBalanceCents // ignore: cast_nullable_to_non_nullable
as int,balanceDate: freezed == balanceDate ? _self.balanceDate : balanceDate // ignore: cast_nullable_to_non_nullable
as DateTime?,statementRemainingCents: freezed == statementRemainingCents ? _self.statementRemainingCents : statementRemainingCents // ignore: cast_nullable_to_non_nullable
as int?,minimumPaymentCents: freezed == minimumPaymentCents ? _self.minimumPaymentCents : minimumPaymentCents // ignore: cast_nullable_to_non_nullable
as int?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,archived: null == archived ? _self.archived : archived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
