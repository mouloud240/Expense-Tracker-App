
import 'package:app/core/Services/dio_service.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/features/auth/data/models/auth_model.dart';
import 'package:app/features/auth/data/models/subModels/moneyModel.dart';
import 'package:app/features/auth/data/models/tokensModel.dart';
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
  Future<Either<Failure,AuthModel>>signUp(Usermodel user)async{
    try {
     Response response=await  dio.post('/register',data: user.toJson());
     if (response.statusCode==200){
  return Right(AuthModel.fromJson(response.data));
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
    Response response=await dio.put('/forgotPassword',data: {"email":email,"newPassword":password});
      if (response.statusCode==200){
      return const Right(null);
    }
  } on DioException catch(e){
   if (e.response?.statusCode==400){
    return left(Failure("Provide a password"));
   } 
   if (e.response?.statusCode==500){
   return left(Failure("Error Updating password"));
   }
   if (e.response?.statusCode==404){
   return left(Failure("Bad request"));
   }
  }
  return left(Failure("Internal Error"));
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
Future<Either<Failure,TokensModel>>refreshAccesToken(String refreshToken)async{
    try {
     Response response=await dio.post("/refreshToken");
      if (response.statusCode==200){
        return Right(TokensModel.fromJson(response.data));
      }
    }on DioException catch(e){
      if (e.response?.statusCode==403){
        return left(Failure("Invalid Refresh Token"));
        }
  }

return left(Failure("Unkonw Error"));
}
  Future<Either<Failure,Usermodel>>setpin(String pin)async{
    try {
     final resposnse =await dio.put("/pin",data: {"pin":pin});
      if (resposnse.statusCode==200){
        return Right(Usermodel.fromJson(resposnse.data));
      }
    }on DioException catch(e){
      if (e.response?.statusCode==400){
        return left(Failure("Provide Pin"));
        }
      if (e.response?.statusCode==500){
      print(e);
        return left(Failure("Error Setting Pin"));
        }
      if (e.response?.statusCode==405){
        return left(Failure("Unauthorized"));
        } 
    }
  return left(Failure("Unkonw Error"));
  }
 Future<Either<Failure,Usermodel>>setBudget(Moneymodel money)async{
    try {
     final resposnse =await dio.put("/budget",data: {"Amount":money.amount,"Currency":money.currency});
      if (resposnse.statusCode==200){
        return Right(Usermodel.fromJson(resposnse.data));
      }
    }on DioException catch(e){
      if (e.response?.statusCode==400){
        return left(Failure("Provide Budget"));
        }
      if (e.response?.statusCode==500){
        return left(Failure("Error Setting Budget"));
        }
      if (e.response?.statusCode==405){
        return left(Failure("Unauthorized"));
        } 
    }
  return left(Failure("Unkonw Error"));
  }
  Future<Either<Failure,Moneymodel>>getBudget()async{
    try {
     final resposnse =await dio.get("/budget");
      if (resposnse.statusCode==200){
        return Right(Moneymodel.fromjson(resposnse.data));
      }
    }on DioException catch(e){
      if (e.response?.statusCode==500){
        return left(Failure("Error Getting Budget"));
        }
      if (e.response?.statusCode==405){
        return left(Failure("Unauthorized"));
        } 
    }
    return left(Failure('Unkonw Error'));}
}

