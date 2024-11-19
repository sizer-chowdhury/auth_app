import 'package:authentication_app/feature/forget_password/domain/entities/forget_password_entity.dart';
import 'package:authentication_app/feature/forget_password/domain/use_cases/forget_password_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'forget_password_controller.g.dart';

@riverpod
class ForgetPassword extends _$ForgetPassword {
  @override
  FutureOr<(ForgetPasswordEntity?, String?)> build() {
    return (null, null);
  }

  void otpConfirmation({
    required String email,
  }) async {
    state = const AsyncData((null, null));
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await ref.read(forgetPasswordUseCaseProvider).useCaseForgetPass(
            email: email,
          );
    });
  }
}
