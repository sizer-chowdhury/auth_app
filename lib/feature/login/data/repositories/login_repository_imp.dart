import 'package:authentication_app/feature/login/data/data_sources/local_data_source.dart';
import 'package:authentication_app/feature/login/data/data_sources/remote_data_source.dart';
import 'package:authentication_app/feature/login/data/models/login_model.dart';
import 'package:authentication_app/feature/login/domain/repositories/login_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_repository_imp.g.dart';

/// The implementation of the LoginRepository using Riverpod for dependency injection.
@riverpod
LoginRepositoryImp loginRepositoryImp(LoginRepositoryImpRef ref) {
  final loginRemoteDataSource = ref.watch(loginRemoteDataSourceProvider);
  return LoginRepositoryImp(loginRemoteDataSource);
}

class LoginRepositoryImp implements LoginRepository {
  final LoginRemoteDataSource loginRemoteDataSource;

  LoginRepositoryImp(this.loginRemoteDataSource);

  @override
  FutureOr<LoginModel?> signIn({
    required String email,
    required String password,
    required bool isLogin,
  }) async {
    // Call the remote data source for login
    final loginModel = await loginRemoteDataSource.signIn(
      email: email,
      password: password,
    );

    // Cache the token locally
    final tokenLocalDataSource = LoginLocalDataSource(
      key: 'token',
      value: loginModel?.getToken() ?? "",
    );
    tokenLocalDataSource.setCacheData();

    // Cache the email if it's a login process
    if (isLogin) {
      final emailLocalDataSource = LoginLocalDataSource(
        key: 'loggedInEmail',
        value: email,
      );
      emailLocalDataSource.setCacheData();
    }

    return loginModel;
  }
}
