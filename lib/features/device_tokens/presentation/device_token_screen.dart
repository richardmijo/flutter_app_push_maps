import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'device_token_provider.dart';

class DeviceTokenScreen extends StatelessWidget {
  const DeviceTokenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DeviceTokenProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Tokens del Dispositivo')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => provider.fetchAndRegisterToken(),
            child: const Text('Registrar Token del Dispositivo'),
          ),
          const SizedBox(height: 10),
          const Text('Tokens Registrados:', style: TextStyle(fontSize: 18)),
          Expanded(
            child: ListView.builder(
              itemCount: provider.tokens.length,
              itemBuilder: (context, index) {
                final token = provider.tokens[index];
                return ListTile(
                  leading: const Icon(Icons.vpn_key),
                  title: Text('ID: ${token.id ?? "-"}'),
                  subtitle: Text(token.token),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
