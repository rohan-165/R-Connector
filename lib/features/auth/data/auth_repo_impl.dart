import 'package:dio/dio.dart';
import 'package:dri_flutter/core/flavor/get_env_config.dart';
import 'package:injectable/injectable.dart';

import '../../../core/constants/typedef.dart';
import '../../../core/services/get_it/service_locator.dart';
import '../../../core/services/network_service/api_request.dart';
import '../domain/repo/auth_repo.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl extends AuthRepo {
  static final String _secKey = GetEnvConfig.secKey;
  static const String _baseUrl = "/api";
  static const String _loginEndpoint = "$_baseUrl/consignment/login";
  static const String versionEndpoint = "$_baseUrl/logout";

  @override
  FutureDynamicResponse login({
    required String email,
    required String password,
  }) {
    final formData = {
      "username": email,
      "password": password,
      'sec_key': _secKey,
    };
    return getIt<ApiRequest>().getResponse(
      endPoint: _loginEndpoint,
      apiMethods: ApiMethods.post,
      body: FormData.fromMap(formData),
    );
  }

  @override
  FutureDynamicResponse getAppVersion() {
    return getIt<ApiRequest>().getResponse(
      endPoint: versionEndpoint,
      apiMethods: ApiMethods.get,
    );
  }
}
