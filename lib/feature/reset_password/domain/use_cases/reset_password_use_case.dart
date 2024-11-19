import 'package:authentication_app/feature/reset_password/domain/entities/reset_password_entity.dart';
import 'package:authentication_app/feature/reset_password/domain/repositories/reset_password_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reset_password_use_case.g.dart';

@riverpod
ResetPasswordUseCase resetPasswordUseCase(Ref ref) {
  final resetPasswordRepo = ref.read(resetPasswordRepositoryProvider);
  return ResetPasswordUseCase(resetPasswordRepo: resetPasswordRepo);
}

class ResetPasswordUseCase {
  final ResetPasswordRepository resetPasswordRepo;

  ResetPasswordUseCase({required this.resetPasswordRepo});

  FutureOr<(ResetPasswordEntity?, String?)> resetPassword({
    required email,
    required password,
    required confirmPassword,
  }) async {
    return await resetPasswordRepo.resetPassword(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}
