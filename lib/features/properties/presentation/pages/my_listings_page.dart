import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../controllers/explore_controller.dart';
import '../controllers/my_listings_controller.dart';
import '../widgets/property_card.dart';

class MyListingsPage extends GetView<MyListingsController> {
  const MyListingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('my_listings'.tr, style: theme.textTheme.headlineMedium),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final res = await Get.toNamed(AppRoutes.propertyForm);
          if (res == true) {
            controller.fetchMyListings();
            if (Get.isRegistered<ExploreController>()) {
              Get.find<ExploreController>().fetchProperties();
            }
          }
        },
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        icon: const Icon(Icons.add_rounded),
        label: Text('add_property'.tr),
      ),
      body: controller.obx(
        (items) => ListView.separated(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 90),
          itemCount: items!.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (_, index) {
            final item = items[index];
            return PropertyCard(
              property: item,
              onTap: () =>
                  Get.toNamed(AppRoutes.propertyDetails, arguments: item),
              trailingAction: PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == 'edit') {
                    final res = await Get.toNamed(
                      AppRoutes.propertyForm,
                      arguments: item,
                    );
                    if (res == true) controller.fetchMyListings();
                  } else if (value == 'delete') {
                    await controller.deleteListing(item.id);
                  }
                },
                itemBuilder: (_) => [
                  PopupMenuItem(value: 'edit', child: Text('edit_property'.tr)),
                  PopupMenuItem(value: 'delete', child: Text('delete'.tr)),
                ],
              ),
            );
          },
        ),
        onLoading: const Center(child: CircularProgressIndicator()),
        onEmpty: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.home_work_outlined, size: 52),
                const SizedBox(height: 12),
                Text(
                  'no_listings'.tr,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
