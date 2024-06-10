import 'package:authentication_app/feature/home_page/data/repositories/home_repository_imp.dart';
import 'package:authentication_app/feature/home_page/domain/entities/home_entity.dart';
import 'package:authentication_app/feature/home_page/domain/entities/logout_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_use_case.g.dart';

@riverpod
HomeUseCase homeUseCase(HomeUseCaseRef ref) {
  final homeRepositoryImp = ref.read(homeRepositoryImpProvider);
  return HomeUseCase(homeRepositoryImp: homeRepositoryImp);
}

class HomeUseCase {
  final HomeRepositoryImp homeRepositoryImp;

  HomeUseCase({required this.homeRepositoryImp});

  FutureOr<(HomeEntity?, String?)> getProfileInfo() async {
    return await homeRepositoryImp.getProfileInfo();
  }

  FutureOr<(LogoutEntity?, String?)> logout() async {
    return await homeRepositoryImp.logout();
  }
}
