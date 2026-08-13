import '../../domain/entities/profile_entity.dart';

/// Profile data model for Firebase/Firestore
/// Can be serialized to/from JSON and entities
class ProfileModel {
  final String id;
  final String ownerId;
  final String name;
  final String gender;
  final double height;
  final String heightUnit;
  final double weight;
  final String weightUnit;
  final double? bmi;
  final String? bmiCategory;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProfileModel({
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

  /// Convert ProfileModel to ProfileEntity
  ProfileEntity toEntity() {
    return ProfileEntity(
      id: id,
      ownerId: ownerId,
      name: name,
      gender: gender,
      height: height,
      heightUnit: heightUnit,
      weight: weight,
      weightUnit: weightUnit,
      bmi: bmi,
      bmiCategory: bmiCategory,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create ProfileModel from ProfileEntity
  factory ProfileModel.fromEntity(ProfileEntity entity) {
    return ProfileModel(
      id: entity.id,
      ownerId: entity.ownerId,
      name: entity.name,
      gender: entity.gender,
      height: entity.height,
      heightUnit: entity.heightUnit,
      weight: entity.weight,
      weightUnit: entity.weightUnit,
      bmi: entity.bmi,
      bmiCategory: entity.bmiCategory,
      isActive: entity.isActive,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// Create ProfileModel from Firestore JSON
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String,
      ownerId: json['ownerId'] as String,
      name: json['name'] as String,
      gender: json['gender'] as String,
      height: (json['height'] as num).toDouble(),
      heightUnit: json['heightUnit'] as String,
      weight: (json['weight'] as num).toDouble(),
      weightUnit: json['weightUnit'] as String,
      bmi: json['bmi'] != null ? (json['bmi'] as num).toDouble() : null,
      bmiCategory: json['bmiCategory'] as String?,
      isActive: json['isActive'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Convert ProfileModel to Firestore JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ownerId': ownerId,
      'name': name,
      'gender': gender,
      'height': height,
      'heightUnit': heightUnit,
      'weight': weight,
      'weightUnit': weightUnit,
      'bmi': bmi,
      'bmiCategory': bmiCategory,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// Create a copy with modified properties
  ProfileModel copyWith({
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
    return ProfileModel(
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
      'ProfileModel(id: $id, name: $name, ownerId: $ownerId, gender: $gender, '
      'height: $height $heightUnit, weight: $weight $weightUnit, bmi: $bmi)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          ownerId == other.ownerId &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ ownerId.hashCode ^ name.hashCode;
}