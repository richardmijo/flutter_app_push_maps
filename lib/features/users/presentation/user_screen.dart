import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/user_model.dart';
import 'user_provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Gestión de Usuarios')),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                    validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await provider.createUser(
                          UserModel(
                            name: _nameController.text,
                            email: _emailController.text,
                          ),
                        );
                        _nameController.clear();
                        _emailController.clear();
                      }
                    },
                    child: const Text('Crear Usuario'),
                  )
                ],
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: provider.users.length,
              itemBuilder: (_, index) {
                final user = provider.users[index];
                return ListTile(
                  leading: CircleAvatar(child: Text(user.name[0])),
                  title: Text(user.name),
                  subtitle: Text(user.email),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
