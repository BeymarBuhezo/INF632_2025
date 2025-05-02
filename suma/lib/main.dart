import 'package:flutter/material.dart';

void main() {
  runApp(const SumadorNumeros());
}

class SumadorNumeros extends StatefulWidget {
  const SumadorNumeros({super.key});

  @override
  State<SumadorNumeros> createState() => _SumadorNumerosState();
}

class _SumadorNumerosState extends State<SumadorNumeros> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  String _resultado = '';

  void _sumarNumeros() {
    double? num1 = double.tryParse(_controller1.text) ?? 0;
    double? num2 = double.tryParse(_controller2.text) ?? 0;

    setState(() {
      _resultado = 'Resultado: ${num1 + num2}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sumador de Números',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Sumador de Numeros')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(controller: _controller1),
              const SizedBox(height: 20),
              TextField(controller: _controller2),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _sumarNumeros,
                child: const Text('Sumar'),
              ),
              const SizedBox(height: 25),
              Text(
                _resultado,
                style: const TextStyle(fontSize: 35, color: Colors.redAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
