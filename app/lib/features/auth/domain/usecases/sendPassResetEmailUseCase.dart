import 'package:app/core/errors/failure.dart';
import 'package:app/features/auth/domain/repositories/userAuth_repository.dart';
import 'package:dartz/dartz.dart';

class Sendpassresetemailusecase {
  final UserauthRepository _authRepository;

  Sendpassresetemailusecase(this._authRepository);

  Future<Either<Failure,String>> call(String email) async {
    return _authRepository.sendPassResetEmail(email);
    
  }
}
