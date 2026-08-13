import '../../domain/entities/weight_entry_entity.dart';

/// Weight entry data model for Firebase/Firestore
/// Can be serialized to/from JSON and entities
class WeightEntryModel {
  final String id;
  final String profileId;
  final double weight;
  final String unit;
  final DateTime date;
  final DateTime recordedAt;

  WeightEntryModel({
    required this.id,
    required this.profileId,
    required this.weight,
    required this.unit,
    required this.date,
    required this.recordedAt,
  });

  /// Convert WeightEntryModel to WeightEntryEntity
  WeightEntryEntity toEntity() {
    return WeightEntryEntity(
      id: id,
      profileId: profileId,
      weight: weight,
      unit: unit,
      date: date,
      recordedAt: recordedAt,
    );
  }

  /// Create WeightEntryModel from WeightEntryEntity
  factory WeightEntryModel.fromEntity(WeightEntryEntity entity) {
    return WeightEntryModel(
      id: entity.id,
      profileId: entity.profileId,
      weight: entity.weight,
      unit: entity.unit,
      date: entity.date,
      recordedAt: entity.recordedAt,
    );
  }

  /// Create WeightEntryModel from Firestore JSON
  factory WeightEntryModel.fromJson(Map<String, dynamic> json) {
    return WeightEntryModel(
      id: json['id'] as String,
      profileId: json['profileId'] as String,
      weight: (json['weight'] as num).toDouble(),
      unit: json['unit'] as String,
      date: DateTime.parse(json['date'] as String),
      recordedAt: DateTime.parse(json['recordedAt'] as String),
    );
  }

  /// Convert WeightEntryModel to Firestore JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profileId': profileId,
      'weight': weight,
      'unit': unit,
      'date': date.toIso8601String(),
      'recordedAt': recordedAt.toIso8601String(),
    };
  }

  /// Create a copy with modified properties
  WeightEntryModel copyWith({
    String? id,
    String? profileId,
    double? weight,
    String? unit,
    DateTime? date,
    DateTime? recordedAt,
  }) {
    return WeightEntryModel(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      weight: weight ?? this.weight,
      unit: unit ?? this.unit,
      date: date ?? this.date,
      recordedAt: recordedAt ?? this.recordedAt,
    );
  }

  @override
  String toString() =>
      'WeightEntryModel(id: $id, weight: $weight $unit, date: $date)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeightEntryModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          profileId == other.profileId &&
          date == other.date;

  @override
  int get hashCode => id.hashCode ^ profileId.hashCode ^ date.hashCode;
}