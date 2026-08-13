import 'package:intl/intl.dart';
import '../constants/app_constants.dart';

/// Date formatting utility
/// Handles all date formatting across the app
class DateFormatter {
  DateFormatter._(); // Private constructor

  /// Format date as short format (e.g., "16 May")
  static String formatDateShort(DateTime date) {
    return DateFormat(AppConstants.dateFormatShort).format(date);
  }

  /// Format date as full format (e.g., "16 May, 2024")
  static String formatDateFull(DateTime date) {
    return DateFormat(AppConstants.dateFormatFull).format(date);
  }

  /// Format date for chart X-axis (e.g., "16/05")
  static String formatDateChart(DateTime date) {
    return DateFormat(AppConstants.dateFormatChartX).format(date);
  }

  /// Format date and time (e.g., "16 May 2024, 2:30 PM")
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
  }

  /// Get human-readable time difference
  /// e.g., "2 hours ago", "3 days ago"
  static String getTimeAgo(DateTime dateTime) {
    Duration difference = DateTime.now().difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  /// Check if two dates are the same day
  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /// Get date range string
  /// e.g., "16 May - 23 May"
  static String getDateRange(DateTime startDate, DateTime endDate) {
    String start = formatDateShort(startDate);
    String end = formatDateShort(endDate);
    return '$start - $end';
  }

  /// Get date for display in weight history
  static String getWeightHistoryDateFormat(DateTime date) {
    // If today, show "Today"
    if (isSameDay(date, DateTime.now())) {
      return 'Today';
    }

    // If yesterday, show "Yesterday"
    DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
    if (isSameDay(date, yesterday)) {
      return 'Yesterday';
    }

    // Otherwise show date
    return formatDateShort(date);
  }

  /// Format last recorded date
  static String getLastRecordedText(DateTime date) {
    String timeAgo = getTimeAgo(date);
    return 'Last recorded: $timeAgo';
  }
}