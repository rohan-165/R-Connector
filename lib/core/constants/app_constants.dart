// ignore_for_file: non_constant_identifier_names

class AppConstants {
  AppConstants._();

  static const String appName = 'DRI VCTRS';
}

class DatePickerType {
  DatePickerType._();
  static const String englishDate = "english_date";
  static const String nepaliDate = "nepali_date";
}

class NavBarConstants {
  NavBarConstants._();

  static const String home = 'Home';
  static const String profile = 'Profile';
}

class Constants {
  //FOR START AND END DELIVERY: delivery status conditions
  static String delivered = "2";
  static String delivery_ongoing = "1";
  static String delivery_ongoing2 = "3";
  static String not_dispatched = "0";
  //FOR lock status conditions
  static String locked = "1";
  static String unlocked = "2";
  //FOR multiple conditions
  static String multiple = "1";
  static String single = "0";
  //FOR multiple conditions
  static String mid_consignment = "0";
  //FOR document type
  static String doc_type_b = "बिल";
  static String doc_type_c = "चलान";
  static String doc_type_cr = "CR नोट";
  static String doc_type_dr = "DR नोट";
  static String doc_type_nb = "निकासी बिल";
  static String doc_type_o = "Others";
  static String doc_type_p = "प्रज्ञापन पत्र";

  static String DRIVER_TOPIC = "DRIVER_OFFICE_NOTIFICATION";
  static String FIELD_TOPIC = "FIELD_OFFICE_NOTIFICATION";
  //FOR FIELD OFFICE: to view data after scanning QR code (for Online & Offline Cases)
  static String ONLINE = "tag_online";
  static String OFFLINE = "tag_offline";
  static String TAG_OFF_ON_CHECKER = "TAG_OFF_ON_CHECKER";

  static String Company_admin = "5";
  static String Super_admin = "1";
  static String User = "7";
  static String Driver = "3";
  static String Support_User = "10";

  static String notification_count = "0";

  static String active_user = "1";
  static String inactive_user = "0";
}
