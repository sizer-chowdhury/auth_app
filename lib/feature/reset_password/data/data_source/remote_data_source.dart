import 'dart:convert';
import 'package:authentication_app/feature/reset_password/data/models/reset_password_model.dart';
import 'package:http/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_data_source.g.dart';

@riverpod
ResetPasswordRemoteDataSource resetPasswordRemoteDataSource(
  ResetPasswordRemoteDataSourceRef ref,
) {
  return ResetPasswordRemoteDataSource();
}

class ResetPasswordRemoteDataSource {
  static FutureOr<(ResetPasswordModel?, String?)> resetPassword({
    required email,
    required password,
    required confirmPassword,
  }) async {
    try {
      Response response = await post(
        Uri.parse('http://34.72.136.54:4067/api/v1/auth/set-new-password'),
        body: {
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
        },
      );

      if (response.statusCode == 201) {
        return (ResetPasswordModel.fromJson(jsonDecode(response.body)), null);
      } else {
        return (null, jsonDecode(response.body)['message'].toString());
      }
    } catch (e) {
      return (null, e.toString());
    }
  }
}
