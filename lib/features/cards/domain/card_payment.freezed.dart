// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card_payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CardPayment {

 int get id; int get cardId; int get amountCents; DateTime get date; String? get note;
/// Create a copy of CardPayment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CardPaymentCopyWith<CardPayment> get copyWith => _$CardPaymentCopyWithImpl<CardPayment>(this as CardPayment, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CardPayment;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CardPayment&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.cardId, _this.cardId) || other.cardId == _this.cardId)&&(identical(other.amountCents, _this.amountCents) || other.amountCents == _this.amountCents)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.note, _this.note) || other.note == _this.note));
}


@override
int get hashCode {
  final _this = this as CardPayment;
  return Object.hash(runtimeType,_this.id,_this.cardId,_this.amountCents,_this.date,_this.note);
}

@override
String toString() {
  final _this = this as CardPayment;
  return 'CardPayment(id: ${_this.id}, cardId: ${_this.cardId}, amountCents: ${_this.amountCents}, date: ${_this.date}, note: ${_this.note})';
}


}

/// @nodoc
abstract mixin class $CardPaymentCopyWith<$Res>  {
  factory $CardPaymentCopyWith(CardPayment value, $Res Function(CardPayment) _then) = _$CardPaymentCopyWithImpl;
@useResult
$Res call({
 int id, int cardId, int amountCents, DateTime date, String? note
});




}
/// @nodoc
class _$CardPaymentCopyWithImpl<$Res>
    implements $CardPaymentCopyWith<$Res> {
  _$CardPaymentCopyWithImpl(this._self, this._then);

  final CardPayment _self;
  final $Res Function(CardPayment) _then;

/// Create a copy of CardPayment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? cardId = null,Object? amountCents = null,Object? date = null,Object? note = freezed,}) {
  return _then(CardPayment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,cardId: null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as int,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CardPayment].
extension CardPaymentPatterns on CardPayment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CardPayment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CardPayment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CardPayment value)  $default,){
final _that = this;
switch (_that) {
case _CardPayment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CardPayment value)?  $default,){
final _that = this;
switch (_that) {
case _CardPayment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int cardId,  int amountCents,  DateTime date,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CardPayment() when $default != null:
return $default(_that.id,_that.cardId,_that.amountCents,_that.date,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int cardId,  int amountCents,  DateTime date,  String? note)  $default,) {final _that = this;
switch (_that) {
case _CardPayment():
return $default(_that.id,_that.cardId,_that.amountCents,_that.date,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int cardId,  int amountCents,  DateTime date,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _CardPayment() when $default != null:
return $default(_that.id,_that.cardId,_that.amountCents,_that.date,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _CardPayment implements CardPayment {
  const _CardPayment({this.id = 0, required this.cardId, required this.amountCents, required this.date, this.note});
  

@override@JsonKey() final  int id;
@override final  int cardId;
@override final  int amountCents;
@override final  DateTime date;
@override final  String? note;

/// Create a copy of CardPayment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CardPaymentCopyWith<_CardPayment> get copyWith => __$CardPaymentCopyWithImpl<_CardPayment>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CardPayment&&(identical(other.id, id) || other.id == id)&&(identical(other.cardId, cardId) || other.cardId == cardId)&&(identical(other.amountCents, amountCents) || other.amountCents == amountCents)&&(identical(other.date, date) || other.date == date)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,cardId,amountCents,date,note);
}

@override
String toString() {
    return 'CardPayment(id: $id, cardId: $cardId, amountCents: $amountCents, date: $date, note: $note)';
}


}

/// @nodoc
abstract mixin class _$CardPaymentCopyWith<$Res> implements $CardPaymentCopyWith<$Res> {
  factory _$CardPaymentCopyWith(_CardPayment value, $Res Function(_CardPayment) _then) = __$CardPaymentCopyWithImpl;
@override @useResult
$Res call({
 int id, int cardId, int amountCents, DateTime date, String? note
});




}
/// @nodoc
class __$CardPaymentCopyWithImpl<$Res>
    implements _$CardPaymentCopyWith<$Res> {
  __$CardPaymentCopyWithImpl(this._self, this._then);

  final _CardPayment _self;
  final $Res Function(_CardPayment) _then;

/// Create a copy of CardPayment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? cardId = null,Object? amountCents = null,Object? date = null,Object? note = freezed,}) {
  return _then(_CardPayment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,cardId: null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as int,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
