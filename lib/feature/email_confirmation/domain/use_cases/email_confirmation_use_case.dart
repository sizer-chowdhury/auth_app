import 'package:authentication_app/feature/email_confirmation/data/repositories/email_confirmation_repository_imp.dart';
import 'package:authentication_app/feature/email_confirmation/domain/entities/email_confirmation_entity.dart';
import 'package:authentication_app/feature/email_confirmation/domain/repositories/email_confirmation_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'email_confirmation_use_case.g.dart';

@riverpod
EmailConfirmationUseCase emailConfirmationUseCase(
  EmailConfirmationUseCaseRef ref,
) {
  final emailConfirmationRepo = ref.read(emailConfirmationRepositoryProvider);
  return EmailConfirmationUseCase(emailConfirmationRepo: emailConfirmationRepo);
}

class EmailConfirmationUseCase {
  final EmailConfirmationRepository emailConfirmationRepo;

  EmailConfirmationUseCase({required this.emailConfirmationRepo});

  FutureOr<(EmailConfirmationEntity?, String?)> emailConfirmation({
    required email,
    required otp,
  }) async {
    return await emailConfirmationRepo.emailConfirmation(
      email: email,
      otp: otp,
    );
  }
}
