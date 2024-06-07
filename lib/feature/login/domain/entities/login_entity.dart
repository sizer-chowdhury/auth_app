import 'package:authentication_app/feature/login/domain/entities/user_entity.dart';

class LoginEntity {
  String message;
  String? token;
  User? user;

  LoginEntity({
    required this.message,
    this.token,
    this.user,
  });
}
