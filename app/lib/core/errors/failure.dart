import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  String message;
  Failure(this.message);

  @override
  List<Object?> get props => [message]; 

}
