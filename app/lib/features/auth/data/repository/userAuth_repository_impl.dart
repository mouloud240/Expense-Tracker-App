// ignore_for_file: non_constant_identifier_names

import 'package:app/core/errors/failure.dart';
import 'package:app/features/auth/data/source/local/localDataSource.dart';
import 'package:app/features/auth/data/source/remote/remoteDataSource.dart';
import 'package:app/features/auth/domain/entities/user.dart';
import 'package:app/features/auth/domain/repositories/userAuth_repository.dart';
import 'package:dartz/dartz.dart';

class UserauthRepositoryImpl implements UserauthRepository{
  Remotedatasource remotedatasource;
  Localedatasource localedatasource;
  UserauthRepositoryImpl({required this.remotedatasource,required this.localedatasource});
  @override
  Future<Either<Failure, User>> Login(String email, String password) {
    return remotedatasource.login(email, password);
  }

  @override
  Future<Either<Failure, User>> SignUp(User user) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> forgotPassword() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> logout() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> resetpassword(String oldPassword, newPassword) {
    throw UnimplementedError();
  }

  @override
  Either<Failure, void> setPin(String pin) {
    throw UnimplementedError();
  }


}
  
