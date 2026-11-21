import 'package:get/get.dart';

import '../../../../core/constants/storage_keys.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/locale_service.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../core/services/theme_service.dart';
import '../../../../routes/app_routes.dart';
import '../../../auth/domain/repositories/auth_repository.dart';

class ProfileController extends GetxController {
  final AuthService authService = Get.find<AuthService>();
  final ThemeService themeService = Get.find<ThemeService>();
  final LocaleService localeService = Get.find<LocaleService>();
  final StorageService _storage = Get.find<StorageService>();
  final AuthRepository _authRepository = Get.find<AuthRepository>();

  Future<void> toggleTheme() => themeService.toggleTheme();

  Future<void> toggleLanguage() => localeService.toggleLocale();

  Future<void> signOut() async {
    await authService.signOut(_authRepository);
    Get.offAllNamed(AppRoutes.login);
  }

  Future<void> restartOnboarding() async {
    await authService.signOut(_authRepository);
    await _storage.remove(StorageKeys.hasSeenOnboarding);
    Get.offAllNamed(AppRoutes.onboarding);
  }
}
