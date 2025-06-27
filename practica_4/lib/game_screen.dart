import 'package:flutter/material.dart';
import 'package:practica_4/utils/word_list.dart';
import 'package:practica_4/widgets/hangman_painter.dart';
import 'dart:math';

import 'package:practica_4/widgets/keyboard.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late String _currentWord;
  late List<String> _hiddenWord;
  late List<String> _guessedLetters;
  int _incorrectGuesses = 0;
  final int _maxIncorrectGuesses =
      6; // Número máximo de errores antes de perder
  bool _gameOver = false;
  bool _gameWon = false;

  @override
  void initState() {
    super.initState();
    _startNewGame();
  }

  void _startNewGame() {
    setState(() {
      _currentWord = WordList.getRandomWord().toUpperCase();
      _hiddenWord = List.filled(_currentWord.length, '_');
      _guessedLetters = [];
      _incorrectGuesses = 0;
      _gameOver = false;
      _gameWon = false;
    });
  }

  void _handleGuess(String letter) {
    if (_gameOver) return;

    if (_guessedLetters.contains(letter)) {
      // La letra ya fue adivinada
      return;
    }

    setState(() {
      _guessedLetters.add(letter);

      bool found = false;
      for (int i = 0; i < _currentWord.length; i++) {
        if (_currentWord[i] == letter) {
          _hiddenWord[i] = letter;
          found = true;
        }
      }

      if (!found) {
        _incorrectGuesses++;
      }

      _checkGameStatus();
    });
  }

  void _checkGameStatus() {
    if (_incorrectGuesses >= _maxIncorrectGuesses) {
      _gameOver = true;
      _gameWon = false;
      _showResultDialog(false);
    } else if (!_hiddenWord.contains('_')) {
      _gameOver = true;
      _gameWon = true;
      _showResultDialog(true);
    }
  }

  void _showResultDialog(bool won) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(won ? '¡Felicidades, Ganaste!' : '¡Lo siento, Perdiste!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                won
                    ? 'Has adivinado la palabra correctamente.'
                    : 'La palabra era: $_currentWord',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Icon(
                won ? Icons.emoji_events : Icons.sentiment_very_dissatisfied,
                size: 60,
                color: won ? Colors.amber : Colors.red,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _startNewGame();
              },
              child: const Text('Jugar de Nuevo'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('El Ahorcado'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: CustomPaint(painter: HangmanPainter(_incorrectGuesses)),
            ),
            const SizedBox(height: 30),
            Text(
              _hiddenWord.join(' '),
              style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                letterSpacing: 8,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Text(
              'Errores: $_incorrectGuesses / $_maxIncorrectGuesses',
              style: TextStyle(
                fontSize: 20,
                color:
                    _incorrectGuesses >= _maxIncorrectGuesses
                        ? Colors.red
                        : Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Keyboard(
              onLetterPressed: _handleGuess,
              guessedLetters: _guessedLetters,
              gameOver: _gameOver,
            ),
          ],
        ),
      ),
    );
  }
}
