import 'package:flutter/material.dart';

class MenuRestauranteScreen extends StatelessWidget {
  final List<Map<String, dynamic>> platillos = [
    {
      'nombre': 'Ensalada',
      'precio': 8.5,
      'imagen': 'assets/images/ensalada.png',
      'valoracion': 4,
    },
    {
      'nombre': 'Hamburguesa',
      'precio': 12.0,
      'imagen': 'assets/images/hamburguesa.png',
      'valoracion': 5,
    },
    // Agrega más platillos aquí
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú de Restaurante'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      endDrawer: Drawer(
        // Cambiado de drawer a endDrawer
        child: ListView(
          children: [
            DrawerHeader(child: Text('Categorías')),
            ListTile(title: Text('Entradas'), onTap: () {}),
            ListTile(title: Text('Platos Fuertes'), onTap: () {}),
            ListTile(title: Text('Postres'), onTap: () {}),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: platillos.length,
        itemBuilder: (context, index) {
          final platillo = platillos[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(platillo['imagen']),
                radius: 25,
              ),
              title: Text(platillo['nombre']),
              subtitle: Row(
                children: List.generate(
                  5,
                  (i) => Icon(
                    Icons.star,
                    color:
                        i < platillo['valoracion'] ? Colors.amber : Colors.grey,
                    size: 16,
                  ),
                ),
              ),
              trailing: Text('\$${platillo['precio']}'),
            ),
          );
        },
      ),
      floatingActionButton: null, // Eliminamos el FAB anterior
    );
  }
}
