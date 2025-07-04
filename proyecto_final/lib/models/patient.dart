import 'package:uuid/uuid.dart';
import 'medical_record.dart';

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

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] as String,
      name: json['name'] as String,
      species: json['species'] as String,
      breed: json['breed'] as String?,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      owner: json['owner'] as String,

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

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'species': species,
    'breed': breed,
    'dateOfBirth': dateOfBirth.toIso8601String(),
    'owner': owner,
    'medicalRecords': medicalRecords.map((record) => record.toJson()).toList(),
  };
}
