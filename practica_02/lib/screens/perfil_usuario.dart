import 'package:flutter/material.dart';

class PerfilUsuarioScreen extends StatelessWidget {
  const PerfilUsuarioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.edit))],
        title: const Text('Perfil de Usuario'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('assets/images/usuario.png'),
              ),
              const SizedBox(height: 20),
              Column(
                children: const [
                  Text(
                    'Juan Perez',
                    style: TextStyle(fontSize: 32),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Estudiante de Desarrollo de Aplicaciones Moviles INF - 632. Practica Numero 2 trabajo realizado en clase',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.facebook),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.telegram),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.email)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
