import 'package:flutter/material.dart';
import 'package:pracitca_3/widgets/custom_text_field.dart';

class InvertirScreen extends StatefulWidget {
  const InvertirScreen({super.key});

  @override
  State<InvertirScreen> createState() => _InvertirScreenState();
}

class _InvertirScreenState extends State<InvertirScreen> {
  final TextEditingController _inputController = TextEditingController();
  String _result = '';

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _invertInput() {
    final String inputText = _inputController.text;
    if (inputText.isEmpty) {
      setState(() {
        _result = 'Por favor, ingresa un número o palabra.';
      });
      return;
    }

    final String reversedText = inputText.split('').reversed.join('');

    setState(() {
      _result = 'Inversión: $reversedText';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Invertir Número o Palabra')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: _inputController,
              labelText: 'Ingresa un número o palabra',
            ),
            ElevatedButton(
              onPressed: _invertInput,
              child: const Text('Invertir'),
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
