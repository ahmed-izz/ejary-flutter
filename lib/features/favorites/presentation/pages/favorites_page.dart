import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../properties/presentation/widgets/property_card.dart';
import '../controllers/favorites_controller.dart';

class FavoritesPage extends GetView<FavoritesController> {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('saved_title'.tr, style: theme.textTheme.headlineMedium),
      ),
      body: Obx(() {
        if (controller.favoriteProperties.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.favorite_border_rounded, size: 52),
                  const SizedBox(height: 12),
                  Text(
                    'no_favorites'.tr,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: controller.favoriteProperties.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (_, index) {
            final item = controller.favoriteProperties[index];
            return PropertyCard(
              property: item,
              isFavorite: true,
              onFavoriteTap: () => controller.toggleFavorite(item.id),
              onTap: () => Get.toNamed(
                AppRoutes.propertyDetails,
                arguments: item,
              ),
            );
          },
        );
      }),
    );
  }
}
