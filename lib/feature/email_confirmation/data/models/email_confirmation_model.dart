import 'package:authentication_app/feature/email_confirmation/domain/entities/email_confirmation_entity.dart';

class EmailConfirmationModel extends EmailConfirmationEntity {
  EmailConfirmationModel({required super.message});

  factory EmailConfirmationModel.fromJson(Map<String, dynamic> json) {
    return EmailConfirmationModel(
      message: json['message'],
    );
  }
}
