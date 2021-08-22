import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceData<T> {
  T data;
  bool status;
  PreferenceData({
    required this.data,
    required this.status,
  });
}

class UserPreference {
  Future<void> storeUserInformation(User user) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    await _sharedPreferences.setString('id', user.id!);
    await _sharedPreferences.setString('firstName', user.firstName!);
    await _sharedPreferences.setString('lastName', user.lastName!);
    await _sharedPreferences.setString('email', user.email!);
    await _sharedPreferences.setString('password', user.password!);
    await _sharedPreferences.setString('paymentMethods', user.paymentMethods!);
    await _sharedPreferences.setBool(
        'emailNotification', user.emailNotification!);
    await _sharedPreferences.setBool('isDeactivated', user.isDeactivated!);
    await _sharedPreferences.setBool('isAdmin', user.isAdmin!);
  }

  Future<PreferenceData> getUserInfromation() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    try {
      User user = User(
          firstName: _sharedPreferences.getString("firstName")!,
          lastName: _sharedPreferences.getString('lastName')!,
          email: _sharedPreferences.getString('email')!,
          password: _sharedPreferences.getString('password'),
          emailNotification: _sharedPreferences.getBool('emailNotification')!,
          isAdmin: _sharedPreferences.getBool('isAdmin'),
          isDeactivated: _sharedPreferences.getBool('isDeactivated')!,
          paymentMethods: _sharedPreferences.getString('paymentMethods')!,
          id: _sharedPreferences.getString('id'));
      return PreferenceData(data: user, status: true);
    } catch (e) {
      return PreferenceData(data: null, status: false);
    }
  }

  Future<void> storeToken(String token) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    await _sharedPreferences.setString('token', token);
    
  }

  Future<PreferenceData> getUserToken() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    try {
      String token = _sharedPreferences.getString('token')!;
      return PreferenceData(data: token, status: true);
    } catch (e) {
      return PreferenceData(data: null, status: false);
    }
  }

  Future<void> removeToken() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    _sharedPreferences.remove('token');
  }

  Future<void> removeUser() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    _sharedPreferences.clear();
  }
}
