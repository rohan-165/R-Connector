import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:r_connector/core/extension/build_context_extension.dart';
import 'package:r_connector/core/extension/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../constants/app_colors.dart';
import '../constants/enum.dart';
import '../services/get_it/service_locator.dart';
import '../services/navigation_service.dart';
import '../services/permission_service.dart';
import '../utils/debug_log_utils.dart';
import '../utils/image_compress_helper.dart';

mixin ImageMixin {
  Future<File?> _pickImageFromGallery() async {
    final completer = Completer<File?>();
    PermissionService.requestPermission(
      permissionFor: PermissionFor.gallery,
      onGrantedCallback: () async {
        try {
          final picker = ImagePicker();
          final image = await picker.pickImage(source: ImageSource.gallery);

          if (image != null) {
            final file = File(image.path);
            final compressFile = ImageCompressionHelper.compressImageIfNeeded(
              file,
            );
            completer.complete(compressFile);
          } else {
            completer.complete(null); // User cancelled
          }
        } catch (e) {
          DebugLoggerService.log(" Error :: $e", level: LogLevel.error);
          completer.complete(null);
        }
      },
      onDeniedCallback: () => completer.complete(null),
      onOthersDeniedCallback: (_) => completer.complete(null),
    );

    return completer.future;
  }

  Future<File?> _pickImageFromCamera() async {
    final completer = Completer<File?>();

    PermissionService.requestPermission(
      permissionFor: PermissionFor.camera,
      onGrantedCallback: () async {
        try {
          final picker = ImagePicker();
          final image = await picker.pickImage(source: ImageSource.camera);

          if (image != null) {
            final file = File(image.path);
            final compressFile = ImageCompressionHelper.compressImageIfNeeded(
              file,
            );
            completer.complete(compressFile);
          } else {
            completer.complete(null); // User canceled
          }
        } catch (e) {
          DebugLoggerService.log(" Error :: $e", level: LogLevel.error);
          completer.complete(null);
        }
      },
      onDeniedCallback: () => completer.complete(null),
      onOthersDeniedCallback: (_) => completer.complete(null),
    );

    return completer.future;
  }

  Future<void> bottomSheet(
    BuildContext context, {
    required Function(File? file) callBack,
  }) async {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
          left: 16.w,
          right: 16.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 5.h,
              width: 0.4.sw,
              decoration: BoxDecoration(
                color: context.isDark
                    ? AppColors.lightGreyColor
                    : AppColors.darkGreyColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ).padBottom(bottom: 10.h),
            Text(
              "Choose Image From",
              style: context.textTheme.titleLarge,
            ).padBottom(bottom: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _view(ctx, image: Icons.image, lable: 'Gallery').onTap(
                  () async {
                    final file = await _pickImageFromGallery();
                    getIt<NavigationService>().goBack(); // Dismiss bottom sheet
                    callBack(file);
                  },
                ),
                _view(ctx, image: Icons.camera, lable: 'Camera').onTap(
                  () async {
                    final file = await _pickImageFromCamera();
                    getIt<NavigationService>().goBack(); // Dismiss bottom sheet
                    callBack(file);
                  },
                ),
              ],
            ).padBottom(bottom: 20.h),
          ],
        ),
      ),
    );
  }

  Future<Uint8List?> fileToUint8List(File file) async {
    try {
      final bytes = await file.readAsBytes();
      return bytes;
    } catch (e, stackTrace) {
      DebugLoggerService.log(
        'Error reading file to Uint8List: $e',
        level: LogLevel.error,
      );
      DebugLoggerService.log(stackTrace.toString(), level: LogLevel.error);
      return null;
    }
  }

  Future<File?> uint8ListToFile(Uint8List data) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final filePath = '${dir.path}/file_$timestamp.jpg';
      final file = File(filePath);

      return await file.writeAsBytes(data);
    } catch (e, stackTrace) {
      DebugLoggerService.log(
        'Error writing Uint8List to file: $e',
        level: LogLevel.error,
      );
      DebugLoggerService.log(stackTrace.toString(), level: LogLevel.error);
      return null;
    }
  }

  Widget _view(
    BuildContext context, {
    required IconData image,
    required String lable,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          image,
          color: context.isDark ? AppColors.whiteColor : null,
          size: 0.05.sh,
        ).padBottom(bottom: 10.h),
        Text(lable, style: context.textTheme.bodyLarge).padBottom(bottom: 10.h),
      ],
    );
  }
}
