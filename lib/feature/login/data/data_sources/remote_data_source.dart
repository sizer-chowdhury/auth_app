import 'dart:convert';
import 'package:authentication_app/feature/login/data/models/login_model.dart';
import 'package:http/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_data_source.g.dart';

@riverpod
LoginRemoteDataSource loginRemoteDataSource(LoginRemoteDataSourceRef ref) {
  return LoginRemoteDataSource();
}

class LoginRemoteDataSource {
  late Response response;

  FutureOr<LoginModel?> signIn({required email, required password}) async {
    try {
      response = await post(
        Uri.parse('http://34.72.136.54:4067/api/v1/auth/login'),
        body: {
          'email': email,
          'password': password,
          'OS': 'IOS',
          'model': 'iPhone 15',
          'FCMToken': 'Token1',
        },
      );
      return LoginModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
}
