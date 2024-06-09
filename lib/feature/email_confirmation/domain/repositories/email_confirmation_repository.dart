import 'dart:async';
import 'package:authentication_app/feature/email_confirmation/domain/entities/email_confirmation_entity.dart';

abstract class EmailConfirmationRepository {
  FutureOr<(EmailConfirmationEntity?, String?)> emailConfirmation({
    required email,
    required otp,
  });
}
