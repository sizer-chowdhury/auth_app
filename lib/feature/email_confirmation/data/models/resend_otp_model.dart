import 'package:authentication_app/feature/email_confirmation/domain/entities/resend_otp_entity.dart';

class ResendOtpModel extends ResendOtpEntity {
  ResendOtpModel({required super.message});

  static ResendOtpModel fromJson(Map<String, dynamic> json) {

    return ResendOtpModel(
      message: json['message'],
    );
  }
}