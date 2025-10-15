import 'package:dri_flutter/core/constants/enum.dart';
import 'package:dri_flutter/core/services/get_it/service_locator.dart';
import 'package:dri_flutter/core/services/navigation_service.dart';
import 'package:dri_flutter/core/services/permission_service.dart';
import 'package:dri_flutter/core/utils/app_toast.dart';
import 'package:dri_flutter/core/utils/debug_log_utils.dart';
import 'package:dri_flutter/features/support_user/presentation/cubit/qr_scan_cubit.dart';
import 'package:flutter/material.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import '../../../core/utils/lzstring.dart';

mixin QrMixin {
  static const String _hasData =
      'N4Ig9gdiBcIBYBcEAcDO0A6B6bA3AxgqgCYBOAlgHRlUDmYulEy2AhsudvmALY+RtUqcrQgBTYgGFIw0TzEQEAETEJW5ADbYAHAEZtAJgAMu3UYCsAFl3ntIADTgAZk5ih85GCD2GTZqzZ2jvhQsBgArkYAnEYA7BHRBtoJUZbEKQYARimWmQAEGbo58ZFRBumlAMwGGawplUY5FdGV2gWlBnWlafWNVWKU9TVVTpQOIPjIXg02NlHaAGzjuKEgAAoASgCCSgCiAMoAEsYGugaW5gDSh1sL5rqWywhea+GZGuT448SrANYK5Ey3x4q3mliMCyM2ihum+yGIXgAMltEQBJAAqawAqhs4RovPstgA5XZrLbfBAI2CXLbow4AWWJSixFPx1NpDKZWLy32Iz1gxkMAFojAYhac8rpYtADJUZeZvqgvBAwONSDwvAgxKhno5iGzQEDYEZxl9jeMpua9aQvAZxqqrRMbY6IEaQCaAL6OHhs93jH1UiDhDQaD0eoA==';

  void qrScanStatic() => getIt<QrScanCubit>().getScanData(hasString: _hasData);

  Future<void> qrScanner(BuildContext context) async {
    PermissionService.requestPermission(
      permissionFor: PermissionFor.camera,
      onGrantedCallback: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AiBarcodeScanner(
              onDetect: (BarcodeCapture capture) async {
                final rawValue = capture.barcodes.firstOrNull?.rawValue ?? '';

                if (rawValue.isEmpty) {
                  AppToasts.showToast(
                    message: 'No QR code detected!',
                    toastType: ToastType.ERROR,
                  );
                  getIt<NavigationService>().safePop();
                  return;
                }
                getIt<QrScanCubit>().getScanData(hasString: rawValue);
              },
            ),
          ),
        );
      },
      onDeniedCallback: () {
        AppToasts.showToast(
          message: 'Camera permission denied!',
          toastType: ToastType.ERROR,
        );
      },
    );
  }

  /// Decompress a QR payload produced by LZString and encoded in Base64.
  Future<String?> decompressFromBase64(String input) async {
    if (input.isEmpty) {
      DebugLoggerService.log(
        'Empty input passed to decompressFromBase64.',
        level: LogLevel.warning,
      );
      return null;
    }

    try {
      final decompressed = await LZString.decompressFromBase64(input);

      if (decompressed == null || decompressed.isEmpty) {
        DebugLoggerService.log(
          'LZString decompress returned null or empty string.',
          level: LogLevel.error,
        );
        return null;
      }

      return decompressed;
    } catch (e, st) {
      DebugLoggerService.log(
        'Error decompressing LZString: $e\n$st',
        level: LogLevel.error,
      );
      return null;
    }
  }
}
