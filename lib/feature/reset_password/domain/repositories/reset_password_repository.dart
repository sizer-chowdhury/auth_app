import 'package:authentication_app/feature/reset_password/data/data_source/remote_data_source.dart';
import 'package:authentication_app/feature/reset_password/data/repositories/reset_password_repository_imp.dart';
import 'package:authentication_app/feature/reset_password/domain/entities/reset_password_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reset_password_repository.g.dart';

@riverpod
ResetPasswordRepository resetPasswordRepository(
  ResetPasswordRepositoryRef ref,
) {
  final remoteDatasource = ref.read(resetPasswordRemoteDataSourceProvider);
  return ResetPasswordRepositoryImp(remoteDatasource);
}

abstract class ResetPasswordRepository {
  FutureOr<(ResetPasswordEntity?, String?)> resetPassword({
    required email,
    required password,
    required confirmPassword,
  });
}
