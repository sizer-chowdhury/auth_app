import 'dart:async';

import 'package:authentication_app/feature/reset_password/domain/entities/reset_password_entity.dart';

abstract class ResetPasswordRepository {
  FutureOr<(ResetPasswordEntity?, String?)> resetPassword({
    required email,
    required password,
    required confirmPassword,
  });
}
