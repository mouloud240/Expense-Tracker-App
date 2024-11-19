import 'package:app/core/errors/failure.dart';
import 'package:app/features/auth/domain/entities/subEntities/money.dart';
import 'package:app/features/auth/domain/entities/user.dart';
import 'package:app/features/auth/domain/repositories/userAuth_repository.dart';
import 'package:dartz/dartz.dart';

class Setbudgetusecase {
  final UserauthRepository userauthRepository;
  Setbudgetusecase(this.userauthRepository);
  Future<Either<Failure,User>> call(Money budget)async{
    return await userauthRepository.setBudget(budget);
  }
}
