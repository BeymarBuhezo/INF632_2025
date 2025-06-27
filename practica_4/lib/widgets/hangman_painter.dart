import 'package:flutter/material.dart';

class HangmanPainter extends CustomPainter {
  final int incorrectGuesses;

  HangmanPainter(this.incorrectGuesses);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint =
        Paint()
          ..color = Colors.brown
          ..strokeWidth = 5.0
          ..strokeCap = StrokeCap.round;

    // Base
    canvas.drawLine(
      Offset(size.width * 0.1, size.height * 0.9),
      Offset(size.width * 0.9, size.height * 0.9),
      paint,
    );

    // Poste vertical
    canvas.drawLine(
      Offset(size.width * 0.2, size.height * 0.9),
      Offset(size.width * 0.2, size.height * 0.1),
      paint,
    );

    // Poste horizontal superior
    canvas.drawLine(
      Offset(size.width * 0.2, size.height * 0.1),
      Offset(size.width * 0.6, size.height * 0.1),
      paint,
    );

    // Cuerda
    canvas.drawLine(
      Offset(size.width * 0.6, size.height * 0.1),
      Offset(size.width * 0.6, size.height * 0.2),
      paint,
    );

    // Dibujar partes del ahorcado según los errores
    paint.color = Colors.black;
    paint.strokeWidth = 3.0;

    // Cabeza (1 error)
    if (incorrectGuesses >= 1) {
      canvas.drawCircle(
        Offset(size.width * 0.6, size.height * 0.25),
        25,
        paint,
      );
    }

    // Cuerpo (2 errores)
    if (incorrectGuesses >= 2) {
      canvas.drawLine(
        Offset(size.width * 0.6, size.height * 0.25 + 25),
        Offset(size.width * 0.6, size.height * 0.6),
        paint,
      );
    }

    // Brazo izquierdo (3 errores)
    if (incorrectGuesses >= 3) {
      canvas.drawLine(
        Offset(size.width * 0.6, size.height * 0.35),
        Offset(size.width * 0.45, size.height * 0.5),
        paint,
      );
    }

    // Brazo derecho (4 errores)
    if (incorrectGuesses >= 4) {
      canvas.drawLine(
        Offset(size.width * 0.6, size.height * 0.35),
        Offset(size.width * 0.75, size.height * 0.5),
        paint,
      );
    }

    // Pierna izquierda (5 errores)
    if (incorrectGuesses >= 5) {
      canvas.drawLine(
        Offset(size.width * 0.6, size.height * 0.6),
        Offset(size.width * 0.45, size.height * 0.75),
        paint,
      );
    }

    // Pierna derecha (6 errores)
    if (incorrectGuesses >= 6) {
      canvas.drawLine(
        Offset(size.width * 0.6, size.height * 0.6),
        Offset(size.width * 0.75, size.height * 0.75),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return (oldDelegate as HangmanPainter).incorrectGuesses != incorrectGuesses;
  }
}
