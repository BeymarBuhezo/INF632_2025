import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Practica 1')),
        body: const Practica1(),
      ),
    );
  }
}

class Practica1 extends StatelessWidget {
  const Practica1({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      // Número de columnas en la cuadrícula
      crossAxisCount: 3, // Cambiado a 2 para tener 2 columnas
      // Espacio entre los elementos verticalmente
      crossAxisSpacing: 10,
      // Espacio entre los elementos horizontalmente
      mainAxisSpacing: 10,
      // Espacio entre los bordes de la pantalla y el grid
      padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
      // Tamaño de los elementos
      childAspectRatio: 1.0,
      // Lista de widgets que se mostrarán en el grid
      children: [
        Image.network('https://picsum.photos/200/200?random=1'),
        Image.network('https://picsum.photos/200/200?random=2'),
        Image.network('https://picsum.photos/200/200?random=3'),
        Image.network('https://picsum.photos/200/200?random=4'),
        Image.network('https://picsum.photos/200/200?random=5'),
        Image.network('https://picsum.photos/200/200?random=6'),
      ],
    );
  }
}
