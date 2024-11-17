

import 'package:app/core/errors/failure.dart';
import 'package:app/features/expenses/domain/entities/expense.dart';
import 'package:dartz/dartz.dart';

abstract class ExpensesRepository {
 Future<Either<Failure,List<Expense>>> getExpenses();
  Future<Either<Failure,void>> addExpense(Expense expense); 
  Future<Either<Failure,void>> deleteExpense(Expense expense);
  Future<Either<Failure,void>> updateExpense(Expense expense);
  Future<Either<Failure,void>> deleteAllExpenses();
  Future<Either<Failure,Expense>>getExpenseById(String id);
}
