import 'package:authentication_app/feature/forget_password/domain/entities/forget_password_entity.dart';
import 'package:authentication_app/feature/forget_password/domain/repositories/forget_password_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'forget_password_use_case.g.dart';

@riverpod
ForgetPasswordUseCase forgetPasswordUseCase(ForgetPasswordUseCaseRef ref) {
  final forgetPasswordRepo = ref.read(forgetPasswordRepositoryProvider);
  return ForgetPasswordUseCase(forgetPasswordRepo: forgetPasswordRepo);
}

class ForgetPasswordUseCase {
  final ForgetPasswordRepository forgetPasswordRepo;

  ForgetPasswordUseCase({required this.forgetPasswordRepo});

  FutureOr<(ForgetPasswordEntity?, String?)> useCaseForgetPass({
    required String email,
  }) async {
    return await forgetPasswordRepo.forgetPassword(
      email: email,
    );
  }
}
