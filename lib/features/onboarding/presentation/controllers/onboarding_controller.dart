import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/storage_keys.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../routes/app_routes.dart';

class OnboardingController extends GetxController {
  final StorageService _storage = Get.find<StorageService>();
  final PageController pageController = PageController();

  int currentPage = 0;

  void onPageChanged(int index) {
    currentPage = index;
    update();
  }

  void nextPage() {
    if (currentPage < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    } else {
      finishOnboarding();
    }
  }

  Future<void> finishOnboarding() async {
    await _storage.write(StorageKeys.hasSeenOnboarding, true);
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
