import 'package:get/get.dart';

import '../../../../core/constants/storage_keys.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../routes/app_routes.dart';

class SplashController extends GetxController {
  final StorageService _storage = Get.find<StorageService>();
  final AuthService _authService = Get.find<AuthService>();

  @override
  void onReady() {
    super.onReady();
    _navigateNext();
  }

  Future<void> _navigateNext() async {
    await Future.delayed(const Duration(milliseconds: 1400));

    final seenOnboarding =
        _storage.read<bool>(StorageKeys.hasSeenOnboarding) ?? false;

    if (!seenOnboarding) {
      Get.offAllNamed(AppRoutes.onboarding);
      return;
    }

    if (_authService.isLoggedIn) {
      Get.offAllNamed(AppRoutes.shell);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
