import 'package:authentication_app/feature/signup/data/data_sources/signup_remote_data_source.dart';
import 'package:authentication_app/feature/signup/data/models/signup_model.dart';
import 'package:authentication_app/feature/signup/domain/repositories/signup_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class SignUpRepositoryImp implements SignUpRepository {
  SignUpRemoteDataSource signUpRemoteDataSource;

  SignUpRepositoryImp(this.signUpRemoteDataSource);

  @override
  FutureOr<(SignUpModel?, String?)> userSignUp({
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
