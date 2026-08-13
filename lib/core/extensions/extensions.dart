/// Extension methods for better code readability
/// Provides convenient shortcuts for common operations
library extensions;

// ============= STRING EXTENSIONS =============

extension StringExtensions on String {
  /// Check if string is valid email
  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return isNotEmpty && emailRegex.hasMatch(this);
  }

  /// Check if string is valid password (min 6 chars)
  bool get isValidPassword => isNotEmpty && length >= 6;

  /// Capitalize first letter
  String get capitalize =>
      isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';

  /// Check if string is empty or whitespace
  bool get isEmptyOrWhitespace => trim().isEmpty;

  /// Truncate string to specified length
  String truncate(int length) =>
      this.length > length ? '${substring(0, length)}...' : this;

  /// Check if string contains only numbers
  bool get isNumeric => RegExp(r'^[0-9]+$').hasMatch(this);
}

// ============= DOUBLE EXTENSIONS =============

extension DoubleExtensions on double {
  /// Format double to specified decimal places
  String toStringWithPrecision(int decimals) {
    return toStringAsFixed(decimals);
  }

  /// Check if double is positive
  bool get isPositive => this > 0;

  /// Check if double is negative
  bool get isNegative => this < 0;

  /// Check if double is zero
  bool get isZero => this == 0;

  /// Round to nearest integer
  int get rounded => round();

  /// Check if value is within range
  bool isInRange(double min, double max) {
    return this >= min && this <= max;
  }

  /// Get percentage of total
  double getPercentage(double total) {
    if (total == 0) return 0;
    return (this / total) * 100;
  }
}

// ============= INT EXTENSIONS =============

extension IntExtensions on int {
  /// Check if number is even
  bool get isEven => this % 2 == 0;

  /// Check if number is odd
  bool get isOdd => this % 2 != 0;

  /// Check if number is positive
  bool get isPositive => this > 0;

  /// Check if number is negative
  bool get isNegative => this < 0;

  /// Convert to ordinal (1st, 2nd, 3rd, etc.)
  String get ordinal {
    if (this % 100 >= 11 && this % 100 <= 13) {
      return '${this}th';
    }
    switch (this % 10) {
      case 1:
        return '${this}st';
      case 2:
        return '${this}nd';
      case 3:
        return '${this}rd';
      default:
        return '${this}th';
    }
  }
}

// ============= DATETIME EXTENSIONS =============

extension DateTimeExtensions on DateTime {
  /// Check if date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year &&
        month == now.month &&
        day == now.day;
  }

  /// Check if date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Get start of day (midnight)
  DateTime get startOfDay {
    return DateTime(year, month, day);
  }

  /// Get end of day (23:59:59)
  DateTime get endOfDay {
    return DateTime(year, month, day, 23, 59, 59);
  }

  /// Get start of month
  DateTime get startOfMonth {
    return DateTime(year, month);
  }

  /// Get end of month
  DateTime get endOfMonth {
    if (month == 12) {
      return DateTime(year + 1, 1, 0);
    } else {
      return DateTime(year, month + 1, 0);
    }
  }

  /// Get days until this date
  int get daysUntil {
    return difference(DateTime.now()).inDays;
  }

  /// Get days since this date
  int get daysSince {
    return DateTime.now().difference(this).inDays;
  }
}

// ============= LIST EXTENSIONS =============

extension ListExtensions<T> on List<T> {
  /// Get first element or null if empty
  T? get firstOrNull => isEmpty ? null : first;

  /// Get last element or null if empty
  T? get lastOrNull => isEmpty ? null : last;

  /// Check if list is empty
  bool get isEmpty => length == 0;

  /// Check if list is not empty
  bool get isNotEmpty => length > 0;

  /// Get element at index or null if out of bounds
  T? getOrNull(int index) {
    return index >= 0 && index < length ? this[index] : null;
  }
}