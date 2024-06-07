import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginLocalDataSource {
  final String key, value;

  LoginLocalDataSource({required this.key, required this.value});

  void setCacheData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(key, value);
    } catch (e) {
      throw Exception('something went wrong');
    }
  }

  FutureOr<String?> getCacheData({required String key}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(key);
    } catch (e) {
      throw Exception('something went wrong');
    }
  }
}