import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? _nombreUsuario;
  bool _estaAutenticado = false;

  String? get nombreUsuario => _nombreUsuario;
  bool get estaAutenticado => _estaAutenticado;

  void iniciarSesion(String nombre) {
    _nombreUsuario = nombre;
    _estaAutenticado = true;
    notifyListeners();
  }

  void cerrarSesion() {
    _nombreUsuario = null;
    _estaAutenticado = false;
    notifyListeners();
  }
}
