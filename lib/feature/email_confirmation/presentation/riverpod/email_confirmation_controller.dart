import 'package:authentication_app/feature/email_confirmation/domain/entities/email_confirmation_entity.dart';
import 'package:authentication_app/feature/email_confirmation/domain/use_cases/email_confirmation_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'email_confirmation_controller.g.dart';

@riverpod
class EmailConfirmationController extends _$EmailConfirmationController {
  @override
  FutureOr<(EmailConfirmationEntity?, String?)> build() {
    return (null, null);
  }

  void emailConfirmation({required email, required otp}) async {
    state = const AsyncData((null, null));
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await ref
          .read(emailConfirmationUseCaseProvider)
          .emailConfirmation(email: email, otp: otp);
    });
  }
}
