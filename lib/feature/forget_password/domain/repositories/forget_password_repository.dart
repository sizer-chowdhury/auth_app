import 'package:authentication_app/feature/forget_password/data/data_sources/forget_password_remote_data_source.dart';
import 'package:authentication_app/feature/forget_password/data/repositories/forget_password_repository_imp.dart';
import 'package:authentication_app/feature/forget_password/domain/entities/forget_password_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'forget_password_repository.g.dart';

@riverpod
ForgetPasswordRepository forgetPasswordRepository(Ref ref) {
  final remoteDatasource = ref.read(forgetPasswordRemoteDataSourceProvider);
  return ForgetPasswordRepositoryImp(remoteDatasource);
}

abstract class ForgetPasswordRepository {
  FutureOr<(ForgetPasswordEntity?, String?)> forgetPassword({
    required String email,
  });
}
