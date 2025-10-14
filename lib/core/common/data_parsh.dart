import '../utils/debug_log_utils.dart';

dynamic parseJson<T>({
  required Map<String, dynamic> json,
  required T Function(Map<String, dynamic>) fromJson,
  String? extraKey,
}) {
  dynamic data = json;

  try {
    int maxDepth = 3;
    while (data is Map<String, dynamic> &&
        data.containsKey('data') &&
        maxDepth > 0) {
      data = data['data'];
      maxDepth--;
    }

    if (extraKey != null &&
        data is Map<String, dynamic> &&
        data.containsKey(extraKey)) {
      data = data[extraKey];
    }

    if (data is List) {
      return data.whereType<Map<String, dynamic>>().map(fromJson).toList();
    } else if (data is Map<String, dynamic>) {
      return fromJson(data);
    } else {
      DebugLoggerService.log(
        "parseJson() Unexpected data format: $data",
        level: LogLevel.error,
      );
      return null;
    }
  } catch (e, stack) {
    DebugLoggerService.log(
      "parseJson() Error parsing JSON: $e \nStack trace: $stack",
      level: LogLevel.error,
    );
    return null;
  }
}
