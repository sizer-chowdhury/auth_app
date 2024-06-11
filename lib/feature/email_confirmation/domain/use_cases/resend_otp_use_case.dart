import 'package:authentication_app/feature/email_confirmation/domain/entities/resend_otp_entity.dart';
import 'package:authentication_app/feature/email_confirmation/domain/repositories/resend_otp_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'resend_otp_use_case.g.dart';

@riverpod
ResendOtpUseCase resendOtpUseCase(Ref ref) {
  final resendOtpRepo = ref.read(resendOtpRepositoryProvider);
  return ResendOtpUseCase(resendOtpRepo: resendOtpRepo);
}

class ResendOtpUseCase {
  final ResendOtpRepository resendOtpRepo;

  ResendOtpUseCase({required this.resendOtpRepo});

  FutureOr<(ResendOtpEntity?, String?)> resendOtp({
    required email,
  }) async {
    return await resendOtpRepo.resendOtp(
      email: email,
    );
  }
}
