import 'package:flutter/material.dart';

class Keyboard extends StatelessWidget {
  final ValueChanged<String> onLetterPressed;
  final List<String> guessedLetters;
  final bool gameOver;

  const Keyboard({
    super.key,
    required this.onLetterPressed,
    required this.guessedLetters,
    required this.gameOver,
  });

  @override
  Widget build(BuildContext context) {
    const List<String> alphabet = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'Ñ',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z',
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7, // 7 letras por fila
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
        childAspectRatio: 1.0,
      ),
      itemCount: alphabet.length,
      itemBuilder: (context, index) {
        final String letter = alphabet[index];
        final bool isGuessed = guessedLetters.contains(letter);

        return GestureDetector(
          onTap: gameOver || isGuessed ? null : () => onLetterPressed(letter),
          child: Card(
            color: isGuessed ? Colors.grey[300] : Colors.blueAccent,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                letter,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isGuessed ? Colors.black54 : Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
