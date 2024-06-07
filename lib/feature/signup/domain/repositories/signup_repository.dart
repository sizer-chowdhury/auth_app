import 'package:authentication_app/feature/signup/data/repositories/signup_repository_imp.dart';
import 'package:authentication_app/feature/signup/domain/entities/signup_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'signup_repository.g.dart';

@riverpod
SignUpRepositoryImp signUpRepository(Ref ref) {
  return ref.read(signUpRepositoryImpProvider);
}

abstract class SignUpRepository {
  FutureOr<(SignUpEntity?, String?)> getUserSignUp({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
  });
}
