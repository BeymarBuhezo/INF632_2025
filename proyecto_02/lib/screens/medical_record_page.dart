import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/patient.dart';
import '../models/medical_record.dart';
import '../providers/patients_provider.dart';
import 'register_patient_page.dart'; // Importa la página de registro

class MedicalRecordPage extends StatefulWidget {
  final Patient patient;

  const MedicalRecordPage({Key? key, required this.patient}) : super(key: key);

  @override
  State<MedicalRecordPage> createState() => _MedicalRecordPageState();
}

class _MedicalRecordPageState extends State<MedicalRecordPage> {
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _addMedicalRecord() {
    if (_formKey.currentState!.validate()) {
      final newRecord = MedicalRecord(
        date: DateTime.now(),
        description: _descriptionController.text,
      );

      Provider.of<PatientsProvider>(
        context,
        listen: false,
      ).addMedicalRecord(widget.patient.id, newRecord);

      _descriptionController.clear();
      Navigator.pop(context); // Cierra el diálogo
    }
  }

  void _showAddRecordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nueva Entrada Clínica'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingresa una descripción';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _descriptionController.clear(); // Limpiar si se cancela
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: _addMedicalRecord,
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final patient = Provider.of<PatientsProvider>(
      context,
    ).getPatientById(widget.patient.id);

    if (patient == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Paciente no encontrado.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Historia de ${patient.name}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => RegisterPatientPage(patientToEdit: patient),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nombre: ${patient.name}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('Especie: ${patient.species}'),
                if (patient.breed != null && patient.breed!.isNotEmpty)
                  Text('Raza: ${patient.breed}'),
                Text(
                  'Fecha de Nacimiento: ${DateFormat.yMd().format(patient.dateOfBirth)}',
                ),
                Text('Propietario: ${patient.owner}'),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Text(
              'Entradas de Historia Clínica',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Expanded(
            child:
                patient.medicalRecords.isEmpty
                    ? const Center(child: Text('No hay entradas clínicas.'))
                    : ListView.builder(
                      itemCount: patient.medicalRecords.length,
                      itemBuilder: (context, index) {
                        final record = patient.medicalRecords[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          child: ListTile(
                            title: Text(
                              DateFormat.yMd().add_jm().format(record.date),
                            ),
                            subtitle: Text(record.description),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                Provider.of<PatientsProvider>(
                                  context,
                                  listen: false,
                                ).removeMedicalRecord(patient.id, record.id);
                              },
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddRecordDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
