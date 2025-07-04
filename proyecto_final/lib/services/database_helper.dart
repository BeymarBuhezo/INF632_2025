import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/patient.dart';
import '../models/medical_record.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = await getDatabasesPath();
    String dbPath = join(path, 'vetcare.db');
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: _onCreate,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Crear tabla de pacientes
    await db.execute('''
      CREATE TABLE patients(
        id TEXT PRIMARY KEY,
        name TEXT,
        species TEXT,
        breed TEXT,
        dateOfBirth TEXT,
        owner TEXT
      )
    ''');
    // Crear tabla de registros médicos
    await db.execute('''
      CREATE TABLE medicalRecords(
        id TEXT PRIMARY KEY,
        patientId TEXT,
        date TEXT,
        description TEXT,
        FOREIGN KEY (patientId) REFERENCES patients(id) ON DELETE CASCADE
      )
    ''');
  }

  Future<void> insertPatient(Patient patient) async {
    final db = await database;
    await db.insert(
      'patients',
      patient.toJsonNoRecords(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Patient>> getPatients() async {
    final db = await database;
    final List<Map<String, dynamic>> patientMaps = await db.query('patients');

    // Para cada paciente, obtener sus registros médicos
    return Future.wait(
      patientMaps.map((patientMap) async {
        final patientId = patientMap['id'] as String;
        final medicalRecords = await getMedicalRecordsForPatient(patientId);
        // Creamos un nuevo mapa que incluya los medicalRecords para el constructor Patient.fromJson
        final Map<String, dynamic> patientData = Map<String, dynamic>.from(
          patientMap,
        );
        patientData['medicalRecords'] =
            medicalRecords.map((e) => e.toJson()).toList();
        return Patient.fromJson(patientData);
      }).toList(),
    );
  }

  Future<void> updatePatient(Patient patient) async {
    final db = await database;
    await db.update(
      'patients',
      patient.toJsonNoRecords(),
      where: 'id = ?',
      whereArgs: [patient.id],
    );
  }

  Future<void> deletePatient(String id) async {
    final db = await database;
    await db.delete('patients', where: 'id = ?', whereArgs: [id]);
  }

  // --- Operaciones para Registros Médicos ---

  Future<void> insertMedicalRecord(
    String patientId,
    MedicalRecord record,
  ) async {
    final db = await database;
    final Map<String, dynamic> recordJson = record.toJson();
    recordJson['patientId'] = patientId; // Añadir patientId al mapa para la BD
    await db.insert(
      'medicalRecords',
      recordJson,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<MedicalRecord>> getMedicalRecordsForPatient(
    String patientId,
  ) async {
    final db = await database;
    final List<Map<String, dynamic>> recordMaps = await db.query(
      'medicalRecords',
      where: 'patientId = ?',
      whereArgs: [patientId],
      orderBy: 'date DESC', // Ordenar por fecha, los más recientes primero
    );
    return recordMaps.map((json) => MedicalRecord.fromJson(json)).toList();
  }

  Future<void> deleteMedicalRecord(String recordId) async {
    final db = await database;
    await db.delete('medicalRecords', where: 'id = ?', whereArgs: [recordId]);
  }
}

extension PatientToJsonNoRecords on Patient {
  Map<String, dynamic> toJsonNoRecords() => {
    'id': id,
    'name': name,
    'species': species,
    'breed': breed,
    'dateOfBirth': dateOfBirth.toIso8601String(),
    'owner': owner,
  };
}
