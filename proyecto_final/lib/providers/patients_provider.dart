import 'package:flutter/material.dart';
import '../models/patient.dart';
import '../models/medical_record.dart';
import '../services/database_helper.dart';

class PatientsProvider with ChangeNotifier {
  final List<Patient> _patients = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  PatientsProvider() {
    _loadPatients();
  }

  List<Patient> get patients => _patients;

  Future<void> _loadPatients() async {
    try {
      _patients.clear();
      final loadedPatients = await _dbHelper.getPatients();
      _patients.addAll(loadedPatients);
      notifyListeners();
    } catch (e) {
      debugPrint('Error al cargar pacientes desde la base de datos: $e');
    }
  }

  void addPatient(Patient p) async {
    try {
      await _dbHelper.insertPatient(p);
      _patients.add(p); // Añadir a la lista local
      notifyListeners();
    } catch (e) {
      debugPrint('Error al añadir paciente: $e');
    }
  }

  void updatePatient(Patient updatedPatient) async {
    try {
      final index = _patients.indexWhere((p) => p.id == updatedPatient.id);
      if (index != -1) {
        _patients[index] = updatedPatient;
        await _dbHelper.updatePatient(updatedPatient); // Guardar en la BD
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error al actualizar paciente: $e');
    }
  }

  void addMedicalRecord(String patientId, MedicalRecord r) async {
    try {
      await _dbHelper.insertMedicalRecord(patientId, r);
      final patient = _patients.firstWhere((p) => p.id == patientId);
      patient.medicalRecords.add(r);
      patient.medicalRecords.sort(
        (a, b) => b.date.compareTo(a.date),
      ); // Ordenar por fecha descendente
      notifyListeners();
    } catch (e) {
      debugPrint('Error al añadir registro médico: $e');
    }
  }

  void removeMedicalRecord(String patientId, String recordId) async {
    try {
      debugPrint(
        'Intentando eliminar recordId: $recordId para patientId: $patientId',
      );
      await _dbHelper.deleteMedicalRecord(recordId);
      final patient = _patients.firstWhere((p) => p.id == patientId);
      patient.medicalRecords.removeWhere((r) => r.id == recordId);
      notifyListeners();
    } catch (e) {
      debugPrint('Error al eliminar registro médico (ID: $recordId): $e');
      // Puedes añadir un manejo de UI aquí, como un SnackBar
    }
  }

  Patient? getPatientById(String id) {
    try {
      return _patients.firstWhere((p) => p.id == id);
    } catch (e) {
      debugPrint('Paciente con ID $id no encontrado en el provider: $e');
      return null;
    }
  }

  void removePatient(String patientId) async {
    try {
      await _dbHelper.deletePatient(patientId);
      _patients.removeWhere((p) => p.id == patientId);
      notifyListeners();
    } catch (e) {
      debugPrint('Error al eliminar paciente: $e');
    }
  }
}
