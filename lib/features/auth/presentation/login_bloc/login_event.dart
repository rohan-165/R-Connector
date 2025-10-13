part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {}

final class LoginSubmitEvent extends LoginEvent {
  final String email;
  final String password;

  LoginSubmitEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

final class LoginResetEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}
