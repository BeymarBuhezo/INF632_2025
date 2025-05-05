import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  // Requisito 2: Pantalla de Detalle (“DetailPage”)
  final String nombreCategoria;

  const DetailPage({super.key, required this.nombreCategoria});

  // Requisito 2.2: Mostrar contenido informativo ficticio (“Text” largo simulado).
  String _obtenerContenido(String categoria) {
    switch (categoria) {
      case 'Reciclaje':
        return 'El reciclaje es el proceso de recolectar y procesar materiales que de otro modo se descartarían como basura y convertirlos en nuevos productos. El reciclaje puede beneficiar a su comunidad y al medio ambiente. Algunos consejos incluyen separar el papel, el plástico, el vidrio y los metales. ¡Cada acción cuenta!';
      case 'Ahorro de Agua':
        return 'El ahorro de agua es esencial para preservar este recurso vital. Pequeñas acciones como cerrar el grifo al cepillarse los dientes o reparar fugas pueden marcar una gran diferencia. Considera recolectar agua de lluvia para regar tus plantas y utiliza electrodomésticos eficientes en el consumo de agua.';
      case 'Energía Renovable':
        return 'La energía renovable proviene de fuentes naturales que se reponen constantemente, como la luz solar, el viento, la lluvia, las mareas y el calor geotérmico. Utilizar energías renovables ayuda a reducir la dependencia de los combustibles fósiles. ¡Explora opciones como paneles solares o apoya iniciativas de energía eólica!';
      default:
        return 'Contenido no disponible para esta categoría.';
    }
  }

  // Requisito 2.3: Mostrar imagen relacionada.
  String _obtenerImagen(String categoria) {
    switch (categoria) {
      case 'Reciclaje':
        return 'assets/images/reciclaje.png';
      case 'Ahorro de Agua':
        return 'assets/images/agua.png';
      case 'Energía Renovable':
        return 'assets/images/energia.png';
      default:
        return 'assets/images/default.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Requisito 2.1: Mostrar: Título de la categoría en “AppBar”.
    return Scaffold(
      appBar: AppBar(title: Text(nombreCategoria)),
      // Mostrar contenido e imagen
      body: SingleChildScrollView(
        // Requisito 3: Diseño Adicional - Usar “Padding” para espaciado alrededor del contenido.
        padding: const EdgeInsets.all(16.0),
        // Requisito 3: Diseño Adicional - Usar “Column” para organizar los elementos verticalmente.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Bonus: Usar “Hero” para animar la transición de imágenes entre pantallas.
            Hero(
              tag: nombreCategoria,
              child: Image.asset(
                _obtenerImagen(nombreCategoria),
                height: 450.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            //Diseño Adicional - Usar “SizedBox”
            const SizedBox(height: 20.0),
            Text(
              nombreCategoria,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            // Requisito 2.2: Mostrar contenido informativo ficticio.
            Text(
              _obtenerContenido(nombreCategoria),
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            // Requisito 2.4: Botón de regreso (“Navigator.pop”).
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                child: const Text('Regresar'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
