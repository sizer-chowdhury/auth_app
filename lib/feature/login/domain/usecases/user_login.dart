import 'dart:async';
import 'package:authentication_app/feature/login/data/repositories/login_repository_imp.dart';
import 'package:authentication_app/feature/login/domain/entities/login_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_login.g.dart';

@riverpod
LoginUsecase loginUsecase(LoginUsecaseRef ref) {
  // ignore: avoid_manual_providers_as_generated_provider_dependency
  final loginImp = ref.read(loginRepostoryImpProvider);
  return LoginUsecase(loginImp: loginImp);
}

class LoginUsecase {
  final LoginRepositoryImp loginImp;

  LoginUsecase({required this.loginImp});

  FutureOr<LoginEntity?> userLogin({
    required String email,
    required String password,
  }) async {
    return await loginImp.getUserLogin(
      email: email,
      password: password,
    );
  }
}