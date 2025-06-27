import 'package:flutter/material.dart';
import 'package:pracitca_3/widgets/custom_text_field.dart';

class PrimoScreen extends StatefulWidget {
  const PrimoScreen({super.key});

  @override
  State<PrimoScreen> createState() => _PrimoScreenState();
}

class _PrimoScreenState extends State<PrimoScreen> {
  final TextEditingController _numberController = TextEditingController();
  String _result = '';

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  bool _isPrime(int n) {
    if (n <= 1) return false;
    for (int i = 2; i * i <= n; i++) {
      if (n % i == 0) {
        return false;
      }
    }
    return true;
  }

  void _checkPrimo() {
    final int? number = int.tryParse(_numberController.text);

    if (number == null) {
      setState(() {
        _result = 'Por favor, ingresa un número entero válido.';
      });
      return;
    }

    if (_isPrime(number)) {
      setState(() {
        _result = '$number ES un número primo.';
      });
    } else {
      setState(() {
        _result = '$number NO ES un número primo.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Número Primo')),
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
              onPressed: _checkPrimo,
              child: const Text('Verificar Primo'),
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
