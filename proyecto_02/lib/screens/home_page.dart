import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/patients_provider.dart';
import '../widgets/patient_card.dart';
import 'register_patient_page.dart';
import 'medical_record_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VetCare'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar paciente por nombre...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
      ),
      body: Consumer<PatientsProvider>(
        builder: (context, patientsProvider, child) {
          // Filtrar pacientes según el texto de búsqueda
          final filteredPatients =
              patientsProvider.patients.where((patient) {
                return patient.name.toLowerCase().contains(
                  _searchText.toLowerCase(),
                );
              }).toList();

          if (filteredPatients.isEmpty) {
            return Center(
              child: Text(
                _searchText.isEmpty
                    ? 'No hay pacientes registrados. ¡Añade uno!'
                    : 'No se encontraron pacientes con ese nombre.',
              ),
            );
          }
          return ListView.builder(
            itemCount: filteredPatients.length,
            itemBuilder: (context, index) {
              final patient = filteredPatients[index];
              return PatientCard(
                patient: patient,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MedicalRecordPage(patient: patient),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      const RegisterPatientPage(), // Para registrar, patientToEdit es null
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
