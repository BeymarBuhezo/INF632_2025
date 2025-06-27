import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controladorUsuario = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar Sesión')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _controladorUsuario,
                decoration: const InputDecoration(
                  labelText: 'Nombre de usuario',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_controladorUsuario.text.isNotEmpty) {
                    Provider.of<AuthProvider>(
                      context,
                      listen: false,
                    ).iniciarSesion(_controladorUsuario.text);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Por favor, ingresa un nombre de usuario.',
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Iniciar Sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controladorUsuario.dispose();
    super.dispose();
  }
}
