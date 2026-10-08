import 'package:freezed_annotation/freezed_annotation.dart';

part 'card_payment.freezed.dart';

/// Pago hecho a una tarjeta. No es un gasto: las compras ya se contaron el
/// día que se hicieron.
@freezed
abstract class CardPayment with _$CardPayment {
  const factory CardPayment({
    @Default(0) int id,
    required int cardId,
    required int amountCents,
    required DateTime date,
    String? note,
  }) = _CardPayment;
}
