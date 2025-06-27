import 'package:flutter/material.dart';
import 'package:pracitca_3/widgets/custom_text_field.dart';

class SumaDigitosScreen extends StatefulWidget {
  const SumaDigitosScreen({super.key});

  @override
  State<SumaDigitosScreen> createState() => _SumaDigitosScreenState();
}

class _SumaDigitosScreenState extends State<SumaDigitosScreen> {
  final TextEditingController _numberController = TextEditingController();
  String _result = '';

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  void _calculateSumOfDigits() {
    final String inputText = _numberController.text;
    final int? number = int.tryParse(inputText);

    if (number == null) {
      setState(() {
        _result = 'Por favor, ingresa un número entero válido.';
      });
      return;
    }

    int sum = 0;
    String numberString =
        number.abs().toString(); // Usar valor absoluto para la suma de dígitos
    for (int i = 0; i < numberString.length; i++) {
      sum += int.parse(numberString[i]);
    }

    setState(() {
      _result = 'La suma de los dígitos de $number es: $sum';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Suma de Dígitos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: _numberController,
              labelText: 'Ingresa un número entero',
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: _calculateSumOfDigits,
              child: const Text('Calcular Suma de Dígitos'),
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
