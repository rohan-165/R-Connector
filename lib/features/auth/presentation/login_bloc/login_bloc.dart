import 'dart:async';

import 'package:r_connector/core/common/failure_state.dart';
import 'package:r_connector/core/constants/enum.dart';
import 'package:r_connector/core/constants/shared_pref_keys.dart';
import 'package:r_connector/core/flavor/get_env_config.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:r_connector/core/routes/routes_name.dart';
import 'package:r_connector/core/services/get_it/service_locator.dart';
import 'package:r_connector/core/services/local_storage/shared_pref_service.dart';
import 'package:r_connector/core/services/navigation_service.dart';

import '../../../../core/common/abs_normal_state.dart';
import '../../domain/model/user_model.dart';

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

    final userName = GetEnvConfig.userName;
    final password = GetEnvConfig.password;

    if (userName == event.email && password == event.password) {
      final authToken = event.email + event.password;
      getIt<SharedPrefsServices>().setString(
        key: SharedPrefKeys.tokenKey,
        value: authToken,
      );
      getIt<NavigationService>().pushNamedAndRemoveUntil(
        RoutesName.dashboard,
        false,
      );
      emit(
        state.copyWith(
          loginState: state.loginState.copyWith(
            absNormalStatus: AbsNormalStatus.SUCCESS,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          loginState: state.loginState.copyWith(
            absNormalStatus: AbsNormalStatus.ERROR,
            failure: Failure(message: "Invalid credentials"),
          ),
        ),
      );
    }
  }
}
