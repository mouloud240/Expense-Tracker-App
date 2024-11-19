import 'dart:ffi';

import 'package:app/core/errors/failure.dart';
import 'package:app/features/expenses/domain/entities/expense.dart';
import 'package:app/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:dartz/dartz.dart';

class Updateexpenseusecase {
  final ExpensesRepository _expenseRepository;
  Updateexpenseusecase(this._expenseRepository);
  Future<Either<Failure,void>> call(Expense expense) async {
    return await _expenseRepository.updateExpense(expense);
  }
}
