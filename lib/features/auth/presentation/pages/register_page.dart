import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/ejary_button.dart';
import '../../../../core/widgets/ejary_text_field.dart';
import '../../domain/entities/user_entity.dart';
import '../controllers/auth_controller.dart';

class RegisterPage extends GetView<AuthController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Form(
            key: controller.registerFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('create_account'.tr, style: theme.textTheme.headlineLarge),
                const SizedBox(height: 6),
                Text('register_subtitle'.tr, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 24),
                Text(
                  'select_role'.tr,
                  style: theme.textTheme.labelLarge?.copyWith(fontSize: 13.5),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => Row(
                    children: [
                      _RoleCard(
                        title: 'role_tenant'.tr,
                        icon: Icons.person_outline_rounded,
                        selected:
                            controller.selectedRole.value == UserRole.tenant,
                        onTap: () => controller.selectRole(UserRole.tenant),
                      ),
                      const SizedBox(width: 12),
                      _RoleCard(
                        title: 'role_landlord'.tr,
                        icon: Icons.home_work_outlined,
                        selected:
                            controller.selectedRole.value == UserRole.landlord,
                        onTap: () => controller.selectRole(UserRole.landlord),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                EjaryTextField(
                  controller: controller.fullNameController,
                  label: 'full_name'.tr,
                  prefixIcon: Icons.badge_outlined,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'field_required'.tr
                      : null,
                ),
                const SizedBox(height: 16),
                EjaryTextField(
                  controller: controller.emailController,
                  label: 'email'.tr,
                  prefixIcon: Icons.mail_outline_rounded,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'field_required'.tr;
                    }
                    if (!GetUtils.isEmail(v.trim())) {
                      return 'invalid_email'.tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                EjaryTextField(
                  controller: controller.phoneController,
                  label: 'phone'.tr,
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'field_required'.tr
                      : null,
                ),
                const SizedBox(height: 16),
                Obx(
                  () => EjaryTextField(
                    controller: controller.passwordController,
                    label: 'password'.tr,
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
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'field_required'.tr;
                      }
                      if (v.length < 6) {
                        return 'password_short'.tr;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 28),
                Obx(
                  () => EjaryButton(
                    label: 'sign_up'.tr,
                    isLoading: controller.isLoading.value,
                    onPressed: controller.register,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('have_account'.tr, style: theme.textTheme.bodyMedium),
                    TextButton(
                      onPressed: Get.back,
                      child: Text('sign_in'.tr),
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

class _RoleCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            color: selected
                ? theme.colorScheme.primary.withValues(alpha: 0.1)
                : theme.cardTheme.color,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? theme.colorScheme.primary : theme.dividerColor,
              width: selected ? 1.6 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: selected
                    ? theme.colorScheme.primary
                    : theme.textTheme.bodyMedium?.color,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontSize: 13,
                  color: selected ? theme.colorScheme.primary : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}