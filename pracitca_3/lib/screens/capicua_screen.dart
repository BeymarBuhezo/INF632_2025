import 'package:flutter/material.dart';
import 'package:pracitca_3/widgets/custom_text_field.dart';

class CapicuaScreen extends StatefulWidget {
  const CapicuaScreen({super.key});

  @override
  State<CapicuaScreen> createState() => _CapicuaScreenState();
}

class _CapicuaScreenState extends State<CapicuaScreen> {
  final TextEditingController _numberController = TextEditingController();
  String _result = '';

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  void _checkCapicua() {
    final String inputText = _numberController.text;
    if (inputText.isEmpty) {
      setState(() {
        _result = 'Por favor, ingresa un número.';
      });
      return;
    }

    final String reversedText = inputText.split('').reversed.join('');

    if (inputText == reversedText) {
      setState(() {
        _result = '$inputText es un número capicúa.';
      });
    } else {
      setState(() {
        _result = '$inputText NO es un número capicúa.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Número Capicúa')),
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
              onPressed: _checkCapicua,
              child: const Text('Verificar Capicúa'),
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
