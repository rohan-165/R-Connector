import 'dart:ui';

import 'package:flutter_localization/flutter_localization.dart';

part 'en_locale.dart';
part 'ne_locale.dart';

// ignore_for_file: constant_identifier_names

class AppLanguage {
  AppLanguage._();

  static const String ne_lang = 'ne';
  static const String en_lang = 'en';
}

mixin AppLocale {
  final FlutterLocalization localization = FlutterLocalization.instance;

  VoidCallback? onLanguageChanged;

  void initLang({required String languageCode}) {
    localization.init(
      mapLocales: [
        const MapLocale(AppLanguage.en_lang, AppLocale.en),
        const MapLocale(AppLanguage.ne_lang, AppLocale.ne),
      ],
      initLanguageCode: languageCode,
    );
    localization.onTranslatedLanguage = _onTranslatedLanguage;
  }

  void _onTranslatedLanguage(Locale? locale) {
    onLanguageChanged?.call();
  }

  /// ====================== Keys ==================== ///
  static const String languagae = 'languagae';
  static const String select_languagae = 'select_languagae';
  static const String select_theme = 'select_theme';

  /// ====================== Global Messages Key ==================== ///
  static const String no_internet_title = 'no_internet_title';
  static const String no_internet_subtitle = 'no_internet_subtitle';
  static const String no_data_title = 'no_data_title';
  static const String no_data_subtitle = 'no_data_subtitle';
  static const String something_went_wrong_title = 'something_went_wrong_title';
  static const String something_went_wrong_subtitle =
      'something_went_wrong_subtitle';
  static const String app_exit_msg = 'app_exit_msg';

  /// ====================== Button Key ==================== ///
  static const String retry = 'retry';
  static const String ok = 'ok';
  static const String cancel = 'cancel';
  static const String yes = 'yes';
  static const String no = 'no';
  static const String submit = 'submit';
  static const String save = 'save';
  static const String update = 'update';
  static const String delete = 'delete';
  static const String edit = 'edit';
  static const String add = 'add';
  static const String view_more = 'view_more';
  static const String view_less = 'view_less';
  static const String login = 'login';
  static const String logout = 'logout';
  static const String register = 'register';
  static const String sign_in = 'sign_in';
  static const String sign_up = 'sign_up';

  /// ====================== Input Label / Hint / Validation key ==================== ///
  static const String email = 'email';
  static const String password = 'password';
  static const String enter_email = 'enter_email';
  static const String enter_password = 'enter_password';
  static const String enter_valid_email = 'enter_valid_email';
  static const String enter_valid_password = 'enter_valid_password';
  static const String confirm_password = 'confirm_password';
  static const String enter_confirm_password = 'enter_confirm_password';
  static const String password_not_match = 'password_not_match';
  static const String full_name = 'full_name';
  static const String enter_full_name = 'enter_full_name';
  static const String enter_valid_full_name = 'enter_valid_full_name';
  static const String phone_number = 'phone_number';
  static const String enter_phone_number = 'enter_phone_number';
  static const String enter_valid_phone_number = 'enter_valid_phone_number';
  static const String address = 'address';
  static const String enter_address = 'enter_address';
  static const String enter_valid_address = 'enter_valid_address';

  static const Map<String, dynamic> en = enLocale;

  static const Map<String, dynamic> ne = neLocale;
}
