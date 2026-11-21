import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/auth_service.dart';
import '../../../../routes/app_routes.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();
  final AuthService _authService = Get.find<AuthService>();

  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool obscurePassword = true.obs;
  final Rx<UserRole> selectedRole = UserRole.tenant.obs;

  void togglePasswordVisibility() =>
      obscurePassword.value = !obscurePassword.value;

  void selectRole(UserRole role) => selectedRole.value = role;

  Future<void> login() async {
    if (!(loginFormKey.currentState?.validate() ?? false)) return;
    await _performLogin(emailController.text, passwordController.text);
  }

  Future<void> loginAsDemo(UserRole role) async {
    final email = role.isLandlord ? 'owner@ejary.sa' : 'tenant@ejary.sa';
    await _performLogin(email, 'password123');
  }

  Future<void> _performLogin(String email, String password) async {
    try {
      isLoading.value = true;
      final user = await _authRepository.login(
        email: email,
        password: password,
      );
      _authService.setUser(user);
      Get.offAllNamed(AppRoutes.shell);
    } catch (e) {
      Get.snackbar(
        'sign_in'.tr,
        'invalid_credentials'.tr,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register() async {
    if (!(registerFormKey.currentState?.validate() ?? false)) return;

    try {
      isLoading.value = true;
      final user = await _authRepository.register(
        fullName: fullNameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
        role: selectedRole.value,
      );
      _authService.setUser(user);
      Get.offAllNamed(AppRoutes.shell);
    } catch (e) {
      final key = e.toString().contains('email_exists')
          ? 'email_exists'.tr
          : e.toString();
      Get.snackbar(
        'create_account'.tr,
        key,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
