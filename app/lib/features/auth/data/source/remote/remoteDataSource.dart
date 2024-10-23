import 'package:app/core/Services/dio_service.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/features/auth/data/models/auth_model.dart';
import 'package:app/features/auth/data/models/userModel.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class Remotedatasource {
  final dio=DioService.dio;
 Future<Either<Failure,AuthModel>>login(String email ,String password)async{
    try {
          
      
     Response response=await  dio.post('/login',data: {"email":email,"password":password});
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
    }catch(e){
     return left(Failure("Socket Error"));
    }

 
  return left(Failure("Unkownn Error"));
  }
  Future<Either<Failure,Usermodel>>signUp(Usermodel user)async{
    try {
     Response response=await  dio.post('/register',data: user.toJson());
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
  try {
          
   
     Response response=await  dio.post('/SendEmail',data: {"email":email});
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

Future<Either<Failure,void>>forgotPassword(String email,String password)async{ 
  
  try{
    Response response=await dio.post('/forgotPassword',data: {"email":email,"NewPassword":password});
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
  try{
    Response response=await dio.get('/logout');
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
Future<Either<Failure,String>>refreshAccesToken(String refreshToken)async{
    try {
     Response response=await dio.post("/refreshToken");
      if (response.statusCode==200){
        return Right(response.data["accessToken"]);
      }
    }on DioException catch(e){
      if (e.response?.statusCode==403){
        return left(Failure("Invalid Refresh Token"));
        }
  }

return left(Failure("Unkonw Error"));
}
} 
