import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class LoginLocalDataSource {
  String key, value;

  LoginLocalDataSource({required this.key, required this.value});

  void setCacheData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
  }

  FutureOr<String?> getCacheData({required String key}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key);
  }
}
