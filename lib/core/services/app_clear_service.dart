import 'package:dri_flutter/features/support_user/presentation/consignment_detail_bloc/consignment_detail_bloc.dart';
import 'package:dri_flutter/features/support_user/presentation/cubit/qr_scan_cubit.dart';

import '../bloc/app_open_cubit.dart';
import '../bloc/language_cubit.dart';
import '../bloc/location_cubit.dart';
import '../bloc/theme_cubit.dart';
import '../routes/routes_name.dart';
import 'get_it/service_locator.dart';
import 'local_storage/shared_pref_data.dart';
import 'navigation_service.dart';

class AppClearService {
  void clearAllData() async {
    getIt<SharedPrefData>().clearAuthToken();
    getIt<SharedPrefData>().clearAllSharedData();

    getIt<AppOpenCubit>().reset();
    getIt<ThemeCubit>().resetTheme();
    getIt<LanguageCubit>().resetLanguage();
    getIt<LocationCubit>().reset();
    getIt<QrScanCubit>().reset();
    getIt<ConsignmentDetailBloc>().add(ConsignmentDetailResetEvent());

    getIt<NavigationService>().pushNamedAndRemoveUntil(
      RoutesName.loginScreen,
      false,
    );
  }
}
