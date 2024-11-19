import 'package:app/core/Services/sharedPrefsService.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/features/auth/data/models/tokensModel.dart';
import 'package:app/features/auth/data/repository/userAuth_repository_impl.dart';
import 'package:app/features/auth/data/source/local/localDataSource.dart';
import 'package:app/features/auth/data/source/remote/remoteDataSource.dart';
import 'package:app/features/auth/domain/usecases/loginUseCase.dart';
import 'package:app/features/auth/domain/usecases/logoutUseCase.dart';
import 'package:app/features/auth/domain/usecases/setBudgetUseCase.dart';
import 'package:app/features/auth/domain/usecases/setPinUseCase.dart';
import 'package:app/features/auth/domain/usecases/signInUseCase.dart';
import 'package:app/features/auth/presentation/state/user_bloc.dart';
import 'package:app/features/auth/presentation/state/user_events.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class DioService {
  static final local=Localdatasource(Sharedprefsservice().prefs);
static   final repo=UserauthRepositoryImpl(remotedatasource: Remotedatasource(), localedatasourceSECURE:LocaledatasourceSECURE(FlutterSecureStorage()), localedatasource: local);
  static final AuthBloc=UserBloc(local, Logoutusecase(repo), Loginusecase(repo), Signinusecase(repo), Setpinusecase(repo),
 Setbudgetusecase(repo),
  );
  static final decoder=JwtDecoder();
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:3001',
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
      return ;
    }


     options.headers['Authorization']=token;  
     return handler.next(options); 
    },
  onError: (error,handler)async{
 final remote=Remotedatasource();
 final local=LocaledatasourceSECURE(const FlutterSecureStorage());
  if (error.response?.statusCode==403){
    final refreshToken=await local.getRefreshToken();
    if (refreshToken.isRight()){
    try {
        
      Map<String,dynamic> decoded=JwtDecoder.decode(refreshToken.getOrElse(()=>""));
      if (decoded==""){
      AuthBloc.add(logoutEvent());
        return handler.next(error);
      }
        DateTime expiryDate = DateTime.fromMillisecondsSinceEpoch(decoded["Iat"] * 1000);

      bool refreshIsExpired=DateTime.now().isAfter(expiryDate);
      if (refreshIsExpired){
      AuthBloc.add(logoutEvent());
        return handler.next(error);
      }
        } catch (e) {
      AuthBloc.add(logoutEvent());
        }
    }
   
    Future<Either<Failure,void>> _storeTokens(TokensModel model)async{
    return await local.StoreTokens(model.accessToken,model.refreshToken);
    }
    final accesToken=await remote.refreshAccesToken(refreshToken.getOrElse(() => ""));
    accesToken.fold((fail)=>null, (model)async=>await _storeTokens(model));
    final accesToken2=await local.getAccessToken();
    if (accesToken2.isLeft()){
      AuthBloc.add(logoutEvent());
      return handler.next(error);
    }
    error.requestOptions.headers['Authorization']='Bearer ${accesToken2.getOrElse(() => "")}';
    return handler.resolve(await dio.fetch(error.requestOptions) );
}
  return handler.next(error);
  }
  ));

  }

