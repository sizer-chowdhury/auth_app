import 'package:authentication_app/feature/login/data/data_sources/remote_data_source.dart';
import 'package:authentication_app/feature/login/data/repositories/login_repository_imp.dart';
import 'package:authentication_app/feature/login/domain/entities/login_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_repository.g.dart';

@riverpod
LoginRepository loginRepository(Ref ref) {
  final remoteDatasource = ref.read(loginRemoteDataSourceProvider);
  return LoginRepositoryImp(remoteDatasource);
}

abstract class LoginRepository {
  FutureOr<LoginEntity?> signIn({
    required String email,
    required String password,
    required bool isLogin,
  });
}