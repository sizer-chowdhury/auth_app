import 'package:authentication_app/feature/forget_password/data/data_sources/forget_password_remote_data_source.dart';
import 'package:authentication_app/feature/forget_password/data/models/forget_password_model.dart';
import 'package:authentication_app/feature/forget_password/domain/repositories/forget_password_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class ForgetPasswordRepositoryImp implements ForgetPasswordRepository {
  ForgetPasswordRemoteDataSource forgetPasswordRemoteDataSource;

  ForgetPasswordRepositoryImp(this.forgetPasswordRemoteDataSource);

  @override
  FutureOr<(ForgetPasswordModel?, String?)> forgetPassword({
    required String email,
  }) async {
    return await forgetPasswordRemoteDataSource.remoteDataForgetPassword(
      email: email,
    );
  }
}
