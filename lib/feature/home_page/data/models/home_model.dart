import 'package:authentication_app/feature/home_page/domain/entities/home_entity.dart';

class HomeModel extends HomeEntity {
  HomeModel({
    required super.firstName,
    required super.message,
    required super.lastName,
    required super.email,
  });

  static (HomeModel?, String?) fromJson(Map<String, dynamic> json) {
    final String message = json['message'];
    final String firstName = json['data']['firstname'];
    final String lastName = json['data']['lastname'];
    final String email = json['data']['email'];
    final String id = json['data']['_id'];
    final String role = json['data']['role'];
    final bool isResetPassVerified = json['data']['isResetPassVerified'];
    final bool isVerified = json['data']['isVerified'];
    final String? avatar = json['data']['avatar'];

    return (
      HomeModel(
        firstName: firstName,
        lastName: lastName,
        email: email,
        message: message,
      ),
      null
    );
  }
}
