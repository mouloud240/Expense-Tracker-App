import 'package:app/features/auth/domain/entities/subEntities/money.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../categories/domain/entities/category.dart';

part 'expense.freezed.dart';
@freezed
class Expense with _$Expense {
  const factory Expense({
    required String name,
    required DateTime date,
    required Category category,
    required Money amount,
  }) = _Expense;
 
}
