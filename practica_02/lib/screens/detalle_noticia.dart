import 'package:flutter/material.dart';

class DetalleNoticiaArguments {
  final String titulo;
  final String imagen;
  final String detalle;

  DetalleNoticiaArguments({
    required this.titulo,
    required this.imagen,
    required this.detalle,
  });
}

class DetalleNoticiaScreen extends StatelessWidget {
  static const String routeName = '/detalle-noticia';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as DetalleNoticiaArguments?;

    return Scaffold(
      appBar: AppBar(title: Text(args?.titulo ?? 'Detalle de Noticia')),
      body:
          args != null
              ? SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (args.imagen.isNotEmpty)
                      SizedBox(
                        width: double.infinity,
                        child: Image.network(
                          args.imagen,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.image_not_supported,
                                size: 50.0,
                              ),
                            );
                          },
                        ),
                      ),
                    SizedBox(height: 16.0),
                    Text(
                      args.titulo,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(args.detalle, style: TextStyle(fontSize: 16.0)),
                  ],
                ),
              )
              : Center(
                child: Text('No se encontraron detalles para esta noticia.'),
              ),
    );
  }
}
