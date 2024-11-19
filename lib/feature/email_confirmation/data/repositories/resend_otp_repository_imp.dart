import 'package:authentication_app/feature/email_confirmation/data/data_sources/remote_data_source.dart';
import 'package:authentication_app/feature/email_confirmation/data/models/resend_otp_model.dart';
import 'package:authentication_app/feature/email_confirmation/domain/repositories/resend_otp_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class ResendOtpRepositoryImp extends ResendOtpRepository {
  EmailConfirmationRemoteDataSource emailConfirmationRemoteDataSource;

  ResendOtpRepositoryImp(this.emailConfirmationRemoteDataSource);

  @override
  FutureOr<(ResendOtpModel?, String?)> resendOtp({required email}) async {
    return await EmailConfirmationRemoteDataSource.resendOtp(
      email: email,
    );
  }
}
