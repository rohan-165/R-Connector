import 'dart:async';
import 'dart:developer';

import 'package:dri_flutter/core/common/failure_state.dart';
import 'package:dri_flutter/core/constants/enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/common/abs_normal_state.dart';
import '../../../../core/services/get_it/service_locator.dart';
import '../../domain/model/user_model.dart';
import '../../domain/repo/auth_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

@lazySingleton
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginResetEvent>((_, emit) => emit(LoginInitial()));
    on<LoginSubmitEvent>(_handleLogin);
  }

  Future<void> _handleLogin(
    LoginSubmitEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(loginState: const AbsNormalLoadingState<UserModel>()));

    final response = await getIt<AuthRepo>().login(
      email: event.email,
      password: event.password,
    );

    await response.fold(
      (l) async {
        try {} catch (e, st) {
          log("Login parse error: $e", stackTrace: st);
          emit(
            state.copyWith(
              loginState: state.loginState.copyWith(
                absNormalStatus: AbsNormalStatus.ERROR,
                failure: Failure(message: e.toString()),
              ),
            ),
          );
        }
      },
      (r) async {
        emit(
          state.copyWith(
            loginState: state.loginState.copyWith(
              absNormalStatus: AbsNormalStatus.ERROR,
              failure: r,
            ),
          ),
        );
      },
    );
  }

  /// Parse login response -> returns (token, user)
  (String?, UserModel)? _parseLoginResponse(dynamic response) {
    if (response is! Map<String, dynamic>) return null;
    final data = response['data']?['success'];
    if (data is! Map<String, dynamic>) return null;

    final token = data['token'] as String?;
    final userData = data['user'] as Map<String, dynamic>?;
    final user = userData != null ? UserModel.fromJson(userData) : null;

    return (token, user ?? UserModel());
  }
}
