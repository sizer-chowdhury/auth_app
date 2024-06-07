import 'package:authentication_app/feature/login/data/repositories/login_repository_imp.dart';
import 'package:authentication_app/feature/login/domain/entities/login_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_repository.g.dart';

@riverpod
LoginRepositoryImp loginRepository(Ref ref) {
  return ref.read(loginRepostoryImpProvider);
}

abstract class LoginRepository {
  FutureOr<LoginEntity?> getUserLogin({
    required String email,
    required String password,
  });
}