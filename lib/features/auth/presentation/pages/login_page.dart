import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/ejary_button.dart';
import '../../../../core/widgets/ejary_text_field.dart';
import '../../../../routes/app_routes.dart';
import '../../domain/entities/user_entity.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text('welcome_back'.tr, style: theme.textTheme.headlineLarge),
                const SizedBox(height: 8),
                Text('sign_in_subtitle'.tr, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 32),
                EjaryTextField(
                  controller: controller.emailController,
                  label: 'email'.tr,
                  hint: 'name@example.com',
                  prefixIcon: Icons.mail_outline_rounded,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'field_required'.tr;
                    }
                    if (!GetUtils.isEmail(val.trim())) {
                      return 'invalid_email'.tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),
                Obx(
                  () => EjaryTextField(
                    controller: controller.passwordController,
                    label: 'password'.tr,
                    hint: '••••••••',
                    prefixIcon: Icons.lock_outline_rounded,
                    obscureText: controller.obscurePassword.value,
                    suffixIcon: IconButton(
                      onPressed: controller.togglePasswordVisibility,
                      icon: Icon(
                        controller.obscurePassword.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 20,
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'field_required'.tr;
                      }
                      if (val.length < 6) {
                        return 'password_short'.tr;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 28),
                Obx(
                  () => EjaryButton(
                    label: 'sign_in'.tr,
                    isLoading: controller.isLoading.value,
                    onPressed: controller.login,
                  ),
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'demo_accounts'.tr,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () =>
                            controller.loginAsDemo(UserRole.tenant),
                        icon: const Icon(Icons.person_outline, size: 18),
                        label: Text('demo_tenant'.tr),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () =>
                            controller.loginAsDemo(UserRole.landlord),
                        icon: const Icon(Icons.key_outlined, size: 18),
                        label: Text('demo_landlord'.tr),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('no_account'.tr, style: theme.textTheme.bodyMedium),
                    TextButton(
                      onPressed: () => Get.toNamed(AppRoutes.register),
                      child: Text('sign_up'.tr),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
