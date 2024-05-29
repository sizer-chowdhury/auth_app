
import 'dart:async';

import 'package:http/http.dart';

class LoginRepository {
  FutureOr<bool?> logIn(String email, String password) async{
    final response = await post(
      Uri.parse('http://34.72.136.54:4067/api/v1/auth/login'),
      body: {
        'email': email,
        'password': password,
        'OS': 'IOS',
        'model': 'iPhone 15',
        'FCMToken': 'Token1',
      },
    );
    if(response.statusCode != 201) {
      throw Exception('Something went wrong');
    } else {
      return true;
    }
  }
}