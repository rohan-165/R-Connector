import 'package:injectable/injectable.dart';
import 'package:r_connector/core/constants/typedef.dart';
import 'package:r_connector/core/services/get_it/service_locator.dart';
import 'package:r_connector/core/services/network_service/api_request.dart';
import 'package:r_connector/features/dashbord/domain/repo/repo.dart';

@LazySingleton(as: DashboardRepo)
class DashboardRepoImpl extends DashboardRepo {
  static const String _getFile = 'http://192.168.150.12:8081/user-list/view/1';
  static const String _getPdf = '/ds/temp/sign/view';
  static const String _postSign = '/ds/sign';

  @override
  FutureDynamicResponse getFile() async {
    return getIt<ApiRequest>().getResponse(
      endPoint: _getFile,
      apiMethods: ApiMethods.get,
    );
  }

  @override
  FutureDynamicResponse getPdf({required String filePath}) async {
    return getIt<ApiRequest>().getResponse(
      endPoint: _getPdf,
      apiMethods: ApiMethods.get,
      body: {"filePath": filePath},
    );
  }
}
