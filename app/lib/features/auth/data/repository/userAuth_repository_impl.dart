// ignore_for_file: non_constant_identifier_names

import 'package:app/core/connection/networkInfoImpl.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/features/auth/data/models/subModels/moneyModel.dart';
import 'package:app/features/auth/data/models/userModel.dart';
import 'package:app/features/auth/data/source/local/localDataSource.dart';
import 'package:app/features/auth/data/source/remote/remoteDataSource.dart';
import 'package:app/features/auth/domain/entities/subEntities/money.dart';
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
  final response= await remotedatasource.signUp(Usermodel.fromEntity(user));
  return response.fold((l) => left(l), (r) {
      localedatasource.storeUser(r.user);
      localedatasourceSECURE.StoreTokens(r.accesToken, r.refreshToken);
      return right(r.user);
    });
}

  @override
  Future<Either<Failure, void>> forgotPassword(String Email,String newPassword) async{
    if (await NetworkInfo.isConnected==false){
      return left(Failure("No internet connection"));
    }
  return await remotedatasource.forgotPassword(Email, newPassword);
  }
  Future<Either<Failure, String>> sendEmai(String email) async{
    if (await NetworkInfo.isConnected==false){
      return left(Failure("No internet connection"));
    }
    return await remotedatasource.sendResetEmail(email);
  }
  @override
  Future<Either<Failure, void>> logout() async{
  return   await localedatasourceSECURE.ClearTokens();
  }

  @override
  Future<Either<Failure, void>> resetpassword(String oldPassword, newPassword) async{
    if (await NetworkInfo.isConnected==false){
      return left(Failure("No internet connection"));
    }
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure,Usermodel>> setPin(String pin)async {
   try {

     await localedatasourceSECURE.setPin(pin);
      return remotedatasource.setpin(pin);

    }catch (e) {
      return left(Failure("Error"));   
      }
  }
  @override 
  Future<bool>hasSeenWelcomePage()async{
  return  await localedatasource.hasSeenWelcomePage();
  }

  @override
  Future<Either<Failure, String>> sendPassResetEmail(String email)async {
    return await remotedatasource.sendResetEmail(email);
  }

  @override
  Future<Either<Failure, User>> setBudget(Money money)async {
  final response= await remotedatasource.setBudget(Moneymodel.fromMoney(money));
  return response.fold((l) => left(l), (r) {
      localedatasource.storeUser(r);
      return right(r);
    });
  }

  @override
  Future<Either<Failure, Money>> getBudget()async {
   return  remotedatasource.getBudget().then((res){
      return res.fold((l) => left(l), (r) => right(r.toMoney()));
    });
  }
}
  
