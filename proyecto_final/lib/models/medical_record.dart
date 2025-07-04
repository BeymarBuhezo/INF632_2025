import 'package:uuid/uuid.dart';

class MedicalRecord {
  final String id;
  final DateTime date;
  final String description;

  MedicalRecord({String? id, required this.date, required this.description})
    : id = id ?? const Uuid().v4();

  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    return MedicalRecord(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(),
    'description': description,
  };
}
