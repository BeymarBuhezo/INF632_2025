import 'package:flutter/material.dart';
import 'screens/perfil_usuario.dart';
import 'screens/menu_restaurante.dart';
import 'screens/inicio_sesion.dart';
import 'screens/galeria_productos.dart';
import 'screens/noticias_home.dart';
import 'screens/detalle_noticia.dart';

void main() => runApp(MiApp());

class MiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicios Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeToolbar(),
        '/perfil': (context) => PerfilUsuarioScreen(),
        '/menu': (context) => MenuRestauranteScreen(),
        '/login': (context) => InicioSesionScreen(),
        '/galeria': (context) => GaleriaProductosScreen(),
        '/noticias': (context) => NoticiasHomeScreen(),
        '/detalle-noticia': (context) => DetalleNoticiaScreen(),
      },
    );
  }
}

class HomeToolbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Barra de Herramientas')),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Tarjeta de Perfil de Usuario'),
            onTap: () => Navigator.pushNamed(context, '/perfil'),
          ),
          ListTile(
            leading: Icon(Icons.restaurant_menu),
            title: Text('Menú de Restaurante'),
            onTap: () => Navigator.pushNamed(context, '/menu'),
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Pantalla de Inicio de Sesión'),
            onTap: () => Navigator.pushNamed(context, '/login'),
          ),
          ListTile(
            leading: Icon(Icons.grid_on),
            title: Text('Galería de Productos'),
            onTap: () => Navigator.pushNamed(context, '/galeria'),
          ),
          ListTile(
            leading: Icon(Icons.article),
            title: Text('App de Noticias'),
            onTap: () => Navigator.pushNamed(context, '/noticias'),
          ),
        ],
      ),
    );
  }
}
