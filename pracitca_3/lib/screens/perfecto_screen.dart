import 'package:flutter/material.dart';
import 'package:pracitca_3/widgets/custom_text_field.dart';

class PerfectoScreen extends StatefulWidget {
  const PerfectoScreen({super.key});

  @override
  State<PerfectoScreen> createState() => _PerfectoScreenState();
}

class _PerfectoScreenState extends State<PerfectoScreen> {
  final TextEditingController _numberController = TextEditingController();
  String _result = '';

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  bool _isPerfect(int n) {
    if (n <= 0) return false;
    int sum = 1; // 1 siempre es un divisor propio
    for (int i = 2; i * i <= n; i++) {
      if (n % i == 0) {
        sum += i;
        if (i * i != n) {
          sum += n ~/ i;
        }
      }
    }
    return sum == n;
  }

  void _checkPerfect() {
    final int? number = int.tryParse(_numberController.text);

    if (number == null || number <= 0) {
      setState(() {
        _result = 'Por favor, ingresa un número entero positivo válido.';
      });
      return;
    }

    if (_isPerfect(number)) {
      setState(() {
        _result = '$number ES un número perfecto.';
      });
    } else {
      setState(() {
        _result = '$number NO ES un número perfecto.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Número Perfecto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: _numberController,
              labelText: 'Ingresa un número',
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: _checkPerfect,
              child: const Text('Verificar Número Perfecto'),
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
