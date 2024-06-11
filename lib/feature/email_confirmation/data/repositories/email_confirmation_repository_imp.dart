import 'package:authentication_app/feature/email_confirmation/data/data_sources/remote_data_source.dart';
import 'package:authentication_app/feature/email_confirmation/data/models/email_confirmation_model.dart';
import 'package:authentication_app/feature/email_confirmation/domain/repositories/email_confirmation_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class EmailConfirmationRepositoryImp implements EmailConfirmationRepository {
  EmailConfirmationRemoteDataSource emailConfirmationRemoteDataSource;

  EmailConfirmationRepositoryImp(this.emailConfirmationRemoteDataSource);

  @override
  FutureOr<(EmailConfirmationModel?, String?)> emailConfirmation({
    required email,
    required otp,
  }) async {
    return await EmailConfirmationRemoteDataSource.emailConfirmation(
      email: email,
      otp: otp,
    );
  }
}
