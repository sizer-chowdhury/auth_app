import 'dart:convert';
import 'package:authentication_app/feature/email_confirmation/data/models/email_confirmation_model.dart';
import 'package:authentication_app/feature/email_confirmation/data/models/resend_otp_model.dart';
import 'package:http/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_data_source.g.dart';

@riverpod
EmailConfirmationRemoteDataSource emailConfirmationRemoteDataSource(
  EmailConfirmationRemoteDataSourceRef ref,
) {
  return EmailConfirmationRemoteDataSource();
}

class EmailConfirmationRemoteDataSource {
  static FutureOr<(EmailConfirmationModel?, String?)> emailConfirmation({
    required email,
    required otp,
  }) async {
    try {
      Response response = await post(
        Uri.parse('http://34.72.136.54:4067/api/v1/auth/verifyOtp'),
        body: {
          "email": email,
          "otp": otp,
        },
      );
      if (response.statusCode == 201) {
        return (
          EmailConfirmationModel.fromJson(jsonDecode(response.body)),
          null
        );
      } else {
        return (null, jsonDecode(response.body)['message'].toString());
      }
    } catch (e) {
      return (null, e.toString());
    }
  }

  static FutureOr<(ResendOtpModel?, String?)> resendOtp({
    required email,
  }) async {
    try {
      Response response = await post(
        Uri.parse('http://34.72.136.54:4067/api/v1/auth/resend-otp'),
        body: {
          "email": email,
        },
      );
      if (response.statusCode == 201) {
        return (ResendOtpModel.fromJson(jsonDecode(response.body)), null);
      } else {
        return (null, jsonDecode(response.body)['message'].toString());
      }
    } catch (e) {
      return (null, e.toString());
    }
  }
}
