import 'dart:typed_data';

import 'package:r_connector/core/constants/typedef.dart';

abstract class DashboardRepo {
  FutureDynamicResponse getFile();
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
  });
  Future<Uint8List?> fetchPdfData({required String filePath});
}
