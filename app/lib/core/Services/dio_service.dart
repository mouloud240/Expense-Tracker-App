import 'package:app/features/auth/data/source/local/localDataSource.dart';
import 'package:app/features/auth/data/source/remote/remoteDataSource.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioService {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:3001',
      )
  )..interceptors.add(InterceptorsWrapper(
    onRequest: (options,handler)async{
      const noAuthPaths=['/login','/register','/forgotPassword',"/refreshToken","/SendEmail","/resetPassword"];
      if (noAuthPaths.contains(options.path)){
        return handler.next(options);
      }
    final  dataSource=LocaledatasourceSECURE(const FlutterSecureStorage());

      late String token;
     final accesToken=await dataSource.getAccessToken();
     token =accesToken.fold((fail){
        return token;}, (token)=>token);
      if (token==""){
      print("NO token for the Cookie Monster");
      return ;
    }

     options.headers['Authorization']='Bearer $token';  
      print("Token is Kiddy");
     return handler.next(options); 
    },
  onError: (error,handler)async{
 final remote=Remotedatasource();
 final local=LocaledatasourceSECURE(const FlutterSecureStorage());
  if (error.response?.statusCode==403){
    final refreshToken=await local.getRefreshToken();
    final accesToken=await remote.refreshAccesToken(refreshToken.getOrElse(() => ""));
    accesToken.fold((fail)=>null, (token)=>local.StoreAccesToken(token));
    final accesToken2=await local.getAccessToken();
    if (accesToken2.isLeft()){
      return handler.next(error);
    }
    error.requestOptions.headers['Authorization']='Bearer ${accesToken2.getOrElse(() => "")}';
    return handler.resolve(await dio.fetch(error.requestOptions) );
}
  return handler.next(error);
  }
  ));

  }

