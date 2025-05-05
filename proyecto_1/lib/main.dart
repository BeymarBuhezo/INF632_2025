import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const EcoTipsApp());
}

class EcoTipsApp extends StatelessWidget {
  const EcoTipsApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Configuración básica de la aplicación (MaterialApp)
    return MaterialApp(
      title: 'EcoTips',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomePage(), // 1: Pantalla Principal (“HomePage”)
    );
  }
}
