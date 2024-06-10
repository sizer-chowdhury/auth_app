import 'package:authentication_app/feature/home_page/domain/entities/logout_entity.dart';

class LogoutModel extends LogoutEntity {
  LogoutModel({required super.message});

  static (LogoutModel?, String?) fromJson(Map<String, dynamic> json) {
    final String message = json['message'];

    return (
      LogoutModel(
        message: message,
      ),
      null
    );
  }
}
