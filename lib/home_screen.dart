import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Gestión de Usuarios'),
            onTap: () => Navigator.pushNamed(context, '/users'),
          ),
          ListTile(
            leading: const Icon(Icons.vpn_key),
            title: const Text('Registro de Tokens'),
            onTap: () => Navigator.pushNamed(context, '/tokens'),
          ),
        ],
      ),
    );
  }
}
