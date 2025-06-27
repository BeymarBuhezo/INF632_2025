import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart'; // Importa para inicializar la localización de fechas
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es', null); // Inicializa para español
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controlador Financiero',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
      // Rutas para facilitar la navegación
      routes: {
        // Puedes agregar más rutas aquí según las pantallas
      },
    );
  }
}
