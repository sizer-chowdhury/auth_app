import 'package:authentication_app/feature/login/data/datasources/local_data_source.dart';
import 'package:authentication_app/feature/login/domain/entities/login_entity.dart';
import 'package:authentication_app/feature/login/domain/entities/sub_entities.dart';

class LoginModel extends LoginEntity {
  LoginModel({
    required super.message,
    required super.token,
    required super.user,
  }) {
    LoginLocalDataSource(key: 'token', value: token).setCacheData();
  }

  static LoginModel fromJson(Map<String, dynamic> json) {
    String message = json['message'];
    String token = json['token'];
    String firstName = json['user']['firstname'];
    String lastName = json['user']['lastname'];
    String email = json['user']['email'];
    User user = User(firstName: firstName, lastName: lastName, email: email);

    return LoginModel(message: message, token: token, user: user);
  }
}
