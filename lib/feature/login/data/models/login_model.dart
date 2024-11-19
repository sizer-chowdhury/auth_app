import 'package:authentication_app/feature/login/domain/entities/login_entity.dart';
import 'package:authentication_app/feature/login/domain/entities/user_entity.dart';

class LoginModel extends LoginEntity {
  LoginModel({
    required super.message,
    super.token,
    super.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    final String message = json['message'];
    final String token = json['token'];
    final String firstName = json['user']['firstname'];
    final String lastName = json['user']['lastname'];
    final String email = json['user']['email'];
    final String id = json['user']['_id'];
    final String role = json['user']['role'];

    User user = User(
      firstName: firstName,
      lastName: lastName,
      email: email,
      id: id,
      role: role,
    );

    return LoginModel(
      message: message,
      token: token,
      user: user,
    );
  }

  String? getToken() {
    return super.token;
  }
}
