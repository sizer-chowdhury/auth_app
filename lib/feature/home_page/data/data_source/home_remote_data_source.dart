import 'dart:async';
import 'dart:convert';
import 'package:authentication_app/feature/home_page/data/models/home_model.dart';
import 'package:authentication_app/feature/home_page/data/models/logout_model.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRemoteDataSource {
  static FutureOr<(HomeModel?, String?)> getProfileInfo() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      Response response = await get(
        Uri.parse('http://34.72.136.54:4067/api/v1/auth/me'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return HomeModel.fromJson(jsonDecode(response.body));
      } else {
        return (null, jsonDecode(response.body)['message'].toString());
      }
    } catch (e) {
      return (null, e.toString());
    }
  }

  static FutureOr<(LogoutModel?, String?)> signOut() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      Response response = await post(
        Uri.parse('http://34.72.136.54:4067/api/v1/auth/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 201) {
        return LogoutModel.fromJson(jsonDecode(response.body));
      } else {
        prefs.clear();
        return (null, jsonDecode(response.body)['message'].toString());
      }
    } catch (e) {
      return (null, e.toString());
    }
  }
}
