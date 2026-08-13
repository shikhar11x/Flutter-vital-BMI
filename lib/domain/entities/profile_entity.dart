/// Profile business entity
/// Represents a health profile for a user
class ProfileEntity {
  final String id;
  final String ownerId; // Reference to User
  final String name;
  final String gender; // Male, Female, Other
  final double height; // In cm
  final String heightUnit; // 'cm' or 'in'
  final double weight; // In kg or lbs
  final String weightUnit; // 'kg' or 'lbs'
  final double? bmi; // Calculated BMI
  final String? bmiCategory; // Underweight, Normal, Overweight, Obese
  final bool isActive; // Is this the active profile
  final DateTime createdAt;
  final DateTime updatedAt;

  ProfileEntity({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.gender,
    required this.height,
    required this.heightUnit,
    required this.weight,
    required this.weightUnit,
    this.bmi,
    this.bmiCategory,
    this.isActive = false,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create a copy with modified properties
  ProfileEntity copyWith({
    String? id,
    String? ownerId,
    String? name,
    String? gender,
    double? height,
    String? heightUnit,
    double? weight,
    String? weightUnit,
    double? bmi,
    String? bmiCategory,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProfileEntity(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      heightUnit: heightUnit ?? this.heightUnit,
      weight: weight ?? this.weight,
      weightUnit: weightUnit ?? this.weightUnit,
      bmi: bmi ?? this.bmi,
      bmiCategory: bmiCategory ?? this.bmiCategory,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() =>
      'ProfileEntity(id: $id, name: $name, gender: $gender, '
      'height: $height $heightUnit, weight: $weight $weightUnit, bmi: $bmi)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          ownerId == other.ownerId &&
          name == other.name &&
          gender == other.gender &&
          height == other.height &&
          weight == other.weight &&
          bmi == other.bmi;

  @override
  int get hashCode =>
      id.hashCode ^
      ownerId.hashCode ^
      name.hashCode ^
      gender.hashCode ^
      height.hashCode ^
      weight.hashCode ^
      bmi.hashCode;
}