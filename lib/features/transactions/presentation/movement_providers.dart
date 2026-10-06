import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/domain/quincena.dart';
import '../data/movement_repository.dart';
import '../domain/movement.dart';
import '../domain/period.dart';

part 'movement_providers.g.dart';

enum KindFilter {
  all('Todos'),
  expenses('Gastos'),
  incomes('Ingresos'),
  unexpected('Imprevistos');

  const KindFilter(this.label);
  final String label;

  bool matches(Movement m) => switch (this) {
    KindFilter.all => true,
    KindFilter.expenses => m.isExpense,
    KindFilter.incomes => !m.isExpense,
    KindFilter.unexpected => m.isUnexpected,
  };
}

@immutable
class MovementsFilterState {
  const MovementsFilterState({required this.period, this.kind = KindFilter.all});

  final PeriodSelection period;
  final KindFilter kind;

  MovementsFilterState copyWith({PeriodSelection? period, KindFilter? kind}) =>
      MovementsFilterState(period: period ?? this.period, kind: kind ?? this.kind);
}

/// Filtros de la pantalla de Movimientos. Se conservan al cambiar de pestaña.
@Riverpod(keepAlive: true)
class MovementsFilter extends _$MovementsFilter {
  @override
  MovementsFilterState build() => MovementsFilterState(period: PeriodSelection.quincena(DateTime.now()));

  void setPeriod(PeriodSelection period) => state = state.copyWith(period: period);

  void setType(PeriodType type) {
    if (type == state.period.type) return;
    state = state.copyWith(period: PeriodSelection.ofType(type, DateTime.now()));
  }

  void next() => state = state.copyWith(period: state.period.next);

  void previous() => state = state.copyWith(period: state.period.previous);

  void setKind(KindFilter kind) => state = state.copyWith(kind: kind);
}

@riverpod
Stream<List<Movement>> movementsInRange(Ref ref, DateRange range) =>
    ref.watch(movementRepositoryProvider).watchRange(range);

@riverpod
Stream<List<Movement>> recentMovements(Ref ref) => ref.watch(movementRepositoryProvider).watchRecent();

@riverpod
Stream<List<Movement>> currentQuincenaMovements(Ref ref) {
  final q = Quincena.current();
  return ref.watch(movementRepositoryProvider).watchRange(DateRange(q.start, q.endExclusive));
}
