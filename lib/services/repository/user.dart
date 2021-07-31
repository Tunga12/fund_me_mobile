import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/services/data_provider/user.dart';

class UserRepository {
  UserDataProvider dataProvider;
  UserRepository({
    required this.dataProvider,
  });

  // get user information
  Future<User> getUser(String token, String password) async {
    return await dataProvider.getUser(token, password);
  }

  // update user
  Future<User> updateUser(User user, String token) async {
    return await dataProvider.updateUser(user, token);
  }

  // delete user
  Future<String> deleteuser(String token) async {
    return await dataProvider.deleteUser(token);
  }
}
