import 'package:app/core/Services/sharedPrefsService.dart';
import 'package:app/features/auth/data/repository/userAuth_repository_impl.dart';
import 'package:app/features/auth/data/source/local/localDataSource.dart';
import 'package:app/features/auth/data/source/remote/remoteDataSource.dart';
import 'package:app/features/auth/domain/usecases/getBudgetUseCase.dart';
import 'package:app/features/auth/domain/usecases/loginUseCase.dart';
import 'package:app/features/auth/domain/usecases/logoutUseCase.dart';
import 'package:app/features/auth/domain/usecases/setBudgetUseCase.dart';
import 'package:app/features/auth/domain/usecases/setPinUseCase.dart';
import 'package:app/features/auth/domain/usecases/signInUseCase.dart';
import 'package:app/features/auth/presentation/state/user_bloc.dart';
import 'package:app/features/auth/presentation/state/user_events.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class DioService {
  static final local=Localdatasource(Sharedprefsservice().prefs);
static   final repo=UserauthRepositoryImpl(remotedatasource: Remotedatasource(), localedatasourceSECURE:LocaledatasourceSECURE(const FlutterSecureStorage()), localedatasource: local);
  // ignore: non_constant_identifier_names
  static final AuthBloc=UserBloc(local, Logoutusecase(repo), Loginusecase(repo), Signinusecase(repo), Setpinusecase(repo),
 Setbudgetusecase(repo),
Getbudgetusecase(repo)
  );
  static final decoder=JwtDecoder();
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:3001',
      )
  )..interceptors.add(InterceptorsWrapper(
   onRequest: (options, handler) async {
  const noAuthPaths = [
    '/login', '/register', '/forgotPassword', 
    "/refreshToken", "/SendEmail", "/resetPassword"
  ];
  
      print(options.path);
  // If it's a no-auth path, immediately pass the request
  if (noAuthPaths.contains(options.path)) {
    return handler.next(options);
  }
  
  final dataSource = LocaledatasourceSECURE(const FlutterSecureStorage());
  final accessTokenResult = await dataSource.getAccessToken();
  
  return accessTokenResult.fold(
    (fail) {
      // If token retrieval fails, trigger logout and reject the request
      AuthBloc.add(logoutEvent());
      return handler.reject(
        DioException(
          requestOptions: options, 
          type: DioExceptionType.badCertificate, 
          error: "Authentication Failed"
        )
      );
    },
    (token) {
      // If token is empty, trigger logout and reject the request
      if (token.isEmpty) {
        AuthBloc.add(logoutEvent());
        return handler.reject(
          DioException(
            requestOptions: options, 
            type: DioExceptionType.badCertificate, 
            error: "Empty Token"
          )
        );
      }
      
      // Add the token to the request headers
      options.headers['Authorization'] = '$token';
      return handler.next(options);
    }
  );
} ,
  onError: (error, handler) async {
  // Only attempt refresh for 401 (Unauthorized) or 403 (Forbidden) status codes
  if (error.response?.statusCode == 401 || error.response?.statusCode == 403) {
    final local = LocaledatasourceSECURE(const FlutterSecureStorage());
    final remote = Remotedatasource();
    
    final refreshTokenResult = await local.getRefreshToken();
    
    if (refreshTokenResult.isRight()) {
      final refreshToken = refreshTokenResult.getOrElse(() => "");
      
      try {
        // Validate refresh token
        final decoded = JwtDecoder.decode(refreshToken);
        
        if (decoded == null || decoded.isEmpty) {
          AuthBloc.add(logoutEvent());
          return handler.next(error);
        }
        
        // Check token expiration
        final expiryDate = DateTime.fromMillisecondsSinceEpoch(decoded["exp"] * 1000);
        if (DateTime.now().isAfter(expiryDate)) {
          AuthBloc.add(logoutEvent());
          return handler.next(error);
        }
        
        // Attempt to refresh access token
        final newAccessTokenResult = await remote.refreshAccesToken(refreshToken);
        
        return await newAccessTokenResult.fold(
          (failure) {
            AuthBloc.add(logoutEvent());
            return handler.next(error);
          },
          (tokenModel) async {
            // Store new tokens
            await local.StoreTokens(tokenModel.accessToken, tokenModel.refreshToken);
            
            // Create a new request with the updated token
            final newRequest = error.requestOptions;
            newRequest.headers['Authorization'] = tokenModel.accessToken;
            
            // Use RequestOptions directly to avoid potential infinite loops
            final newResponse = await Dio().fetch(newRequest);
            return handler.resolve(newResponse);
          }
        );
      } catch (e) {
        AuthBloc.add(logoutEvent());
        return handler.next(error);
      }
    }
  }
  
  return handler.next(error);
}
  ));

  }

