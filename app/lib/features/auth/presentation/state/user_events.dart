import 'package:app/features/auth/domain/entities/user.dart';

class UserEvent {}
class UpdateUserEvent extends UserEvent {
  final User user;
  UpdateUserEvent(this.user);
}
class LoginEvent extends UserEvent {
  final String email;
  final String password;
  LoginEvent(this.email, this.password);
}
// ignore: camel_case_types
class logoutEvent extends UserEvent {
}
class RegisterEvent extends UserEvent {
  final String email;
  final String password;
  final String name;
  RegisterEvent(this.email, this.password, this.name);
}
class ChangePinEvent extends UserEvent {
  final String pin;
  ChangePinEvent(this.pin);
}
class LoadingEvent extends UserEvent {

}
