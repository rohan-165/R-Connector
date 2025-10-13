import 'dart:io';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'debug_log_utils.dart';

class AppUpdateUtils {
  /// Opens Play Store or App Store based on the platform
  static Future<void> openStore({
    required String playStoreUrl,
    required String appStoreUrl,
  }) async {
    final Uri url = Uri.parse(Platform.isAndroid ? playStoreUrl : appStoreUrl);

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}

Future<String> getAppVersion() async {
  try {
    final PackageInfo info = await PackageInfo.fromPlatform();
    return info.version; // e.g., "1.0.2"
  } catch (e) {
    // Log error for debugging
    DebugLoggerService.log(
      "❌ Failed to get app version: $e",
      level: LogLevel.error,
    );

    // Return a safe fallback
    return "0.0.0";
  }
}

Future<bool> showAppAlert({String? latestVersion}) async {
  final String currentVersion = await getAppVersion();
  final version = (latestVersion ?? '').isNotEmpty
      ? latestVersion ?? currentVersion
      : currentVersion;

  return _isVersionLower(currentVersion, version);
}

/// Compare version strings like "1.0.0" < "1.0.2"
bool _isVersionLower(String current, String latest) {
  final currentParts = current.split('.').map(int.parse).toList();
  final latestParts = latest.split('.').map(int.parse).toList();

  for (int i = 0; i < latestParts.length; i++) {
    final currentValue = i < currentParts.length ? currentParts[i] : 0;
    final latestValue = latestParts[i];

    if (currentValue < latestValue) {
      return true; // current is lower → show alert
    } else if (currentValue > latestValue) {
      return false; // current is higher → no alert
    }
  }

  return false; // versions are equal
}
