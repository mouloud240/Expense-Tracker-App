// ignore_for_file: void_checks
import 'package:app/core/Services/dio_service.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/features/auth/data/models/subModels/moneyModel.dart';
import 'package:app/features/auth/domain/entities/subEntities/money.dart';
import 'package:app/features/expenses/data/models/Expense-Model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ExpenseRemoteDataSource {
  final dio=DioService.dio;
  Future<Either<Failure,Money>> addExpense(ExpenseModel expense)async{
    try { 
    final response=await dio.post("/expense", data: expense.toJson());
      if (response.statusCode==200){
       return right(Moneymodel.fromjson(response.data['newBalance']).toMoney());
      }
        } on DioException catch (e) {
      if (e.response?.statusCode==420){
      return Left(Failure("Bad request"));
      }
        }
return left(Failure("Internal Error"));  }
  Future<Either<Failure,List<ExpenseModel>>> getExpenses()async{
    try {
         final response=await dio.get("/expenses");
      if (response.statusCode==200){
      print(response.data);
      return Right(response.data['expenses'].map<ExpenseModel>((e) => ExpenseModel.fromJson(e)).toList());
      }
        } on DioException catch(e) {
          return left(Failure(e.response?.data['message']));
        }
    return left(Failure("Interal Error"));
  }
  Future<Either<Failure,Money>> deleteExpense(String id)async{
    try {
      final response=await dio.delete("/expense/$id");
      if (response.statusCode==200){
        return right(response.data['newBalance']);
      }
        } on DioException catch (e) {
      return left(Failure(e.response?.data['message']));
    }
    return left(Failure("Internal Error"));
  }
  Future<Either<Failure,Money>> updateExpense(ExpenseModel expense)async{
    try {
      final response=await dio.post("/expense/${expense.id}", data: {"Expense":expense.toJson()});
      if (response.statusCode==200){
        return right(response.data['newBalance']);
      }
        } on DioException catch (e) {
      return left(Failure(e.response?.data['message']));
    }
    return left(Failure("Internal Error"));
  }
  Future<Either<Failure,void>> getExpensesByCategory(String name)async{
    try {
      final response=await dio.get("/expensesByCat/$name");
      if (response.statusCode==200){
        return right(unit);
      }
        } on DioException catch (e) {
      return left(Failure(e.response?.data['message']));
    }
    return left(Failure("Internal Error"));
  }
  Future <Either<Failure,ExpenseModel>>getExpenseByID(String id)async{
    try {
      final response= await dio.get("/expense/$id");
      if (response.statusCode==200){
        return right(ExpenseModel.fromJson(response.data));
      }
        } on DioException catch (e) {
      return left(Failure(e.response?.data['message']));
    }
    return left(Failure("Internal Error"));
  }
  Future <Either<Failure,void>> deleteAllExpenses()async{
    final repsosne=await dio.delete("/expensesAll");
    if (repsosne.statusCode==200){
      return right(unit);
     }
    return left(Failure("Internal Error"));
  }
}

