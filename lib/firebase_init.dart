import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import 'core/utils/debug_log_utils.dart';

Future<void> initFirebase() async {
  try {
    await Firebase.initializeApp();

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  } catch (e, stackTrace) {
    DebugLoggerService.log(
      "Firebase initialization failed: $e",
      level: LogLevel.error,
    );

    await FirebaseCrashlytics.instance.recordError(e, stackTrace, fatal: true);

    rethrow;
  }
}
