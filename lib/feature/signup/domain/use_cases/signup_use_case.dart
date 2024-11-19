import 'package:authentication_app/feature/signup/domain/entities/signup_entity.dart';
import 'package:authentication_app/feature/signup/domain/repositories/signup_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'signup_use_case.g.dart';

@riverpod
SignUpUseCase signUpUseCase(SignUpUseCaseRef ref) {
  final signUpRepo = ref.read(signUpRepositoryProvider);
  return SignUpUseCase(signUpRepo: signUpRepo);
}

class SignUpUseCase {
  final SignUpRepository signUpRepo;

  SignUpUseCase({required this.signUpRepo});

  FutureOr<(SignUpEntity?, String?)> userSignUp({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
  }) async {
    return await signUpRepo.userSignUp(
      firstname: firstname,
      lastname: lastname,
      email: email,
      password: password,
    );
  }
}
