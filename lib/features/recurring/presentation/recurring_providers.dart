import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/recurring_repository.dart';
import '../domain/recurring_rule.dart';

part 'recurring_providers.g.dart';

@riverpod
Stream<List<RecurringRule>> recurringRules(Ref ref) => ref.watch(recurringRepositoryProvider).watchAll();
