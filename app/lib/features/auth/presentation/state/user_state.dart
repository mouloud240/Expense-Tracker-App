import 'package:app/features/auth/domain/entities/user.dart';

class UserState {
}
class UserStateInitial extends UserState {
}
class UserStateLoaded extends UserState {
  final User user;
  UserStateLoaded(this.user);
}
class UserStateError extends UserState {
  final String message;
  UserStateError(this.message);
}
class UserStateLoading extends UserState {
}
