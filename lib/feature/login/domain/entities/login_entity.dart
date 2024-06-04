import 'package:authentication_app/feature/login/domain/entities/sub_entities.dart';

class LoginEntity {
  String message, token;
  User user;

  LoginEntity({required this.message, required this.token, required this.user});
}
