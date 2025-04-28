import 'package:flutter/material.dart';

class GaleriaProductosScreen extends StatelessWidget {
  final List<Map<String, dynamic>> productos = [
    {
      'nombre': 'Camiseta',
      'precio': 20,
      'imagen': 'assets/images/camiseta.png',
    },
    {'nombre': 'Zapatos', 'precio': 50, 'imagen': 'assets/images/zapatos.png'},
    // Más productos aquí
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Galería de Productos')),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: GridView.builder(
          itemCount: productos.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final producto = productos[index];
            return GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Producto: ${producto['nombre']}')),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                ),
                child: Column(
                  children: [
                    // Versión con CircleAvatar
                    Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 8),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(producto['imagen']),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      producto['nombre'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('\$${producto['precio']}'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
