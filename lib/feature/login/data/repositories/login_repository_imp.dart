import 'dart:async';
import 'package:authentication_app/feature/login/data/datasources/remote_data_source.dart';
import 'package:authentication_app/feature/login/data/models/login_model.dart';
import 'package:authentication_app/feature/login/domain/repositories/loginn_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_repository_imp.g.dart';

@riverpod
LoginRepositoryImp loginRepostoryImp(Ref ref) {
  final datasource = ref.read(loginRemoteDataSourceProvider);
  return LoginRepositoryImp(datasource);
}

class LoginRepositoryImp implements LoginRepository {
  LoginRemoteDataSource loginRemoteDataSource;

  LoginRepositoryImp(this.loginRemoteDataSource);

  @override
  FutureOr<LoginModel?> getUserLogin({
    required String email,
    required String password,
  }) {
    return loginRemoteDataSource.signIn(
      email: email,
      password: password,
    );
  }
}