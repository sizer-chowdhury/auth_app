import 'dart:async';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutRepository {
  static FutureOr<bool?> getInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Response response = await post(
      Uri.parse('http://34.72.136.54:4067/api/v1/auth/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode != 201) {
      throw Exception('Something went wrong');
    } else {
      prefs.clear();
      return true;
    }
  }
}
