import 'package:authentication_app/feature/reset_password/data/data_source/remote_data_source.dart';
import 'package:authentication_app/feature/reset_password/data/models/reset_password_model.dart';
import 'package:authentication_app/feature/reset_password/domain/repositories/reset_password_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class ResetPasswordRepositoryImp implements ResetPasswordRepository {
  ResetPasswordRemoteDataSource resetPasswordRemoteDataSource;

  ResetPasswordRepositoryImp(this.resetPasswordRemoteDataSource);

  @override
  FutureOr<(ResetPasswordModel?, String?)> resetPassword({
    required email,
    required password,
    required confirmPassword,
  }) async {
    return await ResetPasswordRemoteDataSource.resetPassword(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}
