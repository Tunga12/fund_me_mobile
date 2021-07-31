import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/services/data_provider/auth.dart';

class AuthRepository {
  final AuthDataProvider dataProvider;
  AuthRepository({required this.dataProvider});

  Future<String> createUser(User user) async {
    return await dataProvider.createUser(user);
  }

  Future<String> signinUser(User user) async {
    return await dataProvider.signinUser(user);
  }
}
