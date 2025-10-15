part of 'login_bloc.dart';

sealed class LoginEvent {}

final class LoginSubmitEvent extends LoginEvent {
  final String email;
  final String password;

  LoginSubmitEvent({required this.email, required this.password});
}

final class LoginResetEvent extends LoginEvent {}
