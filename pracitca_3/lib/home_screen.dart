import 'package:flutter/material.dart';
import 'package:pracitca_3/screens/amigos_screen.dart';
import 'package:pracitca_3/screens/capicua_screen.dart';
import 'package:pracitca_3/screens/contar_vocales_screen.dart';
import 'package:pracitca_3/screens/factorial_screen.dart';
import 'package:pracitca_3/screens/fibonacci_screen.dart';
import 'package:pracitca_3/screens/invertir_screen.dart';
import 'package:pracitca_3/screens/mcd_screen.dart';
import 'package:pracitca_3/screens/perfecto_screen.dart';
import 'package:pracitca_3/screens/primo_screen.dart';
import 'package:pracitca_3/screens/suma_digitos_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menú de Utilidades')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildMenuItem(context, 'Números Amigos', const AmigosScreen()),
          _buildMenuItem(context, 'Número Capicúa', const CapicuaScreen()),
          _buildMenuItem(
            context,
            'Contar Vocales',
            const ContarVocalesScreen(),
          ),
          _buildMenuItem(context, 'Suma de Dígitos', const SumaDigitosScreen()),
          _buildMenuItem(context, 'Número Perfecto', const PerfectoScreen()),
          _buildMenuItem(
            context,
            'Máximo Común Divisor (MCD)',
            const McdScreen(),
          ),
          _buildMenuItem(context, 'Número Primo', const PrimoScreen()),
          _buildMenuItem(
            context,
            'Invertir Número o Palabra',
            const InvertirScreen(),
          ),
          _buildMenuItem(context, 'Factorial', const FactorialScreen()),
          _buildMenuItem(
            context,
            'Serie de Fibonacci hasta N',
            const FibonacciScreen(),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, Widget screen) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontSize: 18.0)),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
      ),
    );
  }
}
