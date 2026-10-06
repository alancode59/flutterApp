// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recurring_rule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecurringRule {

 int get id; MovementKind get kind; String get name; int get amountCents; int get categoryId; Frequency get frequency; DateTime get startDate; DateTime? get endDate; PaymentMethod? get paymentMethod; int? get cardId; String? get incomeSource;/// Último día hasta el que ya se generaron movimientos.
 DateTime? get lastGeneratedDate; bool get active;
/// Create a copy of RecurringRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurringRuleCopyWith<RecurringRule> get copyWith => _$RecurringRuleCopyWithImpl<RecurringRule>(this as RecurringRule, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RecurringRule;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringRule&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.amountCents, _this.amountCents) || other.amountCents == _this.amountCents)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.frequency, _this.frequency) || other.frequency == _this.frequency)&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.endDate, _this.endDate) || other.endDate == _this.endDate)&&(identical(other.paymentMethod, _this.paymentMethod) || other.paymentMethod == _this.paymentMethod)&&(identical(other.cardId, _this.cardId) || other.cardId == _this.cardId)&&(identical(other.incomeSource, _this.incomeSource) || other.incomeSource == _this.incomeSource)&&(identical(other.lastGeneratedDate, _this.lastGeneratedDate) || other.lastGeneratedDate == _this.lastGeneratedDate)&&(identical(other.active, _this.active) || other.active == _this.active));
}


@override
int get hashCode {
  final _this = this as RecurringRule;
  return Object.hash(runtimeType,_this.id,_this.kind,_this.name,_this.amountCents,_this.categoryId,_this.frequency,_this.startDate,_this.endDate,_this.paymentMethod,_this.cardId,_this.incomeSource,_this.lastGeneratedDate,_this.active);
}

@override
String toString() {
  final _this = this as RecurringRule;
  return 'RecurringRule(id: ${_this.id}, kind: ${_this.kind}, name: ${_this.name}, amountCents: ${_this.amountCents}, categoryId: ${_this.categoryId}, frequency: ${_this.frequency}, startDate: ${_this.startDate}, endDate: ${_this.endDate}, paymentMethod: ${_this.paymentMethod}, cardId: ${_this.cardId}, incomeSource: ${_this.incomeSource}, lastGeneratedDate: ${_this.lastGeneratedDate}, active: ${_this.active})';
}


}

/// @nodoc
abstract mixin class $RecurringRuleCopyWith<$Res>  {
  factory $RecurringRuleCopyWith(RecurringRule value, $Res Function(RecurringRule) _then) = _$RecurringRuleCopyWithImpl;
@useResult
$Res call({
 int id, MovementKind kind, String name, int amountCents, int categoryId, Frequency frequency, DateTime startDate, DateTime? endDate, PaymentMethod? paymentMethod, int? cardId, String? incomeSource, DateTime? lastGeneratedDate, bool active
});




}
/// @nodoc
class _$RecurringRuleCopyWithImpl<$Res>
    implements $RecurringRuleCopyWith<$Res> {
  _$RecurringRuleCopyWithImpl(this._self, this._then);

  final RecurringRule _self;
  final $Res Function(RecurringRule) _then;

/// Create a copy of RecurringRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? kind = null,Object? name = null,Object? amountCents = null,Object? categoryId = null,Object? frequency = null,Object? startDate = null,Object? endDate = freezed,Object? paymentMethod = freezed,Object? cardId = freezed,Object? incomeSource = freezed,Object? lastGeneratedDate = freezed,Object? active = null,}) {
  return _then(RecurringRule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as MovementKind,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as Frequency,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod?,cardId: freezed == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as int?,incomeSource: freezed == incomeSource ? _self.incomeSource : incomeSource // ignore: cast_nullable_to_non_nullable
as String?,lastGeneratedDate: freezed == lastGeneratedDate ? _self.lastGeneratedDate : lastGeneratedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RecurringRule].
extension RecurringRulePatterns on RecurringRule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecurringRule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecurringRule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecurringRule value)  $default,){
final _that = this;
switch (_that) {
case _RecurringRule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecurringRule value)?  $default,){
final _that = this;
switch (_that) {
case _RecurringRule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  MovementKind kind,  String name,  int amountCents,  int categoryId,  Frequency frequency,  DateTime startDate,  DateTime? endDate,  PaymentMethod? paymentMethod,  int? cardId,  String? incomeSource,  DateTime? lastGeneratedDate,  bool active)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecurringRule() when $default != null:
return $default(_that.id,_that.kind,_that.name,_that.amountCents,_that.categoryId,_that.frequency,_that.startDate,_that.endDate,_that.paymentMethod,_that.cardId,_that.incomeSource,_that.lastGeneratedDate,_that.active);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  MovementKind kind,  String name,  int amountCents,  int categoryId,  Frequency frequency,  DateTime startDate,  DateTime? endDate,  PaymentMethod? paymentMethod,  int? cardId,  String? incomeSource,  DateTime? lastGeneratedDate,  bool active)  $default,) {final _that = this;
switch (_that) {
case _RecurringRule():
return $default(_that.id,_that.kind,_that.name,_that.amountCents,_that.categoryId,_that.frequency,_that.startDate,_that.endDate,_that.paymentMethod,_that.cardId,_that.incomeSource,_that.lastGeneratedDate,_that.active);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  MovementKind kind,  String name,  int amountCents,  int categoryId,  Frequency frequency,  DateTime startDate,  DateTime? endDate,  PaymentMethod? paymentMethod,  int? cardId,  String? incomeSource,  DateTime? lastGeneratedDate,  bool active)?  $default,) {final _that = this;
switch (_that) {
case _RecurringRule() when $default != null:
return $default(_that.id,_that.kind,_that.name,_that.amountCents,_that.categoryId,_that.frequency,_that.startDate,_that.endDate,_that.paymentMethod,_that.cardId,_that.incomeSource,_that.lastGeneratedDate,_that.active);case _:
  return null;

}
}

}

/// @nodoc


class _RecurringRule implements RecurringRule {
  const _RecurringRule({this.id = 0, required this.kind, required this.name, required this.amountCents, required this.categoryId, required this.frequency, required this.startDate, this.endDate, this.paymentMethod, this.cardId, this.incomeSource, this.lastGeneratedDate, this.active = true});
  

@override@JsonKey() final  int id;
@override final  MovementKind kind;
@override final  String name;
@override final  int amountCents;
@override final  int categoryId;
@override final  Frequency frequency;
@override final  DateTime startDate;
@override final  DateTime? endDate;
@override final  PaymentMethod? paymentMethod;
@override final  int? cardId;
@override final  String? incomeSource;
/// Último día hasta el que ya se generaron movimientos.
@override final  DateTime? lastGeneratedDate;
@override@JsonKey() final  bool active;

/// Create a copy of RecurringRule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecurringRuleCopyWith<_RecurringRule> get copyWith => __$RecurringRuleCopyWithImpl<_RecurringRule>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecurringRule&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.name, name) || other.name == name)&&(identical(other.amountCents, amountCents) || other.amountCents == amountCents)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.cardId, cardId) || other.cardId == cardId)&&(identical(other.incomeSource, incomeSource) || other.incomeSource == incomeSource)&&(identical(other.lastGeneratedDate, lastGeneratedDate) || other.lastGeneratedDate == lastGeneratedDate)&&(identical(other.active, active) || other.active == active));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,kind,name,amountCents,categoryId,frequency,startDate,endDate,paymentMethod,cardId,incomeSource,lastGeneratedDate,active);
}

@override
String toString() {
    return 'RecurringRule(id: $id, kind: $kind, name: $name, amountCents: $amountCents, categoryId: $categoryId, frequency: $frequency, startDate: $startDate, endDate: $endDate, paymentMethod: $paymentMethod, cardId: $cardId, incomeSource: $incomeSource, lastGeneratedDate: $lastGeneratedDate, active: $active)';
}


}

/// @nodoc
abstract mixin class _$RecurringRuleCopyWith<$Res> implements $RecurringRuleCopyWith<$Res> {
  factory _$RecurringRuleCopyWith(_RecurringRule value, $Res Function(_RecurringRule) _then) = __$RecurringRuleCopyWithImpl;
@override @useResult
$Res call({
 int id, MovementKind kind, String name, int amountCents, int categoryId, Frequency frequency, DateTime startDate, DateTime? endDate, PaymentMethod? paymentMethod, int? cardId, String? incomeSource, DateTime? lastGeneratedDate, bool active
});




}
/// @nodoc
class __$RecurringRuleCopyWithImpl<$Res>
    implements _$RecurringRuleCopyWith<$Res> {
  __$RecurringRuleCopyWithImpl(this._self, this._then);

  final _RecurringRule _self;
  final $Res Function(_RecurringRule) _then;

/// Create a copy of RecurringRule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? kind = null,Object? name = null,Object? amountCents = null,Object? categoryId = null,Object? frequency = null,Object? startDate = null,Object? endDate = freezed,Object? paymentMethod = freezed,Object? cardId = freezed,Object? incomeSource = freezed,Object? lastGeneratedDate = freezed,Object? active = null,}) {
  return _then(_RecurringRule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as MovementKind,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as Frequency,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod?,cardId: freezed == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as int?,incomeSource: freezed == incomeSource ? _self.incomeSource : incomeSource // ignore: cast_nullable_to_non_nullable
as String?,lastGeneratedDate: freezed == lastGeneratedDate ? _self.lastGeneratedDate : lastGeneratedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
