import 'package:authentication_app/feature/signup/domain/entities/signup_entity.dart';
import 'package:authentication_app/feature/signup/domain/use_cases/signup_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'signup_controller.g.dart';

@riverpod
class Signup extends _$Signup {
  @override
  FutureOr<(SignUpEntity?, String?)> build() {
    return (null, null);
  }

  void signUp({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
  }) async {
    state = const AsyncData((null, null));
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await ref.read(signUpUseCaseProvider).userSignUp(
            firstname: firstname,
            lastname: lastname,
            email: email,
            password: password,
          );
    });
  }
}
