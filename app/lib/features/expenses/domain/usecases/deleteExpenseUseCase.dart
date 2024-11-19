import 'package:app/core/errors/failure.dart';
import 'package:app/features/auth/domain/entities/subEntities/money.dart';
import 'package:app/features/expenses/domain/entities/expense.dart';
import 'package:app/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteExpenseusecase {

  final ExpensesRepository _repository;

  DeleteExpenseusecase(this._repository);

  Future<Either<Failure,Money>> call(Expense expense) async {
    return await _repository.deleteExpense(expense);
  }
}
