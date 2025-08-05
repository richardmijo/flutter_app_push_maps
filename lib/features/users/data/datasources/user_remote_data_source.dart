import '../../../../core/network/dio_client.dart';
import '../models/user_model.dart';

class UserRemoteDataSource {
  final DioClient dioClient;

  UserRemoteDataSource(this.dioClient);

  Future<void> createUser(UserModel user) async {
    await dioClient.instance.post('/users', data: user.toJson());
  }

  Future<List<UserModel>> getUsers() async {
    final response = await dioClient.instance.get('/users');
    return (response.data as List)
        .map((json) => UserModel.fromJson(json))
        .toList();
  }
}
