import 'package:uuid/uuid.dart';

class MedicalRecord {
  final String id;
  final DateTime date;
  final String description;

  MedicalRecord({String? id, required this.date, required this.description})
    : id = id ?? const Uuid().v4();

  // Constructor de fábrica para crear un MedicalRecord desde un Map (JSON)
  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    return MedicalRecord(
      id: json['id'] as String,
      date: DateTime.parse(
        json['date'] as String,
      ), // Convierte el String de fecha a DateTime
      description: json['description'] as String,
    );
  }

  // Método para convertir MedicalRecord a un Map para JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(), // Guarda la fecha como String ISO 8601
    'description': description,
  };
}
