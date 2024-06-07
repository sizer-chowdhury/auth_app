import 'package:authentication_app/feature/signup/domain/entities/signup_entity.dart';

class SignUpModel extends SignUpEntity {
  SignUpModel({
    required super.message,
  });

  static SignUpModel fromJson(Map<String, dynamic> json) {
    final String message = json['message'];

    return SignUpModel(
      message: message,
    );
  }
}
