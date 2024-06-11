import 'package:authentication_app/feature/home_page/domain/entities/home_entity.dart';
import 'package:authentication_app/feature/home_page/domain/entities/logout_entity.dart';
import 'package:authentication_app/feature/home_page/domain/repositories/home_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_use_case.g.dart';

@riverpod
HomeUseCase homeUseCase(HomeUseCaseRef ref) {
  final homeRepositoryRepo = ref.read(homeRepositoryProvider);
  return HomeUseCase(homeRepositoryRepo: homeRepositoryRepo);
}

class HomeUseCase {
  final HomeRepository homeRepositoryRepo;

  HomeUseCase({required this.homeRepositoryRepo});

  FutureOr<(HomeEntity?, String?)> getProfileInfo() async {
    return await homeRepositoryRepo.getProfileInfo();
  }

  FutureOr<(LogoutEntity?, String?)> logout() async {
    return await homeRepositoryRepo.logout();
  }
}
