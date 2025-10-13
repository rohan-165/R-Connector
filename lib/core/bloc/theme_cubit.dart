import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../services/get_it/service_locator.dart';
import '../services/local_storage/shared_pref_data.dart';
import '../services/navigation_service.dart';

@lazySingleton
class ThemeCubit extends Cubit<String> {
  ThemeCubit() : super(ThemeMode.light.name);

  void init() {
    final String theme =
        getIt<SharedPrefData>().getTheme ?? ThemeMode.light.name;
    emit(theme);
  }

  void toggleTheme({required String themeMode}) {
    emit(themeMode);
    getIt<SharedPrefData>().saveTheme(theme: themeMode);
  }

  void resetTheme() {
    emit(ThemeMode.light.name);
  }

  void setDeviceTheme() {
    final Brightness brightness = MediaQuery.of(
      getIt<NavigationService>().getNavigationContext(),
    ).platformBrightness;

    String theme = brightness.name;
    emit(theme);
  }
}
