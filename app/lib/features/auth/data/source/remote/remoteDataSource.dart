import 'package:app/core/errors/failure.dart';
import 'package:app/features/auth/data/models/userModel.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class Remotedatasource {
 Future<Either<Failure,Usermodel>>login(String email ,String password)async{

 final dio=Dio();

    try {
          
   
     Response response=await  dio.post('http://localhost:3001/login',data: {"email":email,"password":password});
     if (response.statusCode==200){
  return Right(Usermodel.fromJson(response.data["user"]));
  }

        }on DioException catch (e) {
       if (e.response?.statusCode==400){
    return(left(Failure( "Provide Email and password" )));
    }
    if (e.response?.statusCode==401){
    
     return Left(Failure("Email or Password Wrong"));
    } 
    }
 
  return left(Failure("Unkown Error"));
  }
}
