// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'installment_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InstallmentPlan {

 int get id; int get cardId; String get description; int get totalCents; int get months; int get categoryId; DateTime get purchaseDate;
/// Create a copy of InstallmentPlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InstallmentPlanCopyWith<InstallmentPlan> get copyWith => _$InstallmentPlanCopyWithImpl<InstallmentPlan>(this as InstallmentPlan, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as InstallmentPlan;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InstallmentPlan&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.cardId, _this.cardId) || other.cardId == _this.cardId)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.totalCents, _this.totalCents) || other.totalCents == _this.totalCents)&&(identical(other.months, _this.months) || other.months == _this.months)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.purchaseDate, _this.purchaseDate) || other.purchaseDate == _this.purchaseDate));
}


@override
int get hashCode {
  final _this = this as InstallmentPlan;
  return Object.hash(runtimeType,_this.id,_this.cardId,_this.description,_this.totalCents,_this.months,_this.categoryId,_this.purchaseDate);
}

@override
String toString() {
  final _this = this as InstallmentPlan;
  return 'InstallmentPlan(id: ${_this.id}, cardId: ${_this.cardId}, description: ${_this.description}, totalCents: ${_this.totalCents}, months: ${_this.months}, categoryId: ${_this.categoryId}, purchaseDate: ${_this.purchaseDate})';
}


}

/// @nodoc
abstract mixin class $InstallmentPlanCopyWith<$Res>  {
  factory $InstallmentPlanCopyWith(InstallmentPlan value, $Res Function(InstallmentPlan) _then) = _$InstallmentPlanCopyWithImpl;
@useResult
$Res call({
 int id, int cardId, String description, int totalCents, int months, int categoryId, DateTime purchaseDate
});




}
/// @nodoc
class _$InstallmentPlanCopyWithImpl<$Res>
    implements $InstallmentPlanCopyWith<$Res> {
  _$InstallmentPlanCopyWithImpl(this._self, this._then);

  final InstallmentPlan _self;
  final $Res Function(InstallmentPlan) _then;

/// Create a copy of InstallmentPlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? cardId = null,Object? description = null,Object? totalCents = null,Object? months = null,Object? categoryId = null,Object? purchaseDate = null,}) {
  return _then(InstallmentPlan(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,cardId: null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,totalCents: null == totalCents ? _self.totalCents : totalCents // ignore: cast_nullable_to_non_nullable
as int,months: null == months ? _self.months : months // ignore: cast_nullable_to_non_nullable
as int,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,purchaseDate: null == purchaseDate ? _self.purchaseDate : purchaseDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [InstallmentPlan].
extension InstallmentPlanPatterns on InstallmentPlan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InstallmentPlan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InstallmentPlan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InstallmentPlan value)  $default,){
final _that = this;
switch (_that) {
case _InstallmentPlan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InstallmentPlan value)?  $default,){
final _that = this;
switch (_that) {
case _InstallmentPlan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int cardId,  String description,  int totalCents,  int months,  int categoryId,  DateTime purchaseDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InstallmentPlan() when $default != null:
return $default(_that.id,_that.cardId,_that.description,_that.totalCents,_that.months,_that.categoryId,_that.purchaseDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int cardId,  String description,  int totalCents,  int months,  int categoryId,  DateTime purchaseDate)  $default,) {final _that = this;
switch (_that) {
case _InstallmentPlan():
return $default(_that.id,_that.cardId,_that.description,_that.totalCents,_that.months,_that.categoryId,_that.purchaseDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int cardId,  String description,  int totalCents,  int months,  int categoryId,  DateTime purchaseDate)?  $default,) {final _that = this;
switch (_that) {
case _InstallmentPlan() when $default != null:
return $default(_that.id,_that.cardId,_that.description,_that.totalCents,_that.months,_that.categoryId,_that.purchaseDate);case _:
  return null;

}
}

}

/// @nodoc


class _InstallmentPlan extends InstallmentPlan {
  const _InstallmentPlan({this.id = 0, required this.cardId, required this.description, required this.totalCents, required this.months, required this.categoryId, required this.purchaseDate}): super._();
  

@override@JsonKey() final  int id;
@override final  int cardId;
@override final  String description;
@override final  int totalCents;
@override final  int months;
@override final  int categoryId;
@override final  DateTime purchaseDate;

/// Create a copy of InstallmentPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InstallmentPlanCopyWith<_InstallmentPlan> get copyWith => __$InstallmentPlanCopyWithImpl<_InstallmentPlan>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _InstallmentPlan&&(identical(other.id, id) || other.id == id)&&(identical(other.cardId, cardId) || other.cardId == cardId)&&(identical(other.description, description) || other.description == description)&&(identical(other.totalCents, totalCents) || other.totalCents == totalCents)&&(identical(other.months, months) || other.months == months)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.purchaseDate, purchaseDate) || other.purchaseDate == purchaseDate));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,cardId,description,totalCents,months,categoryId,purchaseDate);
}

@override
String toString() {
    return 'InstallmentPlan(id: $id, cardId: $cardId, description: $description, totalCents: $totalCents, months: $months, categoryId: $categoryId, purchaseDate: $purchaseDate)';
}


}

/// @nodoc
abstract mixin class _$InstallmentPlanCopyWith<$Res> implements $InstallmentPlanCopyWith<$Res> {
  factory _$InstallmentPlanCopyWith(_InstallmentPlan value, $Res Function(_InstallmentPlan) _then) = __$InstallmentPlanCopyWithImpl;
@override @useResult
$Res call({
 int id, int cardId, String description, int totalCents, int months, int categoryId, DateTime purchaseDate
});




}
/// @nodoc
class __$InstallmentPlanCopyWithImpl<$Res>
    implements _$InstallmentPlanCopyWith<$Res> {
  __$InstallmentPlanCopyWithImpl(this._self, this._then);

  final _InstallmentPlan _self;
  final $Res Function(_InstallmentPlan) _then;

/// Create a copy of InstallmentPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? cardId = null,Object? description = null,Object? totalCents = null,Object? months = null,Object? categoryId = null,Object? purchaseDate = null,}) {
  return _then(_InstallmentPlan(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,cardId: null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,totalCents: null == totalCents ? _self.totalCents : totalCents // ignore: cast_nullable_to_non_nullable
as int,months: null == months ? _self.months : months // ignore: cast_nullable_to_non_nullable
as int,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,purchaseDate: null == purchaseDate ? _self.purchaseDate : purchaseDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
