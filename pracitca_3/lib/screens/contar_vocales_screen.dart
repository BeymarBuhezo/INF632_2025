import 'package:flutter/material.dart';
import 'package:pracitca_3/widgets/custom_text_field.dart';

class ContarVocalesScreen extends StatefulWidget {
  const ContarVocalesScreen({super.key});

  @override
  State<ContarVocalesScreen> createState() => _ContarVocalesScreenState();
}

class _ContarVocalesScreenState extends State<ContarVocalesScreen> {
  final TextEditingController _phraseController = TextEditingController();
  String _result = '';

  @override
  void dispose() {
    _phraseController.dispose();
    super.dispose();
  }

  void _countVocals() {
    final String phrase = _phraseController.text.toLowerCase();
    if (phrase.isEmpty) {
      setState(() {
        _result = 'Por favor, ingresa una frase.';
      });
      return;
    }

    int count = 0;
    final List<String> vowels = [
      'a',
      'e',
      'i',
      'o',
      'u',
      'á',
      'é',
      'í',
      'ó',
      'ú',
    ];
    for (int i = 0; i < phrase.length; i++) {
      if (vowels.contains(phrase[i])) {
        count++;
      }
    }

    setState(() {
      _result = 'La frase tiene $count vocal(es).';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contar Vocales')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: _phraseController,
              labelText: 'Ingresa una frase',
            ),
            ElevatedButton(
              onPressed: _countVocals,
              child: const Text('Contar Vocales'),
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
