import 'dart:convert';
import 'package:authentication_app/feature/signup/data/models/signup_model.dart';
import 'package:http/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'signup_remote_data_source.g.dart';

@riverpod
SignUpRemoteDataSource signUpRemoteDataSource(SignUpRemoteDataSourceRef ref) {
  return SignUpRemoteDataSource();
}

class SignUpRemoteDataSource {
  late Response response;

  FutureOr<(SignUpModel?, String?)> signUp({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
  }) async {
    try {
      response = await post(
        Uri.parse('http://34.72.136.54:4067/api/v1/auth/signUp'),
        body: {
          'firstname': firstname,
          'lastname': lastname,
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 201) {
        return (SignUpModel.fromJson(jsonDecode(response.body)), null);
      } else {
        return (null, jsonDecode(response.body)['message'].toString());
      }
    } catch (e) {
      return (null, e.toString());
    }
  }
}
