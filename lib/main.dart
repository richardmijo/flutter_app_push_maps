import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_push_maps/features/device_tokens/data/datasources/device_token_remote_data_source.dart';
import 'package:flutter_app_push_maps/features/device_tokens/data/repositories/device_token_repository.dart';
import 'package:flutter_app_push_maps/features/device_tokens/presentation/device_token_provider.dart';
import 'package:flutter_app_push_maps/features/device_tokens/presentation/device_token_screen.dart';
import 'package:flutter_app_push_maps/home_screen.dart';
import 'package:provider/provider.dart';

import 'core/network/dio_client.dart';
import 'features/users/presentation/user_provider.dart';
import 'features/users/presentation/user_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dioClient = DioClient();
    // final userRepository = UserRepository(UserRemoteDataSource(dioClient));
    final deviceTokenRepository = DeviceTokenRepository(DeviceTokenRemoteDataSource(dioClient));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()..fetchUsers()),
        ChangeNotifierProvider(create: (_) => DeviceTokenProvider(deviceTokenRepository)..loadTokens()),
      ],
      child: MaterialApp(
        title: 'Flutter App',
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/users': (context) => const UserScreen(),
          '/tokens': (context) => const DeviceTokenScreen(),
        },
      ),
    );
  }
}
