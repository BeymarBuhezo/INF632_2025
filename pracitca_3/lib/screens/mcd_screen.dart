import 'package:flutter/material.dart';
import 'package:pracitca_3/widgets/custom_text_field.dart';

class McdScreen extends StatefulWidget {
  const McdScreen({super.key});

  @override
  State<McdScreen> createState() => _McdScreenState();
}

class _McdScreenState extends State<McdScreen> {
  final TextEditingController _number1Controller = TextEditingController();
  final TextEditingController _number2Controller = TextEditingController();
  String _result = '';

  @override
  void dispose() {
    _number1Controller.dispose();
    _number2Controller.dispose();
    super.dispose();
  }

  int _calculateMCD(int a, int b) {
    while (b != 0) {
      int temp = b;
      b = a % b;
      a = temp;
    }
    return a;
  }

  void _findMCD() {
    final int? num1 = int.tryParse(_number1Controller.text);
    final int? num2 = int.tryParse(_number2Controller.text);

    if (num1 == null || num2 == null) {
      setState(() {
        _result = 'Por favor, ingresa dos números enteros válidos.';
      });
      return;
    }

    setState(() {
      _result = 'El MCD de $num1 y $num2 es: ${_calculateMCD(num1, num2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Máximo Común Divisor (MCD)')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: _number1Controller,
              labelText: 'Ingresa el primer número',
              keyboardType: TextInputType.number,
            ),
            CustomTextField(
              controller: _number2Controller,
              labelText: 'Ingresa el segundo número',
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: _findMCD,
              child: const Text('Calcular MCD'),
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
