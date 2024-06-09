import 'dart:async';
import 'package:authentication_app/feature/email_confirmation/domain/entities/resend_otp_entity.dart';

abstract class ResendOtpRepository {
  FutureOr<(ResendOtpEntity?, String?)> resendOtp({required email});
}
