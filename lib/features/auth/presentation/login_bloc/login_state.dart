part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  final AbsNormalState<UserModel> loginState;
  const LoginState({required this.loginState});

  LoginState copyWith({AbsNormalState<UserModel>? loginState}) {
    return LoginStateImpl(loginState: loginState ?? this.loginState);
  }

  @override
  List<Object?> get props => [loginState];
}

final class LoginStateImpl extends LoginState {
  const LoginStateImpl({required super.loginState});

  @override
  LoginState copyWith({AbsNormalState<UserModel>? loginState}) {
    return LoginStateImpl(loginState: loginState ?? this.loginState);
  }

  @override
  List<Object?> get props => [loginState];
}

final class LoginInitial extends LoginState {
  LoginInitial() : super(loginState: AbsNormalInitialState<UserModel>());
}
