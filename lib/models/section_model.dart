import 'dart:convert';

//geoPointで一意になるからsectionIdはいらないかも

class Section {
  String sectionId;
  String sectionName;
  double minLatitude;
  double maxLatitude;
  double minLongitude;
  double maxLongitude;
  int doneNijimasCount;

  Section({
    required this.sectionId,
    required this.sectionName,
    required this.minLatitude,
    required this.maxLatitude,
    required this.minLongitude,
    required this.maxLongitude,
    required this.doneNijimasCount,
  });

  Section copyWith({
    String? sectionId,
    String? sectionName,
    double? minLatitude,
    double? maxLatitude,
    double? minLongitude,
    double? maxLongitude,
    int? doneNijimasCount,
  }) {
    return Section(
      sectionId: sectionId ?? this.sectionId,
      sectionName: sectionName ?? this.sectionName,
      minLatitude: minLatitude ?? this.minLatitude,
      maxLatitude: maxLatitude ?? this.maxLatitude,
      minLongitude: minLongitude ?? this.minLongitude,
      maxLongitude: maxLongitude ?? this.maxLongitude,
      doneNijimasCount: doneNijimasCount ?? this.doneNijimasCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sectionId': sectionId,
      'sectionName': sectionName,
      'minLatitude': minLatitude,
      'maxLatitude': maxLatitude,
      'minLongitude': minLongitude,
      'maxLongitude': maxLongitude,
      'doneNijimasCount': doneNijimasCount,
    };
  }

  factory Section.fromMap(Map<String, dynamic> map) {
    return Section(
      sectionId: map['sectionId'] ?? '',
      sectionName: map['sectionName'] ?? '',
      minLatitude: map['minLatitude']?.toDouble() ?? 0.0,
      maxLatitude: map['maxLatitude']?.toDouble() ?? 0.0,
      minLongitude: map['minLongitude']?.toDouble() ?? 0.0,
      maxLongitude: map['maxLongitude']?.toDouble() ?? 0.0,
      doneNijimasCount: map['doneNijimasCount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Section.fromJson(String source) =>
      Section.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Section(sectionId: $sectionId, sectionName: $sectionName, minLatitude: $minLatitude, maxLatitude: $maxLatitude, minLongitude: $minLongitude, maxLongitude: $maxLongitude, doneNijimasCount: $doneNijimasCount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Section &&
        other.sectionId == sectionId &&
        other.sectionName == sectionName &&
        other.minLatitude == minLatitude &&
        other.maxLatitude == maxLatitude &&
        other.minLongitude == minLongitude &&
        other.maxLongitude == maxLongitude &&
        other.doneNijimasCount == doneNijimasCount;
  }

  @override
  int get hashCode {
    return sectionId.hashCode ^
        sectionName.hashCode ^
        minLatitude.hashCode ^
        maxLatitude.hashCode ^
        minLongitude.hashCode ^
        maxLongitude.hashCode ^
        doneNijimasCount.hashCode;
  }
}
