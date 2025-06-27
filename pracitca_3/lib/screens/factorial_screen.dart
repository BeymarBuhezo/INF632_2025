import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pracitca_3/widgets/custom_text_field.dart';

class FactorialScreen extends StatefulWidget {
  const FactorialScreen({super.key});

  @override
  State<FactorialScreen> createState() => _FactorialScreenState();
}

class _FactorialScreenState extends State<FactorialScreen> {
  final TextEditingController _numberController = TextEditingController();
  String _result = '';

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  BigInt _calculateFactorial(int n) {
    BigInt result = BigInt.one;
    for (int i = 1; i <= n; i++) {
      result *= BigInt.from(i);
    }
    return result;
  }

  void _findFactorial() {
    final int? number = int.tryParse(_numberController.text);

    if (number == null || number < 0) {
      setState(() {
        _result = 'Por favor, ingresa un número entero positivo válido.';
      });
      return;
    }

    setState(() {
      _result = 'El factorial de $number es: ${_calculateFactorial(number)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Factorial')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: _numberController,
              labelText: 'Ingresa un número entero positivo',
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            ElevatedButton(
              onPressed: _findFactorial,
              child: const Text('Calcular Factorial'),
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
