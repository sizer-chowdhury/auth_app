import 'dart:async';
import 'package:authentication_app/feature/login/domain/entities/login_entity.dart';
import 'package:authentication_app/feature/login/domain/repositories/loginn_repository.dart';

class LoginUseCase {
  final LoginRepository loginRepository;

  LoginUseCase(this.loginRepository);

  FutureOr<LoginEntity?> userLogin({
    required String email,
    required String password,
  }) async {
    return await loginRepository.getUserLogin(email: email, password: password);
  }
}
