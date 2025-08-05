import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../data/models/device_token_model.dart';
import '../data/repositories/device_token_repository.dart';

class DeviceTokenProvider with ChangeNotifier {
  final DeviceTokenRepository repository;
  List<DeviceTokenModel> tokens = [];
  String? currentToken;

  DeviceTokenProvider(this.repository);

  Future<void> loadTokens() async {
    tokens = await repository.getTokens();
    notifyListeners();
  }

  Future<void> fetchAndRegisterToken() async {
    final fcm = FirebaseMessaging.instance;
    final token = await fcm.getToken();
    if (token != null) {
      currentToken = token;
      await repository.registerToken(DeviceTokenModel(token: token, userId: 1));
      await loadTokens();
    }
  }
}
