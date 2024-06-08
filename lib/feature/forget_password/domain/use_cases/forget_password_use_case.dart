import 'package:authentication_app/feature/forget_password/data/repositories/forget_password_repository_imp.dart';
import 'package:authentication_app/feature/forget_password/domain/entities/forget_password_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'forget_password_use_case.g.dart';

@riverpod
ForgetPasswordUseCase forgetPasswordUseCase(ForgetPasswordUseCaseRef ref) {
  final forgetPasswordImp = ref.read(forgetPasswordRepositoryImpProvider);
  return ForgetPasswordUseCase(forgetPasswordImp: forgetPasswordImp);
}

class ForgetPasswordUseCase {
  final ForgetPasswordRepositoryImp forgetPasswordImp;

  ForgetPasswordUseCase({required this.forgetPasswordImp});

  FutureOr<(ForgetPasswordEntity?, String?)> useCaseForgetPass({
    required String email,
  }) async {
    return await forgetPasswordImp.forgetPassword(
      email: email,
    );
  }
}
