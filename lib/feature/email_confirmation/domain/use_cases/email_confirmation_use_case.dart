import 'package:authentication_app/feature/email_confirmation/data/repositories/email_confirmation_repository_imp.dart';
import 'package:authentication_app/feature/email_confirmation/domain/entities/email_confirmation_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'email_confirmation_use_case.g.dart';

@riverpod
EmailConfirmationUseCase emailConfirmationUseCase(
  EmailConfirmationUseCaseRef ref,
) {
  final emailConfirmationImp = ref.read(emailConfirmationRepositoryImpProvider);
  return EmailConfirmationUseCase(emailConfirmationImp: emailConfirmationImp);
}

class EmailConfirmationUseCase {
  final EmailConfirmationRepositoryImp emailConfirmationImp;

  EmailConfirmationUseCase({required this.emailConfirmationImp});

  FutureOr<(EmailConfirmationEntity?, String?)> emailConfirmation({
    required email,
    required otp,
  }) async {
    return await emailConfirmationImp.emailConfirmation(
      email: email,
      otp: otp,
    );
  }
}
