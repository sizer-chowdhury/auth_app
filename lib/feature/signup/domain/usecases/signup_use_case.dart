import 'package:authentication_app/feature/signup/data/repositories/signup_repository_imp.dart';
import 'package:authentication_app/feature/signup/domain/entities/signup_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'signup_use_case.g.dart';

@riverpod
SignUpUseCase signUpUseCase(SignUpUseCaseRef ref) {
  final signUpImp = ref.read(signUpRepositoryImpProvider);
  return SignUpUseCase(signUpImp: signUpImp);
}

class SignUpUseCase {
  final SignUpRepositoryImp signUpImp;

  SignUpUseCase({required this.signUpImp});

  FutureOr<(SignUpEntity?, String?)> userSignUp({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
  }) async {
    return await signUpImp.getUserSignUp(
      firstname: firstname,
      lastname: lastname,
      email: email,
      password: password,
    );
  }
}
