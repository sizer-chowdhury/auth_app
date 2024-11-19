import 'package:authentication_app/feature/home_page/domain/entities/home_entity.dart';
import 'package:authentication_app/feature/home_page/domain/use_cases/home_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_controller.g.dart';

@riverpod
class HomeController extends _$HomeController {
  @override
  FutureOr<(HomeEntity?, String?)> build() {
    return (null, null);
  }

  void getProfileInfo() async {
    state = const AsyncData((null, null));
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await ref.read(homeUseCaseProvider).getProfileInfo();
    });
  }
}
