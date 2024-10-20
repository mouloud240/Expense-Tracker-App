// ignore_for_file: non_constant_identifier_names

import 'package:app/core/connection/networkInfoImpl.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/features/auth/data/models/userModel.dart';
import 'package:app/features/auth/data/source/local/localDataSource.dart';
import 'package:app/features/auth/data/source/remote/remoteDataSource.dart';
import 'package:app/features/auth/domain/entities/user.dart';
import 'package:app/features/auth/domain/repositories/userAuth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
class UserauthRepositoryImpl implements UserauthRepository{
  Remotedatasource remotedatasource;
  LocaledatasourceSECURE localedatasourceSECURE;
  Localdatasource localedatasource;
  final NetworkInfo=NetworkInfoImpl(DataConnectionChecker());
  UserauthRepositoryImpl({required this.remotedatasource,required this.localedatasourceSECURE,required this.localedatasource});
  @override
  Future<Either<Failure, User>> Login(String email, String password)async {
    if (await NetworkInfo.isConnected==false){
      return left(Failure("No internet connection"));
    } 
    final response=await  remotedatasource.login(email, password);
     Usermodel? user;
    String failure="";
    response.fold((l) => failure=l.message, (r) { localedatasourceSECURE.StoreTokens(r.accesToken, r.refreshToken);user=r.user;});
    if (failure!=""){
      return left(Failure(failure));
    } 
    if (user!=null){
      localedatasource.storeUser(user!);
    }
    return right(user!); 
  }

  @override
  Future<Either<Failure, User>> SignUp(User user)async {
    if (await NetworkInfo.isConnected==false){
      return left(Failure("No internet connection"));
    }
   await localedatasource.storeUser(Usermodel.fromEntity(user));
   return await remotedatasource.signUp(Usermodel.fromEntity(user));
}

  @override
  Future<Either<Failure, void>> forgotPassword(String Email,String newPassword) async{
    if (await NetworkInfo.isConnected==false){
      return left(Failure("No internet connection"));
    }
  return await remotedatasource.forgotPassword(Email, newPassword);
  }
  @override
  Future<Either<Failure, void>> logout() {
    localedatasourceSECURE.ClearTokens();
   return remotedatasource.logout();
  }

  @override
  Future<Either<Failure, void>> resetpassword(String oldPassword, newPassword) async{
    if (await NetworkInfo.isConnected==false){
      return left(Failure("No internet connection"));
    }
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> setPin(String pin)async {
   try {
     await localedatasourceSECURE.setPin(pin);
    
    }catch (e) {
      return left(Failure("Error"));   
      }
    return right(null);
  }
  @override 
  Future<bool>hasSeenWelcomePage()async{
  return  await localedatasource.hasSeenWelcomePage();
  }
}
  
