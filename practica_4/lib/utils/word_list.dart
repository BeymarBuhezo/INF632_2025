import 'dart:math';

class WordList {
  static final List<String> _words = [
    'PROGRAMACION',
    'FLUTTER',
    'DESARROLLO',
    'MOVIL',
  ];

  static String getRandomWord() {
    final _random = Random();
    return _words[_random.nextInt(_words.length)];
  }
}
