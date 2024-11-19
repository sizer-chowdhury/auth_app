
import 'package:authentication_app/feature/login/data/data_sources/local_data_source.dart';
import 'package:authentication_app/feature/login/data/data_sources/remote_data_source.dart';
import 'package:authentication_app/feature/login/data/models/login_model.dart';
import 'package:authentication_app/feature/login/domain/repositories/login_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class LoginRepositoryImp implements LoginRepository {
  LoginRemoteDataSource loginRemoteDataSource;

  LoginRepositoryImp(this.loginRemoteDataSource);

  @override
  FutureOr<LoginModel?> signIn({
    required String email,
    required String password,
    required isLogin,
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
    if (isLogin) {
      LoginLocalDataSource loginLocalDataSource = LoginLocalDataSource(
        key: 'loggedInEmail',
        value: email,
      );
      loginLocalDataSource.setCacheData();
    }
    return loginModel;
  }
}
