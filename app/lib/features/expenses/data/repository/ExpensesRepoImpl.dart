import 'package:app/core/connection/networkInfoImpl.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/features/auth/domain/entities/subEntities/money.dart';
import 'package:app/features/expenses/data/models/Expense-Model.dart';
import 'package:app/features/expenses/data/source/remote/expense_remote_data_source.dart';
import 'package:app/features/expenses/domain/entities/expense.dart';
import 'package:app/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';

class Expensesrepoimpl implements ExpensesRepository {
  final ExpenseRemoteDataSource remoteDataSource;
  final networkInfo=NetworkInfoImpl(DataConnectionChecker());
  Expensesrepoimpl(this.remoteDataSource); 
  @override
  Future<Either<Failure, Money>> addExpense(Expense expense)async {
     if (await networkInfo.isConnected==false){
       return left(Failure("No internet connection"));
     }
    return await remoteDataSource.addExpense(ExpenseModel.fromEntity(expense));
  }

  @override
  Future<Either<Failure, void>> deleteAllExpenses()async {
   if (await networkInfo.isConnected==false){
       return left(Failure("No internet connection"));
     }
    return await remoteDataSource.deleteAllExpenses();
  }

  @override
  Future<Either<Failure, Money>> deleteExpense(Expense expense)async {
    if (await networkInfo.isConnected==false){
       return left(Failure("No internet connection"));
     }
    return await remoteDataSource.deleteExpense(expense.id);
  }

  @override
  Future<Either<Failure, Expense>> getExpenseById(String id) async{
    if (await networkInfo.isConnected==false){
       return left(Failure("No internet connection"));
     }
    return remoteDataSource.getExpenseByID(id).then((res)=>res.fold((l)=>left(l), (r)=>right(r.toEntity())));
  }

  @override
  Future<Either<Failure, List<Expense>>> getExpenses() async{
    if (await networkInfo.isConnected==false){
       return left(Failure("No internet connection"));
     }
    return remoteDataSource.getExpenses().then((res)=>res.fold((l)=>left(l), (r)=>right(r.map((e) => e.toEntity()).toList())));
  }

  @override
  Future<Either<Failure,Money>> updateExpense(Expense expense)async {
     if (await networkInfo.isConnected==false){
       return left(Failure("No internet connection"));
     }
    return remoteDataSource.updateExpense(ExpenseModel.fromEntity(expense));

  }
  
}
