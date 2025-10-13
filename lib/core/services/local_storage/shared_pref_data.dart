import '../../constants/typedef.dart';

abstract class SharedPrefData {
  FutureVoid saveAuthToken({required String token});
  String get getAuthToken;
  FutureVoid clearAuthToken();

  FutureVoid saveTheme({required String theme});
  String? get getTheme;

  FutureVoid saveLanguage({required String language});
  String? get getLanguage;

  FutureVoid clearAllSharedData();
}
