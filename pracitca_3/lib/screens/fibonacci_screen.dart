import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pracitca_3/widgets/custom_text_field.dart';

class FibonacciScreen extends StatefulWidget {
  const FibonacciScreen({super.key});

  @override
  State<FibonacciScreen> createState() => _FibonacciScreenState();
}

class _FibonacciScreenState extends State<FibonacciScreen> {
  final TextEditingController _numberController = TextEditingController();
  String _result = '';

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  List<int> _generateFibonacci(int n) {
    if (n <= 0) return [];
    if (n == 1) return [0];
    if (n == 2) return [0, 1];

    List<int> fibonacci = [0, 1];
    for (int i = 2; i < n; i++) {
      fibonacci.add(fibonacci[i - 1] + fibonacci[i - 2]);
    }
    return fibonacci;
  }

  void _showFibonacci() {
    final int? n = int.tryParse(_numberController.text);

    if (n == null || n < 0) {
      setState(() {
        _result = 'Por favor, ingresa un número entero positivo válido.';
      });
      return;
    }

    final List<int> fibonacciSeries = _generateFibonacci(n);
    setState(() {
      _result =
          'Serie de Fibonacci hasta $n términos:\n${fibonacciSeries.join(', ')}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Serie de Fibonacci hasta N')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: _numberController,
              labelText: 'Ingresa el número N',
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            ElevatedButton(
              onPressed: _showFibonacci,
              child: const Text('Generar Serie de Fibonacci'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _result,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
