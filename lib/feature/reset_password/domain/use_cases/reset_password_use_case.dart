import 'package:authentication_app/feature/reset_password/data/repositories/reset_password_repository_imp.dart';
import 'package:authentication_app/feature/reset_password/domain/entities/reset_password_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reset_password_use_case.g.dart';

@riverpod
ResetPasswordUseCase resetPasswordUseCase(Ref ref) {
  final resetPasswordImp = ref.read(resetPasswordRepositoryImpProvider);
  return ResetPasswordUseCase(resetPasswordImp: resetPasswordImp);
}

class ResetPasswordUseCase {
  final ResetPasswordRepositoryImp resetPasswordImp;

  ResetPasswordUseCase({required this.resetPasswordImp});

  FutureOr<(ResetPasswordEntity?, String?)> resetPassword({
    required email,
    required password,
    required confirmPassword,
  }) async {
    return await resetPasswordImp.resetPassword(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}
