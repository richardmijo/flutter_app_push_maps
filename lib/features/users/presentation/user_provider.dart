import 'package:flutter/material.dart';
import '../../../core/network/dio_client.dart';
import '../../users/data/models/user_model.dart';
import '../../users/data/datasources/user_remote_data_source.dart';
import '../../users/data/repositories/user_repository.dart';

class UserProvider extends ChangeNotifier {
  late final UserRepository _repository;

  List<UserModel> _users = [];
  List<UserModel> get users => _users;

  UserProvider() {
    final dioClient = DioClient();
    final dataSource = UserRemoteDataSource(dioClient);
    _repository = UserRepository(dataSource);
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    _users = await _repository.getUsers();
    notifyListeners();
  }

  Future<void> createUser(UserModel user) async {
    await _repository.createUser(user);
    await fetchUsers();
  }
}
