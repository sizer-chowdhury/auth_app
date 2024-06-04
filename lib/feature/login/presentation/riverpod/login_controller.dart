import 'package:authentication_app/feature/login/data/datasources/remote_data_source.dart';
import 'package:authentication_app/feature/login/data/repositories/login_repository_imp.dart';
import 'package:authentication_app/feature/login/domain/entities/login_entity.dart';
import 'package:authentication_app/feature/login/domain/usecases/user_login.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_controller.g.dart';

@riverpod
class Login extends _$Login {
  @override
  FutureOr<LoginEntity?> build() {
    return null;
  }

  void signIn({required String email, required String password}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      LoginRepositoryImp loginRepositoryImp =
          LoginRepositoryImp(loginRemoteDataSource: LoginRemoteDataSource());
      return LoginUseCase(loginRepositoryImp)
          .userLogin(email: email, password: password);
    });
  }
}
