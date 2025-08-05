
import 'package:flutter_app_push_maps/core/network/dio_client.dart';

import '../models/device_token_model.dart';

class DeviceTokenRemoteDataSource {
  final DioClient dioClient;

  DeviceTokenRemoteDataSource(this.dioClient);

  Future<void> registerToken(DeviceTokenModel token) async {
    print(token);
    await dioClient.instance.post('/tokens', data: token.toJson());
  }

  Future<List<DeviceTokenModel>> getTokens() async {
    final response = await dioClient.instance.get('/tokens');
    return (response.data as List)
        .map((json) => DeviceTokenModel.fromJson(json))
        .toList();
  }


  Future<List<DeviceTokenModel>> getTokensByUser(String userId) async {
  final response = await dioClient.instance.get('/tokens/$userId');
  return (response.data as List)
        .map((json) => DeviceTokenModel.fromJson(json))
        .toList();
  // Resto del parseo...
}

}
