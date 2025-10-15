import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/constants/typedef.dart';
import '../../../core/services/get_it/service_locator.dart';
import '../../../core/services/network_service/api_request.dart';
import '../domain/repo/auth_repo.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl extends AuthRepo {
  static const String _baseUrl = "/ds";
  static const String _loginEndpoint = "$_baseUrl/login";

  @override
  FutureDynamicResponse login({
    required String email,
    required String password,
  }) {
    final formData = {"username": email, "password": password};
    return getIt<ApiRequest>().getResponse(
      endPoint: _loginEndpoint,
      apiMethods: ApiMethods.post,
      body: FormData.fromMap(formData),
    );
  }
}
