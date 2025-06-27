import 'package:uuid/uuid.dart';
import 'medical_record.dart'; // Asegúrate de que esta importación sea correcta

class Patient {
  final String id;
  String name;
  String species;
  String? breed;
  DateTime dateOfBirth;
  String owner;
  List<MedicalRecord> medicalRecords;

  Patient({
    String? id,
    required this.name,
    required this.species,
    this.breed,
    required this.dateOfBirth,
    required this.owner,
    List<MedicalRecord>? medicalRecords,
  }) : id = id ?? const Uuid().v4(),
       medicalRecords = medicalRecords ?? [];

  // Constructor de fábrica para crear un Patient desde un Map (JSON)
  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] as String,
      name: json['name'] as String,
      species: json['species'] as String,
      breed: json['breed'] as String?,
      dateOfBirth: DateTime.parse(
        json['dateOfBirth'] as String,
      ), // Convierte el String de fecha a DateTime
      owner: json['owner'] as String,
      // Mapea la lista de JSON a una lista de MedicalRecord
      medicalRecords:
          (json['medicalRecords'] as List<dynamic>?)
              ?.map(
                (recordJson) =>
                    MedicalRecord.fromJson(recordJson as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  // Método para convertir Patient a un Map para JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'species': species,
    'breed': breed,
    'dateOfBirth': dateOfBirth.toIso8601String(), // Guarda la fecha como String
    'owner': owner,
    'medicalRecords':
        medicalRecords
            .map((record) => record.toJson())
            .toList(), // Convierte cada MedicalRecord a JSON
  };
}
