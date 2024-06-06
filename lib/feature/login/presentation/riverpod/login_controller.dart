import 'package:authentication_app/feature/login/domain/entities/login_entity.dart';
import 'package:authentication_app/feature/login/domain/usecases/user_login.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_controller.g.dart';

@riverpod
class SignIn extends _$SignIn {
  @override
  FutureOr<LoginEntity?> build() {
    return null;
  }

  void signIn({required String email, required String password}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await ref.read(loginUsecaseProvider).userLogin(
        email: email,
        password: password,
      );
    });
  }
}