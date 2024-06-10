import 'package:authentication_app/feature/home_page/domain/entities/logout_entity.dart';
import 'package:authentication_app/feature/home_page/domain/use_cases/home_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logout_controller.g.dart';

@riverpod
class LogoutController extends _$LogoutController {
  @override
  FutureOr<(LogoutEntity?, String?)> build() {
    return (null, null);
  }

  void logout() async {
    state = const AsyncData((null, null));
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await ref.read(homeUseCaseProvider).logout();
    });
  }
}
