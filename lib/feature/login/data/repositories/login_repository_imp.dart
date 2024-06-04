import 'dart:async';
import 'package:authentication_app/feature/login/data/datasources/remote_data_source.dart';
import 'package:authentication_app/feature/login/domain/entities/login_entity.dart';
import 'package:authentication_app/feature/login/domain/repositories/loginn_repository.dart';

class LoginRepositoryImp implements LoginRepository {
  LoginRemoteDataSource loginRemoteDataSource;

  LoginRepositoryImp({required this.loginRemoteDataSource});

  @override
  FutureOr<LoginEntity?> getUserLogin({
    required String email,
    required String password,
  }) {
    return loginRemoteDataSource.signIn(email: email, password: password);
  }
}
