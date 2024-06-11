import 'package:authentication_app/feature/email_confirmation/data/data_sources/remote_data_source.dart';
import 'package:authentication_app/feature/email_confirmation/data/repositories/resend_otp_repository_imp.dart';
import 'package:authentication_app/feature/email_confirmation/domain/entities/resend_otp_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'resend_otp_repository.g.dart';

@riverpod
ResendOtpRepository resendOtpRepository(
  ResendOtpRepositoryRef ref,
) {
  final remoteDatasource = ref.read(emailConfirmationRemoteDataSourceProvider);
  return ResendOtpRepositoryImp(remoteDatasource);
}

abstract class ResendOtpRepository {
  FutureOr<(ResendOtpEntity?, String?)> resendOtp({required email});
}
