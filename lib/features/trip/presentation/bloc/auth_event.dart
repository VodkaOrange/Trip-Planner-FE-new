import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignIn extends AuthEvent {
  final String username;
  final String password;

  const SignIn(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}

class SignUp extends AuthEvent {
  final String username;
  final String email;
  final String password;

  const SignUp(this.username, this.email, this.password);

  @override
  List<Object> get props => [username, email, password];
}
