import 'package:flutter/material.dart';
import 'package:pracitca_3/widgets/custom_text_field.dart';

class AmigosScreen extends StatefulWidget {
  const AmigosScreen({super.key});

  @override
  State<AmigosScreen> createState() => _AmigosScreenState();
}

class _AmigosScreenState extends State<AmigosScreen> {
  final TextEditingController _number1Controller = TextEditingController();
  final TextEditingController _number2Controller = TextEditingController();
  String _result = '';

  @override
  void dispose() {
    _number1Controller.dispose();
    _number2Controller.dispose();
    super.dispose();
  }

  int _sumOfProperDivisors(int n) {
    int sum = 1; // 1 siempre es un divisor propio
    for (int i = 2; i * i <= n; i++) {
      if (n % i == 0) {
        sum += i;
        if (i * i != n) {
          sum += n ~/ i;
        }
      }
    }
    return sum;
  }

  void _checkAmigos() {
    final int? num1 = int.tryParse(_number1Controller.text);
    final int? num2 = int.tryParse(_number2Controller.text);

    if (num1 == null || num2 == null || num1 <= 0 || num2 <= 0) {
      setState(() {
        _result = 'Por favor, ingresa dos números enteros positivos válidos.';
      });
      return;
    }

    final int sumDivisors1 = _sumOfProperDivisors(num1);
    final int sumDivisors2 = _sumOfProperDivisors(num2);

    if (sumDivisors1 == num2 && sumDivisors2 == num1) {
      setState(() {
        _result = '$num1 y $num2 SON números amigos.';
      });
    } else {
      setState(() {
        _result = '$num1 y $num2 NO SON números amigos.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Números Amigos')),
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
              onPressed: _checkAmigos,
              child: const Text('Verificar Números Amigos'),
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
