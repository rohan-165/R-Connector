import 'package:dri_flutter/core/constants/typedef.dart';

abstract class SupportUserRepo {
  FutureDynamicResponse getConsignmentDetail({required String url});
}
