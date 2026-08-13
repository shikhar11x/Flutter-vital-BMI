import '../constants/bmi_constants.dart';

/// Unit conversion utilities
/// Handles conversions between different weight and height units
class UnitConverter {
  UnitConverter._(); // Private constructor

  // ============= WEIGHT CONVERSIONS =============

  /// Convert weight from one unit to another
  /// 
  /// Supported units: 'kg', 'lbs'
  static double convertWeight({
    required double value,
    required String fromUnit,
    required String toUnit,
  }) {
    if (fromUnit == toUnit) return value;

    String from = fromUnit.toLowerCase();
    String to = toUnit.toLowerCase();

    if (from == 'kg' && to == 'lbs') {
      return value / BMIConstants.poundsToKg;
    } else if (from == 'lbs' && to == 'kg') {
      return value * BMIConstants.poundsToKg;
    } else {
      throw ArgumentError(
        'Invalid weight units: $fromUnit to $toUnit',
      );
    }
  }

  /// Convert weight to kg (regardless of input unit)
  static double toKg(double value, String unit) {
    String u = unit.toLowerCase();
    if (u == 'kg') return value;
    if (u == 'lbs') return value * BMIConstants.poundsToKg;
    throw ArgumentError('Invalid weight unit: $unit');
  }

  /// Convert weight from kg to specified unit
  static double fromKg(double valueKg, String toUnit) {
    String u = toUnit.toLowerCase();
    if (u == 'kg') return valueKg;
    if (u == 'lbs') return valueKg / BMIConstants.poundsToKg;
    throw ArgumentError('Invalid weight unit: $toUnit');
  }

  // ============= HEIGHT CONVERSIONS =============

  /// Convert height to centimeters (from any unit)
  /// 
  /// Supported units: 'cm', 'in', 'ft', 'ft_in' (format: "5_10" for 5'10")
  static double toCm({
    required double value,
    required String unit,
    double? inchValue, // For feet+inches format
  }) {
    String u = unit.toLowerCase();

    if (u == 'cm') {
      return value;
    } else if (u == 'in') {
      return value * BMIConstants.inchToMeter * 100;
    } else if (u == 'ft') {
      return value * BMIConstants.footToMeter * 100;
    } else if (u == 'ft_in' && inchValue != null) {
      // Format: feet and inches separately
      double totalInches = (value * 12) + inchValue;
      return totalInches * BMIConstants.inchToMeter * 100;
    } else {
      throw ArgumentError('Invalid height unit: $unit');
    }
  }

  /// Convert height from centimeters to specified unit
  static double fromCm({
    required double valueCm,
    required String toUnit,
  }) {
    String u = toUnit.toLowerCase();

    if (u == 'cm') {
      return valueCm;
    } else if (u == 'in') {
      return valueCm / (BMIConstants.inchToMeter * 100);
    } else if (u == 'ft') {
      return valueCm / (BMIConstants.footToMeter * 100);
    } else {
      throw ArgumentError('Invalid height unit: $toUnit');
    }
  }

  /// Convert height from one unit to another
  static double convertHeight({
    required double value,
    required String fromUnit,
    required String toUnit,
  }) {
    if (fromUnit == toUnit) return value;

    double cm = toCm(value: value, unit: fromUnit);
    return fromCm(valueCm: cm, toUnit: toUnit);
  }

  /// Split centimeter height into feet and inches
  /// Returns map with 'feet' and 'inches' keys
  static Map<String, int> cmToFeetInches(double cm) {
    double totalInches = cm / (BMIConstants.inchToMeter * 100);
    int feet = totalInches ~/ 12;
    int inches = (totalInches % 12).round();

    return {
      'feet': feet,
      'inches': inches,
    };
  }

  /// Combine feet and inches into centimeters
  static double feetInchesToCm(int feet, int inches) {
    double totalInches = (feet * 12.0) + inches;
    return totalInches * BMIConstants.inchToMeter * 100;
  }

  /// Format height for display
  /// 
  /// Returns formatted string like "5'10\"" or "180 cm"
  static String formatHeight(double height, String unit) {
    if (unit.toLowerCase() == 'cm') {
      return '${height.toStringAsFixed(0)} cm';
    } else if (unit.toLowerCase() == 'in') {
      Map<String, int> feetInches = cmToFeetInches(
        toCm(value: height, unit: 'in'),
      );
      return "${feetInches['feet']}'${feetInches['inches']}\"";
    }
    return '$height $unit';
  }

  /// Format weight for display
  static String formatWeight(double weight, String unit) {
    return '${weight.toStringAsFixed(1)} ${unit.toUpperCase()}';
  }
}