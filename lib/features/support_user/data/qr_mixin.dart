import 'dart:convert';
import 'package:dri_flutter/core/constants/enum.dart';
import 'package:dri_flutter/core/routes/routes_name.dart';
import 'package:dri_flutter/core/services/get_it/service_locator.dart';
import 'package:dri_flutter/core/services/navigation_service.dart';
import 'package:dri_flutter/core/services/permission_service.dart';
import 'package:dri_flutter/core/utils/app_toast.dart';
import 'package:dri_flutter/core/utils/debug_log_utils.dart';
import 'package:dri_flutter/features/support_user/domain/scan_model.dart';
import 'package:flutter/material.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import '../../../core/utils/lzstring.dart';

mixin QrMixin {
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
                  return;
                }

                DebugLoggerService.log(
                  'QR raw value: $rawValue',
                  level: LogLevel.debug,
                );

                final decompressed = await decompressFromBase64(rawValue);

                if (decompressed == null) {
                  AppToasts.showToast(
                    message:
                        'Failed to read QR data — invalid or corrupted code.',
                    toastType: ToastType.ERROR,
                  );
                  getIt<NavigationService>().safePop();
                  return;
                }

                DebugLoggerService.log(
                  'Decompressed payload: $decompressed',
                  level: LogLevel.debug,
                );

                try {
                  final decoded = jsonDecode(decompressed);

                  if (decoded is! Map<String, dynamic>) {
                    throw const FormatException('Unexpected JSON structure');
                  }

                  final scanData = ScanData.fromJson(decoded);

                  // Navigate to detail page
                  getIt<NavigationService>().pushReplacementNamed(
                    RoutesName.consignmentDetailScreen,
                  );
                } catch (e, st) {
                  DebugLoggerService.log(
                    'Error parsing QR data: $e\n$st',
                    level: LogLevel.error,
                  );

                  AppToasts.showToast(
                    message: 'Invalid QR content or no data found.',
                    toastType: ToastType.ERROR,
                  );

                  getIt<NavigationService>().safePop();
                }
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
