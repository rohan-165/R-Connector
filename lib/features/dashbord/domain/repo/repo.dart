import 'package:r_connector/core/constants/typedef.dart';

abstract class DashboardRepo {
  FutureDynamicResponse getFile();
  FutureDynamicResponse getPdf({required String filePath});
}
