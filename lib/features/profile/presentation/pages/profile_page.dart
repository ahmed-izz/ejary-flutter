import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('profile_title'.tr, style: theme.textTheme.headlineMedium),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Obx(() {
            final user = controller.authService.currentUser.value;
            if (user == null) return const SizedBox.shrink();
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor:
                          theme.colorScheme.primary.withValues(alpha: 0.14),
                      child: Text(
                        user.fullName.isNotEmpty
                            ? user.fullName[0].toUpperCase()
                            : 'E',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.fullName,
                              style: theme.textTheme.titleLarge),
                          const SizedBox(height: 2),
                          Text(user.email, style: theme.textTheme.bodyMedium),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              user.role.isLandlord
                                  ? 'role_landlord'.tr
                                  : 'role_tenant'.tr,
                              style: theme.textTheme.labelLarge?.copyWith(
                                fontSize: 12,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 24),
          Text('preferences'.tr, style: theme.textTheme.labelLarge),
          const SizedBox(height: 10),
          Card(
            child: Column(
              children: [
                Obx(
                  () => SwitchListTile(
                    secondary: const Icon(Icons.dark_mode_outlined),
                    title: Text('dark_mode'.tr),
                    value: controller.themeService.isDarkMode,
                    onChanged: (_) => controller.toggleTheme(),
                  ),
                ),
                const Divider(height: 1),
                Obx(
                  () => ListTile(
                    leading: const Icon(Icons.language_rounded),
                    title: Text('language'.tr),
                    trailing: Text(
                      controller.localeService.isArabic
                          ? 'arabic'.tr
                          : 'english'.tr,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    onTap: controller.toggleLanguage,
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.replay_rounded),
                  title: const Text('Replay Onboarding'),
                  onTap: controller.restartOnboarding,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Card(
            child: ListTile(
              leading:
                  Icon(Icons.logout_rounded, color: theme.colorScheme.error),
              title: Text(
                'sign_out'.tr,
                style: TextStyle(color: theme.colorScheme.error),
              ),
              onTap: () => _confirmSignOut(context),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmSignOut(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: Text('sign_out'.tr),
        content: Text('confirm_sign_out'.tr),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: Text('cancel'.tr),
          ),
          FilledButton(
            onPressed: () {
              Get.back();
              controller.signOut();
            },
            child: Text('sign_out'.tr),
          ),
        ],
      ),
    );
  }
}
