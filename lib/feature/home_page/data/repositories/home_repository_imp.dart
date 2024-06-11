import 'package:authentication_app/feature/home_page/data/data_source/home_remote_data_source.dart';
import 'package:authentication_app/feature/home_page/data/models/home_model.dart';
import 'package:authentication_app/feature/home_page/data/models/logout_model.dart';
import 'package:authentication_app/feature/home_page/domain/repositories/home_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class HomeRepositoryImp implements HomeRepository {
  HomeRemoteDataSource homeRemoteDataSource;

  HomeRepositoryImp(this.homeRemoteDataSource);

  @override
  FutureOr<(HomeModel?, String?)> getProfileInfo() async {
    return await HomeRemoteDataSource.getProfileInfo();
  }

  @override
  FutureOr<(LogoutModel?, String?)> logout() async {
    return await HomeRemoteDataSource.signOut();
  }
}
