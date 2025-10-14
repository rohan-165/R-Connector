import 'package:dri_flutter/core/constants/typedef.dart';
import 'package:dri_flutter/core/services/get_it/service_locator.dart';
import 'package:dri_flutter/core/services/network_service/api_request.dart';
import 'package:dri_flutter/features/support_user/domain/repo/support_user_repo.dart';

class SupportUserRepoImpl extends SupportUserRepo {
  static const String _baseUrl = '/api';

  @override
  FutureDynamicResponse getConsignmentDetail({required String url}) async {
    return getIt<ApiRequest>().getResponse(
      endPoint: _baseUrl + url,
      apiMethods: ApiMethods.get,
    );
  }
}
