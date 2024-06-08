import 'package:authentication_app/feature/forget_password/domain/entities/forget_password_entity.dart';

class ForgetPasswordModel extends ForgetPasswordEntity {
  ForgetPasswordModel({
    required super.message,
  });

  static ForgetPasswordModel fromJson(Map<String, dynamic> json) {

    return ForgetPasswordModel(
      message: json['message'],
    );
  }
}
