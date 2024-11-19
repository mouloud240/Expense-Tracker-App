import 'package:app/core/errors/failure.dart';
import 'package:app/features/auth/domain/entities/subEntities/money.dart';
import 'package:app/features/expenses/domain/entities/expense.dart';
import 'package:app/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:dartz/dartz.dart';

class Addexpenseusecase {
  final ExpensesRepository _expenseRepository;

  Addexpenseusecase(this._expenseRepository);

  Future<Either<Failure,Money>> call(Expense expense) async {
   return  await _expenseRepository.addExpense(expense);
  } 
}
