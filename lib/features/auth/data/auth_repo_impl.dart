import 'package:injectable/injectable.dart';

import '../../../core/constants/typedef.dart';
import '../../../core/services/get_it/service_locator.dart';
import '../../../core/services/network_service/api_request.dart';
import '../domain/repo/auth_repo.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl extends AuthRepo {
  static const String _baseUrl = "/api/v1"; // Replace with actual base URL
  static const String _loginEndpoint = "$_baseUrl/login";
  static const String versionEndpoint = "$_baseUrl/get-app-version";

  @override
  FutureDynamicResponse login({
    required String email,
    required String password,
  }) {
    return getIt<ApiRequest>().getResponse(
      endPoint: _loginEndpoint,
      apiMethods: ApiMethods.post,
      body: {"email": email, "password": password},
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
