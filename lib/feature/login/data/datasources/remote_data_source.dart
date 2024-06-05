import 'dart:async';
import 'dart:convert';
import 'package:authentication_app/feature/login/data/models/login_model.dart';
import 'package:http/http.dart';

class LoginRemoteDataSource {
  Future<LoginModel?> signIn({required email, required password}) async {
    try {
      Response response = await post(
        Uri.parse('http://34.72.136.54:4067/api/v1/auth/login'),
        body: {
          'email': email,
          'password': password,
          'OS': 'IOS',
          'model': 'iPhone 15',
          'FCMToken': 'Token1',
        },
      );

      if (response.statusCode != 201) {
        throw Exception('Something went wrong');
      } else {
        return LoginModel.fromJson(jsonDecode(response.body));
      }
    } catch (error) {
      throw Exception('error');
    }
  }
}
