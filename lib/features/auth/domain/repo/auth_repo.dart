import '../../../../core/constants/typedef.dart';

abstract class AuthRepo {
  FutureDynamicResponse login({
    required String email,
    required String password,
  });
}
