import '../datasources/device_token_remote_data_source.dart';
import '../models/device_token_model.dart';

class DeviceTokenRepository {
  final DeviceTokenRemoteDataSource remoteDataSource;

  DeviceTokenRepository(this.remoteDataSource);

  Future<void> registerToken(DeviceTokenModel token) async {
    await remoteDataSource.registerToken(token);
  }

  Future<List<DeviceTokenModel>> getTokens() async {
    return await remoteDataSource.getTokens();
  }
}
