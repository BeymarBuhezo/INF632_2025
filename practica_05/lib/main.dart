import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart'; // <--- VERIFICA ESTA RUTA CAREFULLY (desde la raíz de lib)
import 'providers/theme_provider.dart'; // <--- VERIFICA ESTA RUTA CAREFULLY (desde la raíz de lib)
import 'screens/login_screen.dart'; // <--- VERIFICA ESTA RUTA CAREFULLY (desde la raíz de lib)
import 'screens/home_screen.dart'; // <--- VERIFICA ESTA RUTA CAREFULLY (desde la raíz de lib)

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'App con Provider',
      theme: themeProvider.temaActual, // Aplicar el tema dinámicamente
      home: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (authProvider.estaAutenticado) {
            return const HomeScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
