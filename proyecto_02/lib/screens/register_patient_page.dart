import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/patient.dart';
import '../providers/patients_provider.dart';
import 'package:intl/intl.dart'; // Asegúrate de tener intl en tu pubspec.yaml

class RegisterPatientPage extends StatefulWidget {
  final Patient? patientToEdit; // Hazlo opcional para edición

  const RegisterPatientPage({Key? key, this.patientToEdit}) : super(key: key);

  @override
  State<RegisterPatientPage> createState() => _RegisterPatientPageState();
}

class _RegisterPatientPageState extends State<RegisterPatientPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _speciesController = TextEditingController();
  final _breedController = TextEditingController();
  final _ownerController = TextEditingController();
  DateTime? _selectedDateOfBirth;

  @override
  void initState() {
    super.initState();
    if (widget.patientToEdit != null) {
      // Prellenar el formulario si estamos editando
      _nameController.text = widget.patientToEdit!.name;
      _speciesController.text = widget.patientToEdit!.species;
      _breedController.text = widget.patientToEdit!.breed ?? '';
      _ownerController.text = widget.patientToEdit!.owner;
      _selectedDateOfBirth = widget.patientToEdit!.dateOfBirth;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _speciesController.dispose();
    _breedController.dispose();
    _ownerController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateOfBirth ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDateOfBirth) {
      setState(() {
        _selectedDateOfBirth = picked;
      });
    }
  }

  void _savePatient() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDateOfBirth == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor, selecciona una fecha de nacimiento'),
          ),
        );
        return;
      }

      final patientsProvider = Provider.of<PatientsProvider>(
        context,
        listen: false,
      );

      if (widget.patientToEdit == null) {
        // Modo de registro
        final newPatient = Patient(
          name: _nameController.text,
          species: _speciesController.text,
          breed:
              _breedController.text.isNotEmpty ? _breedController.text : null,
          dateOfBirth: _selectedDateOfBirth!,
          owner: _ownerController.text,
        );
        patientsProvider.addPatient(newPatient);
      } else {
        // Modo de edición
        widget.patientToEdit!.name = _nameController.text;
        widget.patientToEdit!.species = _speciesController.text;
        widget.patientToEdit!.breed =
            _breedController.text.isNotEmpty ? _breedController.text : null;
        widget.patientToEdit!.dateOfBirth = _selectedDateOfBirth!;
        widget.patientToEdit!.owner = _ownerController.text;
        patientsProvider.updatePatient(
          widget.patientToEdit!,
        ); // Necesitaremos este nuevo método en el provider
      }
      Navigator.pop(context); // Regresar a la pantalla anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.patientToEdit == null ? 'Registrar Mascota' : 'Editar Mascota',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el nombre de la mascota';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _speciesController,
                decoration: const InputDecoration(labelText: 'Especie'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa la especie';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _breedController,
                decoration: const InputDecoration(labelText: 'Raza (Opcional)'),
              ),
              ListTile(
                title: Text(
                  _selectedDateOfBirth == null
                      ? 'Fecha de Nacimiento'
                      : 'Fecha de Nacimiento: ${DateFormat.yMd().format(_selectedDateOfBirth!)}',
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
              TextFormField(
                controller: _ownerController,
                decoration: const InputDecoration(labelText: 'Propietario'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el nombre del propietario';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _savePatient,
                child: Text(
                  widget.patientToEdit == null
                      ? 'Guardar Mascota'
                      : 'Actualizar Mascota',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
