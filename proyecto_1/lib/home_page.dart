import 'package:flutter/material.dart';
import 'detail_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Map<String, String>> categorias = [
    {
      'titulo': 'Reciclaje',
      'imagen': 'assets/images/reciclaje.png',
      'descripcionCorta': 'Separa tus residuos en orgánicos e inorgánicos.',
    },
    {
      'titulo': 'Ahorro de Agua',
      'imagen': 'assets/images/agua.png',
      'descripcionCorta': 'Cierra el grifo mientras te lavas los dientes.',
    },
    {
      'titulo': 'Energía Renovable',
      'imagen': 'assets/images/energia.png',
      'descripcionCorta': 'Usa bombillas LED para ahorrar electricidad.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // 1: Pantalla Principal (“HomePage”)
    return Scaffold(
      //  AppBar: Título "EcoTips" + ícono de menú (no funcional).
      appBar: AppBar(
        title: const Text('EcoTips'),
        actions: [IconButton(icon: const Icon(Icons.menu), onPressed: () {})],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      // Bonus: Agregar un “Drawer” con un encabezado ficticio ("Menú").
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.red),
              child: Text(
                'Menú',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: const Text('Opción 1 (Ficticia)'),
              onTap: () {
                Navigator.pop(context); // Cierra el drawer
              },
            ),
            ListTile(
              title: const Text('Opción 2 (Ficticia)'),
              onTap: () {
                Navigator.pop(context); // Cierra el drawer
              },
            ),
          ],
        ),
      ),
      //Cuerpo: “ListView” con tarjetas (“Card”) que representen categorías.
      body: ListView.builder(
        itemCount: categorias.length,
        itemBuilder: (context, index) {
          final categoria = categorias[index];
          // Requisito 1: Tarjeta (“Card”) que representa cada categoría.
          return Card(
            margin: const EdgeInsets.all(10.0),
            // Diseño Adicional - Usar “Column”
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Diseño Adicional - Usar “Padding”
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  // Requisito 1.2.2: Título (“Text”).
                  child: Text(
                    categoria['titulo']!,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Bonus: Usar “Hero” para animar la transición de imágenes entre pantallas.
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Hero(
                    tag: categoria['titulo']!,
                    child: Image.asset(
                      categoria['imagen']!,
                      height: 100.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    categoria['descripcionCorta']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  // Botón "Ver más"
                  child: TextButton(
                    child: const Text('Ver más'),
                    onPressed: () {
                      // Navega a DetailPage al presionar "Ver más"
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => DetailPage(
                                nombreCategoria: categoria['titulo']!,
                              ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
