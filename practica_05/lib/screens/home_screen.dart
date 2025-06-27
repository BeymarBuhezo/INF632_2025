import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Pantalla Principal')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hola, ${authProvider.nombreUsuario ?? 'Invitado'}!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Tema Oscuro'),
                Switch(
                  value: themeProvider.esModoOscuro,
                  onChanged: (value) {
                    themeProvider.cambiarTema();
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                authProvider.cerrarSesion();
              },
              child: const Text('Cerrar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
