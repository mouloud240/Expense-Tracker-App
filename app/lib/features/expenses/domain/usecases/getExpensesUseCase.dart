import 'package:app/core/errors/failure.dart';
import 'package:app/features/expenses/domain/entities/expense.dart';
import 'package:app/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:dartz/dartz.dart';

class Getexpensesusecase {
  final ExpensesRepository repository;

  Getexpensesusecase(this.repository);

  Future<Either<Failure,List<Expense>>> call() async {
    return await repository.getExpenses();
  } 
}
