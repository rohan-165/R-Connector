import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:r_connector/core/constants/app_constants.dart';
import 'package:r_connector/core/constants/typedef.dart';
import 'package:r_connector/core/services/get_it/service_locator.dart';
import 'package:r_connector/core/services/network_service/api_request.dart';
import 'package:r_connector/core/utils/debug_log_utils.dart';
import 'package:r_connector/features/dashbord/domain/repo/repo.dart';

@LazySingleton(as: DashboardRepo)
class DashboardRepoImpl extends DashboardRepo {
  static const String _getFile = ':8081/user-list/view/1';
  static const String _postSign = ':8080/ds/sign';

  @override
  FutureDynamicResponse getFile() async {
    return getIt<ApiRequest>().getResponse(
      endPoint: _getFile,
      apiMethods: ApiMethods.get,
    );
  }

  @override
  FutureDynamicResponse postSign({
    required String filePath,
    required String signPage,
    required String certificateFileSource,
    required String stampSource,
    required String qrImageSource,
    required String unsignedSource,
    required String publicCertificateFileSource,
    required String stampRoText,
    required String password,
  }) async {
    final data = {
      "certificateFileSource": certificateFileSource,
      "certificatePath": "/home/sajak/ocr-ds/PROD/Rabin Karki.p12",
      "certificatePassword": password,
      "publicCertificateFileSource": publicCertificateFileSource,
      "publicCertificatePath": "/home/sajak/ocr-ds/PROD/rabin.p7b",
      "coordinates": {"x1": 400, "y1": 500, "x2": 300, "y2": 100},
      "signPage": signPage,
      "lastPage": 0,
      "textOrStamp": stampRoText == StampOrText.stamp ? 1 : 0,
      "stampSource": stampSource,
      "stampFilePath": "stampFilePath_7f353af702aa",
      "unsignedSource": unsignedSource,
      "unsignedFilePath": filePath,
      "qrImageSource": qrImageSource,
      "qrImageFilePath": "qrImageFilePath_8b1cb3adb33a",
      "qrCoordinateX": 0,
      "qrCoordinateY": 0,
      "reasonOfSignature": "reasonOfSignature_ae701f055d25",
      "contactOfSignature": "contactOfSignature_5b96e1ee773e",
      "locationOfSignature": "locationOfSignature_324271c58d3b",
      "automateSignature": false,
      "signatureImageDetails": {
        "param0": "param0_85cc7b6e77fc",
        "param1": "param1_feaaed0cf03e",
        "param2": "param2_be3bb4cca979",
        "param3": "param3_e4374f4dd07d",
        "param4": "param4_2e249c802c66",
        "param5": "param5_b3b07a28f8a3",
      },
    };
    return getIt<ApiRequest>().getResponse(
      endPoint: _postSign,
      apiMethods: ApiMethods.post,
      body: data,
    );
  }

  @override
  Future<Uint8List?> fetchPdfData({required String filePath}) async {
    const url = 'http://192.168.150.12:8080/ds/temp/sign/view';
    final dio = Dio();

    try {
      final response = await dio.post(
        url,
        data: {"filePath": filePath},
        options: Options(
          responseType: ResponseType.bytes, // 👈 Expect raw PDF bytes
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        return Uint8List.fromList(response.data);
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
