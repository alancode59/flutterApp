// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Movement {

/// 0 para movimientos que aún no se guardan.
 int get id; MovementKind get kind; int get amountCents; int get categoryId; DateTime get date; String? get note; PaymentMethod? get paymentMethod; int? get cardId; bool get isUnexpected; String? get incomeSource; int? get recurringRuleId;/// Mensualidad de una compra a MSI (1 = primera).
 int? get installmentPlanId; int? get installmentNumber;
/// Create a copy of Movement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MovementCopyWith<Movement> get copyWith => _$MovementCopyWithImpl<Movement>(this as Movement, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Movement;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Movement&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.amountCents, _this.amountCents) || other.amountCents == _this.amountCents)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.paymentMethod, _this.paymentMethod) || other.paymentMethod == _this.paymentMethod)&&(identical(other.cardId, _this.cardId) || other.cardId == _this.cardId)&&(identical(other.isUnexpected, _this.isUnexpected) || other.isUnexpected == _this.isUnexpected)&&(identical(other.incomeSource, _this.incomeSource) || other.incomeSource == _this.incomeSource)&&(identical(other.recurringRuleId, _this.recurringRuleId) || other.recurringRuleId == _this.recurringRuleId)&&(identical(other.installmentPlanId, _this.installmentPlanId) || other.installmentPlanId == _this.installmentPlanId)&&(identical(other.installmentNumber, _this.installmentNumber) || other.installmentNumber == _this.installmentNumber));
}


@override
int get hashCode {
  final _this = this as Movement;
  return Object.hash(runtimeType,_this.id,_this.kind,_this.amountCents,_this.categoryId,_this.date,_this.note,_this.paymentMethod,_this.cardId,_this.isUnexpected,_this.incomeSource,_this.recurringRuleId,_this.installmentPlanId,_this.installmentNumber);
}

@override
String toString() {
  final _this = this as Movement;
  return 'Movement(id: ${_this.id}, kind: ${_this.kind}, amountCents: ${_this.amountCents}, categoryId: ${_this.categoryId}, date: ${_this.date}, note: ${_this.note}, paymentMethod: ${_this.paymentMethod}, cardId: ${_this.cardId}, isUnexpected: ${_this.isUnexpected}, incomeSource: ${_this.incomeSource}, recurringRuleId: ${_this.recurringRuleId}, installmentPlanId: ${_this.installmentPlanId}, installmentNumber: ${_this.installmentNumber})';
}


}

/// @nodoc
abstract mixin class $MovementCopyWith<$Res>  {
  factory $MovementCopyWith(Movement value, $Res Function(Movement) _then) = _$MovementCopyWithImpl;
@useResult
$Res call({
 int id, MovementKind kind, int amountCents, int categoryId, DateTime date, String? note, PaymentMethod? paymentMethod, int? cardId, bool isUnexpected, String? incomeSource, int? recurringRuleId, int? installmentPlanId, int? installmentNumber
});




}
/// @nodoc
class _$MovementCopyWithImpl<$Res>
    implements $MovementCopyWith<$Res> {
  _$MovementCopyWithImpl(this._self, this._then);

  final Movement _self;
  final $Res Function(Movement) _then;

/// Create a copy of Movement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? kind = null,Object? amountCents = null,Object? categoryId = null,Object? date = null,Object? note = freezed,Object? paymentMethod = freezed,Object? cardId = freezed,Object? isUnexpected = null,Object? incomeSource = freezed,Object? recurringRuleId = freezed,Object? installmentPlanId = freezed,Object? installmentNumber = freezed,}) {
  return _then(Movement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as MovementKind,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod?,cardId: freezed == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as int?,isUnexpected: null == isUnexpected ? _self.isUnexpected : isUnexpected // ignore: cast_nullable_to_non_nullable
as bool,incomeSource: freezed == incomeSource ? _self.incomeSource : incomeSource // ignore: cast_nullable_to_non_nullable
as String?,recurringRuleId: freezed == recurringRuleId ? _self.recurringRuleId : recurringRuleId // ignore: cast_nullable_to_non_nullable
as int?,installmentPlanId: freezed == installmentPlanId ? _self.installmentPlanId : installmentPlanId // ignore: cast_nullable_to_non_nullable
as int?,installmentNumber: freezed == installmentNumber ? _self.installmentNumber : installmentNumber // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Movement].
extension MovementPatterns on Movement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Movement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Movement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Movement value)  $default,){
final _that = this;
switch (_that) {
case _Movement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Movement value)?  $default,){
final _that = this;
switch (_that) {
case _Movement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  MovementKind kind,  int amountCents,  int categoryId,  DateTime date,  String? note,  PaymentMethod? paymentMethod,  int? cardId,  bool isUnexpected,  String? incomeSource,  int? recurringRuleId,  int? installmentPlanId,  int? installmentNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Movement() when $default != null:
return $default(_that.id,_that.kind,_that.amountCents,_that.categoryId,_that.date,_that.note,_that.paymentMethod,_that.cardId,_that.isUnexpected,_that.incomeSource,_that.recurringRuleId,_that.installmentPlanId,_that.installmentNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  MovementKind kind,  int amountCents,  int categoryId,  DateTime date,  String? note,  PaymentMethod? paymentMethod,  int? cardId,  bool isUnexpected,  String? incomeSource,  int? recurringRuleId,  int? installmentPlanId,  int? installmentNumber)  $default,) {final _that = this;
switch (_that) {
case _Movement():
return $default(_that.id,_that.kind,_that.amountCents,_that.categoryId,_that.date,_that.note,_that.paymentMethod,_that.cardId,_that.isUnexpected,_that.incomeSource,_that.recurringRuleId,_that.installmentPlanId,_that.installmentNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  MovementKind kind,  int amountCents,  int categoryId,  DateTime date,  String? note,  PaymentMethod? paymentMethod,  int? cardId,  bool isUnexpected,  String? incomeSource,  int? recurringRuleId,  int? installmentPlanId,  int? installmentNumber)?  $default,) {final _that = this;
switch (_that) {
case _Movement() when $default != null:
return $default(_that.id,_that.kind,_that.amountCents,_that.categoryId,_that.date,_that.note,_that.paymentMethod,_that.cardId,_that.isUnexpected,_that.incomeSource,_that.recurringRuleId,_that.installmentPlanId,_that.installmentNumber);case _:
  return null;

}
}

}

/// @nodoc


class _Movement extends Movement {
  const _Movement({this.id = 0, required this.kind, required this.amountCents, required this.categoryId, required this.date, this.note, this.paymentMethod, this.cardId, this.isUnexpected = false, this.incomeSource, this.recurringRuleId, this.installmentPlanId, this.installmentNumber}): super._();
  

/// 0 para movimientos que aún no se guardan.
@override@JsonKey() final  int id;
@override final  MovementKind kind;
@override final  int amountCents;
@override final  int categoryId;
@override final  DateTime date;
@override final  String? note;
@override final  PaymentMethod? paymentMethod;
@override final  int? cardId;
@override@JsonKey() final  bool isUnexpected;
@override final  String? incomeSource;
@override final  int? recurringRuleId;
/// Mensualidad de una compra a MSI (1 = primera).
@override final  int? installmentPlanId;
@override final  int? installmentNumber;

/// Create a copy of Movement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MovementCopyWith<_Movement> get copyWith => __$MovementCopyWithImpl<_Movement>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Movement&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.amountCents, amountCents) || other.amountCents == amountCents)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.date, date) || other.date == date)&&(identical(other.note, note) || other.note == note)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.cardId, cardId) || other.cardId == cardId)&&(identical(other.isUnexpected, isUnexpected) || other.isUnexpected == isUnexpected)&&(identical(other.incomeSource, incomeSource) || other.incomeSource == incomeSource)&&(identical(other.recurringRuleId, recurringRuleId) || other.recurringRuleId == recurringRuleId)&&(identical(other.installmentPlanId, installmentPlanId) || other.installmentPlanId == installmentPlanId)&&(identical(other.installmentNumber, installmentNumber) || other.installmentNumber == installmentNumber));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,kind,amountCents,categoryId,date,note,paymentMethod,cardId,isUnexpected,incomeSource,recurringRuleId,installmentPlanId,installmentNumber);
}

@override
String toString() {
    return 'Movement(id: $id, kind: $kind, amountCents: $amountCents, categoryId: $categoryId, date: $date, note: $note, paymentMethod: $paymentMethod, cardId: $cardId, isUnexpected: $isUnexpected, incomeSource: $incomeSource, recurringRuleId: $recurringRuleId, installmentPlanId: $installmentPlanId, installmentNumber: $installmentNumber)';
}


}

/// @nodoc
abstract mixin class _$MovementCopyWith<$Res> implements $MovementCopyWith<$Res> {
  factory _$MovementCopyWith(_Movement value, $Res Function(_Movement) _then) = __$MovementCopyWithImpl;
@override @useResult
$Res call({
 int id, MovementKind kind, int amountCents, int categoryId, DateTime date, String? note, PaymentMethod? paymentMethod, int? cardId, bool isUnexpected, String? incomeSource, int? recurringRuleId, int? installmentPlanId, int? installmentNumber
});




}
/// @nodoc
class __$MovementCopyWithImpl<$Res>
    implements _$MovementCopyWith<$Res> {
  __$MovementCopyWithImpl(this._self, this._then);

  final _Movement _self;
  final $Res Function(_Movement) _then;

/// Create a copy of Movement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? kind = null,Object? amountCents = null,Object? categoryId = null,Object? date = null,Object? note = freezed,Object? paymentMethod = freezed,Object? cardId = freezed,Object? isUnexpected = null,Object? incomeSource = freezed,Object? recurringRuleId = freezed,Object? installmentPlanId = freezed,Object? installmentNumber = freezed,}) {
  return _then(_Movement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as MovementKind,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod?,cardId: freezed == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as int?,isUnexpected: null == isUnexpected ? _self.isUnexpected : isUnexpected // ignore: cast_nullable_to_non_nullable
as bool,incomeSource: freezed == incomeSource ? _self.incomeSource : incomeSource // ignore: cast_nullable_to_non_nullable
as String?,recurringRuleId: freezed == recurringRuleId ? _self.recurringRuleId : recurringRuleId // ignore: cast_nullable_to_non_nullable
as int?,installmentPlanId: freezed == installmentPlanId ? _self.installmentPlanId : installmentPlanId // ignore: cast_nullable_to_non_nullable
as int?,installmentNumber: freezed == installmentNumber ? _self.installmentNumber : installmentNumber // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
