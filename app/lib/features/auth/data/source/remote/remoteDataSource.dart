import 'package:app/core/errors/failure.dart';
import 'package:app/features/auth/data/models/auth_model.dart';
import 'package:app/features/auth/data/models/userModel.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class Remotedatasource {
 Future<Either<Failure,AuthModel>>login(String email ,String password)async{

 final dio=Dio();

    try {
          
   
     Response response=await  dio.post('http://localhost:3001/login',data: {"email":email,"password":password});
     if (response.statusCode==200){
  return Right(AuthModel.fromJson(response.data));
  }
        }on DioException catch (e) {
       if (e.response?.statusCode==400){
    return(left(Failure( "Provide Email and password" )));
    }
    if (e.response?.statusCode==401){
    
     return left(Failure("Email or Password Wrong"));
    } 
    }
 
  return left(Failure("Unkown Error"));
  }
  Future<Either<Failure,Usermodel>>signUp(Usermodel user)async{
    final dio=Dio();
    try {
     Response response=await  dio.post('http://localhost:3001/register',data: user.toJson());
     if (response.statusCode==200){
  return Right(Usermodel.fromJson(response.data));
   }
        }on DioException catch (e) {
       if (e.response?.statusCode==422){
    return(left(Failure( "Provide Email and password" )));
    }
      if (e.response?.statusCode==500){
    return(left(Failure( "Server Failure" )));
      }
      if (e.response?.statusCode==409){
    return(left(Failure( "Email already in use" )));
      }
    }
    return left(Failure("Unkown Error"));

  }

Future<Either<Failure,String>>sendResetEmail(String email)async{
  final dio=Dio();
  try {
          
   
     Response response=await  dio.post('http://localhost:3001/SendEmail',data: {"email":email});
     if (response.statusCode==200){
      return Right(response.data["Otp"]); 
  }}on DioException catch (e) {
       if (e.response?.statusCode==400){
    return(left(Failure( "Provide Email" )));
    }
      if (e.response?.statusCode==500){
    return(left(Failure( "Server Failure" )));
      }
      if (e.response?.statusCode==404){
    return(left(Failure( "Email not found" )));
      }
    }
    return left(Failure("Unkown Error"));}

Future<Either<Failure,void>>forogtPassword(String email,String password)async{ 
  
  final dio=Dio();
  try{
    Response response=await dio.post('http://localhost:3001/resetPassword',data: {"email":email,"NewPassword":password});
    if (response.statusCode==200){
      return const Right(null);
    }
  } on DioException catch(e){
   if (e.response?.statusCode==400){
    return left(Failure("Provide Email and password"));
   } 
   if (e.response?.statusCode==500){
   return left(Failure("Error Updating password"));
   }

  }
  return left(Failure("Unkown Error"));
  }
Future<Either<Failure,void>>logout()async{
  final dio=Dio();
  try{
    Response response=await dio.get('http://localhost:3001/logout');
    if (response.statusCode==200){
      return const Right(null);
    }
  } on DioException catch(e){
   if (e.response?.statusCode==500){
   return left(Failure("Error Logging out"));
   }

  }
  return left(Failure("Unkown Error"));
  }
}
 
