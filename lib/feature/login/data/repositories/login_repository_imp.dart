import 'package:authentication_app/feature/login/data/datasources/local_data_source.dart';
import 'package:authentication_app/feature/login/data/datasources/remote_data_source.dart';
import 'package:authentication_app/feature/login/data/models/login_model.dart';
import 'package:authentication_app/feature/login/domain/repositories/login_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_repository_imp.g.dart';

@riverpod
LoginRepositoryImp loginRepositoryImp(Ref ref) {
  final remoteDatasource = ref.read(loginRemoteDataSourceProvider);
  return LoginRepositoryImp(remoteDatasource);
}

class LoginRepositoryImp implements LoginRepository {
  LoginRemoteDataSource loginRemoteDataSource;

  LoginRepositoryImp(this.loginRemoteDataSource);

  @override
  FutureOr<LoginModel?> getUserLogin({
    required String email,
    required String password,
  }) async {
    LoginModel? loginModel = await loginRemoteDataSource.signIn(
      email: email,
      password: password,
    );
    LoginLocalDataSource loginLocalDataSource = LoginLocalDataSource(
      key: 'token',
      value: loginModel!.getToken() ?? "",
    );
    loginLocalDataSource.setCacheData();
    return loginModel;
  }
}
