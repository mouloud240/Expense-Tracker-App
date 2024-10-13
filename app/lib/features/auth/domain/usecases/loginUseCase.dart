import 'package:app/core/errors/failure.dart';
import 'package:app/features/auth/domain/repositories/userAuth_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/user.dart';

class Loginusecase {
  UserauthRepository userauthRepository;
  Loginusecase(this.userauthRepository);
  Future<Either<Failure,User>>call(String email,String password)async{
    return await userauthRepository.Login(email, password);
  }
}

