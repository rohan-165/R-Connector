import 'package:intl/intl.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

import 'debug_log_utils.dart';

String? formatDateTime(String inputDateTime) {
  try {
    DateTime dateTime = DateTime.parse(inputDateTime); // handles ISO 8601

    return DateFormat("MMM dd yyyy hh:mm a").format(dateTime.toLocal());
  } catch (e) {
    DebugLoggerService.log("Invalid date format: $e");
    return null;
  }
}

int calculateMonthDifferenceFromNepali(NepaliDateTime nepaliDate) {
  // Convert to DateTime (Gregorian)
  final inputDate = nepaliDate.toDateTime();
  final now = NepaliDateTime.now().toDateTime(); // today's date in Gregorian

  int yearDiff = now.year - inputDate.year;
  int monthDiff = now.month - inputDate.month;

  int totalMonths = yearDiff * 12 + monthDiff;

  // Adjust if the day hasn't completed in the current month
  if (inputDate.day > now.day) {
    totalMonths -= 1;
  }

  return totalMonths;
}

int calculateWeekDifferenceFromNepali(NepaliDateTime nepaliDate) {
  // Convert to Gregorian DateTime
  final inputDate = nepaliDate.toDateTime();
  final now = NepaliDateTime.now().toDateTime();

  // Calculate the total day difference
  final dayDifference = now.difference(inputDate).inDays;

  // Convert to weeks
  final weekDifference = dayDifference ~/ 7;

  return weekDifference;
}

bool isValidWeekRangeFromMonths(int monthCount) {
  int totalWeeks = (monthCount * 4.345)
      .floor(); // Convert months to approximate weeks
  return totalWeeks > 6 && totalWeeks <= 59;
}

String getGreetingMessage() {
  final now = DateTime.now();
  final hour = now.hour;

  if (hour >= 5 && hour < 12) {
    return "Good Morning";
  } else if (hour >= 12 && hour < 17) {
    return "Good Afternoon";
  } else if (hour >= 17 && hour < 21) {
    return "Good Evening";
  } else {
    return "Good Night";
  }
}
