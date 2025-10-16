import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:r_connector/core/constants/typedef.dart';
import 'package:r_connector/core/services/get_it/service_locator.dart';
import 'package:r_connector/core/services/network_service/api_request.dart';
import 'package:r_connector/core/utils/debug_log_utils.dart';
import 'package:r_connector/features/dashbord/domain/repo/repo.dart';

@LazySingleton(as: DashboardRepo)
class DashboardRepoImpl extends DashboardRepo {
  static const String _getFile = ':8081/user-list/view/1';
  static const String _postSign = '/ds/sign';

  @override
  FutureDynamicResponse getFile() async {
    return getIt<ApiRequest>().getResponse(
      endPoint: _getFile,
      apiMethods: ApiMethods.get,
    );
  }

  @override
  Future<File?> fetchPdfFile({required String filePath}) async {
    const url = 'http://192.168.150.12:8080/ds/temp/sign/view';
    final dio = Dio();

    try {
      final response = await dio.post(
        url,
        data: {"filePath": filePath},
        options: Options(
          responseType: ResponseType.bytes, // expect raw PDF bytes
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        final dir = await getTemporaryDirectory();
        final fileName = DateTime.now().toIso8601String();
        final filePath = '${dir.path}/$fileName.pdf';
        final file = File(filePath);
        await file.writeAsBytes(response.data);
        return file; // ✅ return the file object
      } else {
        DebugLoggerService.log(
          '❌ Failed to load PDF: ${response.statusCode}',
          level: LogLevel.error,
        );
        DebugLoggerService.log(
          'Response: ${response.data}',
          level: LogLevel.error,
        );
        return null;
      }
    } on DioException catch (e) {
      DebugLoggerService.log(
        '⚠️ Dio error: ${e.response?.statusCode} → ${e.response?.data}',
        level: LogLevel.error,
      );
      return null;
    } catch (e) {
      DebugLoggerService.log('⚠️ General error: $e', level: LogLevel.error);
      return null;
    }
  }
}
