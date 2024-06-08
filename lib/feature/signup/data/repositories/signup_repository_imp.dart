import 'package:authentication_app/feature/signup/data/data_sources/signup_remote_data_source.dart';
import 'package:authentication_app/feature/signup/data/models/signup_model.dart';
import 'package:authentication_app/feature/signup/domain/repositories/signup_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'signup_repository_imp.g.dart';

@riverpod
SignUpRepositoryImp signUpRepositoryImp(Ref ref) {
  final remoteDatasource = ref.read(signUpRemoteDataSourceProvider);
  return SignUpRepositoryImp(remoteDatasource);
}

class SignUpRepositoryImp implements SignUpRepository {
  SignUpRemoteDataSource signUpRemoteDataSource;

  SignUpRepositoryImp(this.signUpRemoteDataSource);

  @override
  FutureOr<(SignUpModel?, String?)> getUserSignUp({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
  }) async {
    return await signUpRemoteDataSource.signUp(
      firstname: firstname,
      lastname: lastname,
      email: email,
      password: password,
    );
  }
}
