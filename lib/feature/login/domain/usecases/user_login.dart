
import 'package:authentication_app/feature/login/data/repositories/login_repository_imp.dart';
import 'package:authentication_app/feature/login/domain/entities/login_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_login.g.dart';

@riverpod
LoginUseCase loginUseCase(LoginUseCaseRef ref) {
  final loginImp = ref.read(loginRepostoryImpProvider);
  return LoginUseCase(loginImp: loginImp);
}

class LoginUseCase {
  final LoginRepositoryImp loginImp;

  LoginUseCase({required this.loginImp});

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