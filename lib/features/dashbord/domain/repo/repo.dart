import 'dart:io';

import 'package:r_connector/core/constants/typedef.dart';

abstract class DashboardRepo {
  FutureDynamicResponse getFile();
  Future<File?> fetchPdfFile({required String filePath});
}
