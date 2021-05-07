part of 'login_bloc.dart';

abstract class LoginEvent {}

class SignInEvent extends LoginEvent {
  final String username;
  final String password;

  SignInEvent(this.username, this.password);
}
