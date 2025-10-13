import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../bloc/internet_cubit.dart';
import '../bloc/language_cubit.dart';
import '../services/get_it/service_locator.dart';

extension BuildContextExension on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  bool get isOnline => getIt<InternetCubit>().state.isOnline;

  bool get isEnglish => getIt<LanguageCubit>().isEnglish();

  String l10(String key) {
    return key.getString(this);
  }

  double pixelRatio() => MediaQuery.of(this).devicePixelRatio;

  Brightness platformBrightness() => MediaQuery.of(this).platformBrightness;

  double get statusBarHeight => MediaQuery.of(this).padding.top;

  double get navigationBarHeight => MediaQuery.of(this).padding.bottom;

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  FormState? get formState => Form.of(this);

  ScaffoldState get scaffoldState => Scaffold.of(this);

  OverlayState? get overlayState => Overlay.of(this);

  void requestFocus(FocusNode focus) {
    FocusScope.of(this).requestFocus(focus);
  }

  void unFocus(FocusNode focus) {
    focus.unfocus();
  }
}
