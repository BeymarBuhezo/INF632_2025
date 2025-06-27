import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Necesario para jsonEncode y jsonDecode
import '../models/patient.dart';
import '../models/medical_record.dart';

class PatientsProvider with ChangeNotifier {
  final List<Patient> _patients = [];
  static const String _patientsKey = 'patients_data';

  PatientsProvider() {
    _loadPatients(); // Cargar pacientes al inicializar el provider
  }

  List<Patient> get patients => _patients;

  // Cargar pacientes desde SharedPreferences
  Future<void> _loadPatients() async {
    final prefs = await SharedPreferences.getInstance();
    final String? patientsJson = prefs.getString(_patientsKey);
    if (patientsJson != null) {
      final List<dynamic> patientList = jsonDecode(patientsJson);
      _patients.clear(); // Limpiar antes de cargar para evitar duplicados
      _patients.addAll(
        patientList.map((json) => Patient.fromJson(json)).toList(),
      );
      notifyListeners();
    }
  }

  // Guardar pacientes en SharedPreferences
  Future<void> _savePatients() async {
    final prefs = await SharedPreferences.getInstance();
    final String patientsJson = jsonEncode(
      _patients.map((p) => p.toJson()).toList(),
    );
    await prefs.setString(_patientsKey, patientsJson);
  }

  void addPatient(Patient p) {
    _patients.add(p);
    notifyListeners();
    _savePatients(); // Guardar después de añadir
  }

  void updatePatient(Patient updatedPatient) {
    // Como Patient es mutable, la referencia en _patients ya está actualizada.
    // Solo necesitamos notificar y guardar.
    notifyListeners();
    _savePatients(); // Guardar después de actualizar
  }

  void addMedicalRecord(String patientId, MedicalRecord r) {
    final patient = _patients.firstWhere((p) => p.id == patientId);
    patient.medicalRecords.add(r);
    notifyListeners();
    _savePatients(); // Guardar después de añadir registro
  }

  void removeMedicalRecord(String patientId, String recordId) {
    final patient = _patients.firstWhere((p) => p.id == patientId);
    patient.medicalRecords.removeWhere((r) => r.id == recordId);
    notifyListeners();
    _savePatients(); // Guardar después de eliminar registro
  }

  Patient? getPatientById(String id) {
    try {
      return _patients.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  void removePatient(String patientId) {
    _patients.removeWhere((p) => p.id == patientId);
    notifyListeners();
    _savePatients(); // Guardar después de eliminar paciente
  }
}
