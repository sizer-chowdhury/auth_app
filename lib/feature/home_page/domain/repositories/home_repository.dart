import 'package:authentication_app/feature/home_page/data/data_source/home_remote_data_source.dart';
import 'package:authentication_app/feature/home_page/data/repositories/home_repository_imp.dart';
import 'package:authentication_app/feature/home_page/domain/entities/home_entity.dart';
import 'package:authentication_app/feature/home_page/domain/entities/logout_entity.dart';
import 'package:authentication_app/feature/login/data/repositories/login_repository_imp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  final remoteDatasource = ref.read(homeRemoteDataSourceProvider);
  return HomeRepositoryImp(remoteDatasource);
}

abstract class HomeRepository {
  FutureOr<(HomeEntity?, String?)> getProfileInfo();

  FutureOr<(LogoutEntity?, String?)> logout();
}
