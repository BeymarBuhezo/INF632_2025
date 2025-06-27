import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _modoTema = ThemeMode.light;

  ThemeMode get modoTema => _modoTema;

  bool get esModoOscuro => _modoTema == ThemeMode.dark;

  void cambiarTema() {
    _modoTema = _modoTema == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  ThemeData get temaActual {
    if (_modoTema == ThemeMode.dark) {
      return ThemeData.dark().copyWith(
        primaryColor: Colors.deepPurple,
        hintColor: Colors.deepPurpleAccent,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.deepPurple),
      );
    } else {
      return ThemeData.light().copyWith(
        primaryColor: Colors.blue,
        hintColor: Colors.blueAccent,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.blue),
      );
    }
  }
}
