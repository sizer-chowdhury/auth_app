import 'dart:async';
import 'package:authentication_app/feature/login/domain/entities/login_entity.dart';

abstract class LoginRepository {
  FutureOr<LoginEntity?> getUserLogin({
    required String email,
    required String password,
  });
}
