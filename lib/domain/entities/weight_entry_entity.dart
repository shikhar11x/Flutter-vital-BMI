/// Weight entry business entity
/// Represents a single weight measurement
class WeightEntryEntity {
  final String id;
  final String profileId; // Reference to Profile
  final double weight; // Weight value
  final String unit; // 'kg' or 'lbs'
  final DateTime date; // Date of measurement
  final DateTime recordedAt; // When it was recorded

  WeightEntryEntity({
    required this.id,
    required this.profileId,
    required this.weight,
    required this.unit,
    required this.date,
    required this.recordedAt,
  });

  /// Create a copy with modified properties
  WeightEntryEntity copyWith({
    String? id,
    String? profileId,
    double? weight,
    String? unit,
    DateTime? date,
    DateTime? recordedAt,
  }) {
    return WeightEntryEntity(
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
      'WeightEntryEntity(id: $id, weight: $weight $unit, date: $date)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeightEntryEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          profileId == other.profileId &&
          weight == other.weight &&
          unit == other.unit &&
          date == other.date;

  @override
  int get hashCode =>
      id.hashCode ^
      profileId.hashCode ^
      weight.hashCode ^
      unit.hashCode ^
      date.hashCode;
}