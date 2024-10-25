import 'package:app/core/errors/failure.dart';
import 'package:app/features/auth/domain/repositories/userAuth_repository.dart';
import 'package:dartz/dartz.dart';

class Setpinusecase {
  UserauthRepository repository;
  Setpinusecase(this.repository);
Either<Failure,void>call(String pin){
    return repository.setPin(pin);
  }
}
