import 'package:app/features/auth/domain/repositories/userAuth_repository.dart';

class Hasseenwelcomepageusecase {
  final UserauthRepository userauthRepository; 
  Hasseenwelcomepageusecase(this.userauthRepository);
  Future<bool> call()async{
    return await userauthRepository.hasSeenWelcomePage();
  }
}
