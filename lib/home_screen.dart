import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _deviceToken = "Cargando token...";

  @override
  void initState() {
    super.initState();
    _initFirebaseMessaging();
  }

  void _initFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Solicitar permisos en iOS
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("Permisos de notificación concedidos.");
    } else {
      print("Permisos de notificación denegados.");
    }

    // Obtener token del dispositivo
    String? token = await messaging.getToken();
    setState(() {
      _deviceToken = token;
    });
    print("Token del dispositivo: $_deviceToken");

    // Manejo de mensajes cuando la app está en primer plano
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Notificación en primer plano: ${message.notification?.title}");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(message.notification?.title ?? "Sin título"),
          content: Text(message.notification?.body ?? "Sin contenido"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    });

    // Manejo cuando se toca una notificación con la app en background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notificación tocada: ${message.notification?.title}");
      // Aquí puedes navegar a otra pantalla si quieres
    });

    // Verificar si se abrió desde una notificación (app terminada)
    RemoteMessage? initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      print("App iniciada desde notificación: ${initialMessage.notification?.title}");
    }
  }

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
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Token del dispositivo:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SelectableText(_deviceToken ?? 'No disponible'),
          ),
        ],
      ),
    );
  }
}
