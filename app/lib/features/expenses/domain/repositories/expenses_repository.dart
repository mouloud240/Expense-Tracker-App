

import 'package:app/core/errors/failure.dart';
import 'package:app/features/auth/domain/entities/subEntities/money.dart';
import 'package:app/features/expenses/domain/entities/expense.dart';
import 'package:dartz/dartz.dart';

abstract class ExpensesRepository {
 Future<Either<Failure,List<Expense>>> getExpenses();
  Future<Either<Failure,Money>> addExpense(Expense expense); 
  Future<Either<Failure,Money>> deleteExpense(Expense expense);
  Future<Either<Failure,Money>> updateExpense(Expense expense);
  Future<Either<Failure,void>> deleteAllExpenses();
  Future<Either<Failure,Expense>>getExpenseById(String id);
}
