import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import 'debug_log_utils.dart';

class ImageCompressionHelper {
  /// Compress image to ≤ 0.15 MB (150 KB)
  static Future<File?> compressImageIfNeeded(
    File file, {
    int maxSizeInBytes = 150 * 1024, // 150 KB
  }) async {
    try {
      final originalSize = await file.length();

      if (originalSize <= maxSizeInBytes) return file;

      final targetPath = await _getCompressedFilePath(file);
      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 90,
        minWidth: 800, // max width 800
        minHeight: 600, // max height 600
        format: CompressFormat.jpeg,
      );

      if (compressedFile == null) {
        DebugLoggerService.log(
          "Compression failed at quality 90",
          level: LogLevel.warning,
        );
        return null;
      }

      if (await compressedFile.length() <= maxSizeInBytes) {
        return File(compressedFile.path);
      }

      // Retry with 50% quality
      final retryPath = await _getCompressedFilePath(file, suffix: "retry");
      final retryCompressedFile = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        retryPath,
        quality: 50,
        minWidth: 800, // max width 800
        minHeight: 600, // max height 600
        format: CompressFormat.jpeg,
      );
      if (retryCompressedFile is XFile) {
        return File(retryCompressedFile.path);
      }
    } catch (e) {
      DebugLoggerService.log(
        "Image compression error: $e",
        level: LogLevel.error,
      );
      return null;
    }
    return null;
  }

  static Future<String> _getCompressedFilePath(
    File file, {
    String suffix = "compressed",
  }) async {
    final dir = await getTemporaryDirectory();
    final filename = path.basenameWithoutExtension(file.path);
    return path.join(dir.path, "${filename}_$suffix.jpg");
  }
}
