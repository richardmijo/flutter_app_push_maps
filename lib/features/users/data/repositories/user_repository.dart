import '../datasources/user_remote_data_source.dart';
import '../models/user_model.dart';

class UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepository(this.remoteDataSource);

  Future<void> createUser(UserModel user) => remoteDataSource.createUser(user);
  Future<List<UserModel>> getUsers() => remoteDataSource.getUsers();
}
