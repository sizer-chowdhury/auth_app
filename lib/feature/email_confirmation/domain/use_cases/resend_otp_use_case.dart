import 'package:authentication_app/feature/email_confirmation/data/repositories/resend_otp_repository_imp.dart';
import 'package:authentication_app/feature/email_confirmation/domain/entities/resend_otp_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'resend_otp_use_case.g.dart';

@riverpod
ResendOtpUseCase resendOtpUseCase(Ref ref) {
  final resendOtpImp = ref.read(resendOtpRepositoryImpProvider);
  return ResendOtpUseCase(resendOtpImp: resendOtpImp);
}

class ResendOtpUseCase {
  final ResendOtpRepositoryImp resendOtpImp;

  ResendOtpUseCase({required this.resendOtpImp});

  FutureOr<(ResendOtpEntity?, String?)> resendOtp({
    required email,
  }) async {
    return await resendOtpImp.resendOtp(
      email: email,
    );
  }
}
