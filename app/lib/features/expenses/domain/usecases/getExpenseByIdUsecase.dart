import 'package:app/core/errors/failure.dart';
import 'package:app/features/expenses/domain/entities/expense.dart';
import 'package:app/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:dartz/dartz.dart';

class Getexpensebyidusecase{
  final ExpensesRepository repository;
  Getexpensebyidusecase(this.repository);
  Future<Either<Failure,Expense>>call(String id) async {
    return await repository.getExpenseById(id);
  }
}
