import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/ejary_button.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final slides = [
      (
        icon: Icons.home_work_outlined,
        title: 'onb_1_title'.tr,
        desc: 'onb_1_desc'.tr,
      ),
      (
        icon: Icons.description_outlined,
        title: 'onb_2_title'.tr,
        desc: 'onb_2_desc'.tr,
      ),
      (
        icon: Icons.key_outlined,
        title: 'onb_3_title'.tr,
        desc: 'onb_3_desc'.tr,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: GetBuilder<OnboardingController>(
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                      onPressed: controller.finishOnboarding,
                      child: Text('skip'.tr),
                    ),
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: controller.pageController,
                      onPageChanged: controller.onPageChanged,
                      itemCount: slides.length,
                      itemBuilder: (_, index) {
                        final item = slides[index];
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 96,
                              height: 96,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(28),
                              ),
                              child: Icon(
                                item.icon,
                                size: 46,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 36),
                            Text(
                              item.title,
                              style: theme.textTheme.headlineLarge
                                  ?.copyWith(height: 1.2),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              item.desc,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.textTheme.bodyMedium?.color,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Row(
                    children: List.generate(
                      slides.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsetsDirectional.only(end: 8),
                        height: 8,
                        width: controller.currentPage == index ? 28 : 8,
                        decoration: BoxDecoration(
                          color: controller.currentPage == index
                              ? theme.colorScheme.primary
                              : theme.dividerColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  EjaryButton(
                    label: controller.currentPage == 2
                        ? 'get_started'.tr
                        : 'next'.tr,
                    onPressed: controller.nextPage,
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
