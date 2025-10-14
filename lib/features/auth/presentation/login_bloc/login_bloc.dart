import 'dart:async';
import 'dart:developer';

import 'package:dri_flutter/core/common/failure_state.dart';
import 'package:dri_flutter/core/constants/enum.dart';
import 'package:dri_flutter/core/routes/routes_name.dart';
import 'package:dri_flutter/core/services/local_storage/shared_pref_data.dart';
import 'package:dri_flutter/core/services/navigation_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/common/abs_normal_state.dart';
import '../../../../core/common/data_parsh.dart';
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

    response.fold(
      (l) {
        try {
          UserModel user = parseJson<UserModel>(
            json: l,
            fromJson: (json) => UserModel.fromMap(json),
            extraKey: 'info',
          );

          if (user.token.isNotEmpty) {
            emit(
              state.copyWith(
                loginState: state.loginState.copyWith(
                  absNormalStatus: AbsNormalStatus.SUCCESS,
                  data: user,
                ),
              ),
            );
            getIt<SharedPrefData>().saveAuthToken(token: user.token);
            getIt<NavigationService>().pushNamedAndRemoveUntil(
              RoutesName.landingScreen,
              false,
            );
          } else {
            emit(
              state.copyWith(
                loginState: state.loginState.copyWith(
                  absNormalStatus: AbsNormalStatus.ERROR,
                  failure: Failure(message: "Failed to parse user data"),
                ),
              ),
            );
          }
        } catch (e, st) {
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
      (r) {
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
}
