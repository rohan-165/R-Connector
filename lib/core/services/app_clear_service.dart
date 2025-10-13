import '../../features/dashboard/presentation/bloc/nav_bar_cubit/nav_bar_cubit.dart';
import '../bloc/app_open_cubit.dart';
import '../bloc/language_cubit.dart';
import '../bloc/location_cubit.dart';
import '../bloc/theme_cubit.dart';
import '../constants/shared_pref_keys.dart';
import '../routes/routes_name.dart';
import 'get_it/service_locator.dart';
import 'local_storage/shared_pref_data.dart';
import 'local_storage/shared_pref_service.dart';
import 'navigation_service.dart';

class AppClearService {
  void clearAllData() async {
    final String? email = getIt<SharedPrefsServices>().getString(
      key: SharedPrefKeys.userNameKey,
    );
    final String? password = getIt<SharedPrefsServices>().getString(
      key: SharedPrefKeys.passwordKey,
    );
    final bool rememberMe =
        getIt<SharedPrefsServices>().getBool(
          key: SharedPrefKeys.rememberMeKey,
        ) ??
        false;

    getIt<SharedPrefData>().clearAuthToken();
    getIt<SharedPrefData>().clearAllSharedData();

    getIt<AppOpenCubit>().reset();
    getIt<ThemeCubit>().resetTheme();
    getIt<LanguageCubit>().resetLanguage();
    getIt<LocationCubit>().reset();
    getIt<NavBarCubit>().resetNavBar();

    if (rememberMe) {
      getIt<SharedPrefsServices>().setString(
        key: SharedPrefKeys.userNameKey,
        value: email ?? '',
      );
      getIt<SharedPrefsServices>().setString(
        key: SharedPrefKeys.passwordKey,
        value: password ?? '',
      );
      getIt<SharedPrefsServices>().setBool(
        key: SharedPrefKeys.rememberMeKey,
        value: rememberMe,
      );
    }

    getIt<NavigationService>().pushNamedAndRemoveUntil(
      RoutesName.loginScreen,
      false,
    );
  }
}
