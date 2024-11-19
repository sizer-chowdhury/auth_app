import 'dart:convert';

import 'package:authentication_app/feature/forget_password/data/models/forget_password_model.dart';
import 'package:http/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'forget_password_remote_data_source.g.dart';

@riverpod
ForgetPasswordRemoteDataSource forgetPasswordRemoteDataSource(
  ForgetPasswordRemoteDataSourceRef ref,
) {
  return ForgetPasswordRemoteDataSource();
}

class ForgetPasswordRemoteDataSource {
  late Response response;

  FutureOr<(ForgetPasswordModel?, String?)> remoteDataForgetPassword({
    required String email,
  }) async {
    try {
      response = await post(
        Uri.parse('http://34.72.136.54:4067/api/v1/auth/forget-password'),
        body: {
          'email': email,
        },
      );
      if (response.statusCode == 201) {
        return (ForgetPasswordModel.fromJson(jsonDecode(response.body)), null);
      } else {
        return (null, jsonDecode(response.body)['message'].toString());
      }
    } catch (e) {
      return (null, e.toString());
    }
  }
}
