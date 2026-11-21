import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/auth_service.dart';
import '../../../../core/widgets/ejary_button.dart';
import '../../../../core/widgets/ejary_network_image.dart';
import '../../../../routes/app_routes.dart';
import '../../../favorites/presentation/controllers/favorites_controller.dart';
import '../../domain/entities/property_entity.dart';

class PropertyDetailsPage extends StatelessWidget {
  const PropertyDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PropertyEntity property = Get.arguments as PropertyEntity;
    final theme = Theme.of(context);
    final authService = Get.find<AuthService>();
    final favController = Get.find<FavoritesController>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            actions: [
              if (authService.isTenant)
                Obx(
                  () => IconButton(
                    onPressed: () => favController.toggleFavorite(property.id),
                    icon: CircleAvatar(
                      backgroundColor:
                          theme.colorScheme.surface.withValues(alpha: 0.85),
                      child: Icon(
                        favController.isFavorite(property.id)
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: favController.isFavorite(property.id)
                            ? theme.colorScheme.secondary
                            : theme.iconTheme.color,
                        size: 20,
                      ),
                    ),
                  ),
                ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: PageView.builder(
                itemCount: property.imageUrls.length,
                itemBuilder: (_, idx) => EjaryNetworkImage(
                  imageUrl: property.imageUrls[idx],
                  width: double.infinity,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color:
                              theme.colorScheme.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          property.type.translationKey.tr,
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontSize: 12,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          property.city,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(property.title, style: theme.textTheme.headlineMedium),
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.cardTheme.color,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: theme.dividerColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _Metric(
                          icon: Icons.bed_outlined,
                          value: '${property.bedrooms}',
                          label: 'beds'.tr,
                        ),
                        _Metric(
                          icon: Icons.bathtub_outlined,
                          value: '${property.bathrooms}',
                          label: 'baths'.tr,
                        ),
                        _Metric(
                          icon: Icons.square_foot_outlined,
                          value: '${property.areaSqm.toInt()}',
                          label: 'area'.tr,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text('about_space'.tr, style: theme.textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(property.description, style: theme.textTheme.bodyLarge),
                  const SizedBox(height: 24),
                  Text('amenities'.tr, style: theme.textTheme.titleLarge),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: property.amenities
                        .map(
                          (a) => Chip(
                            label: Text(a),
                            backgroundColor: theme.cardTheme.color,
                            side: BorderSide(color: theme.dividerColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.cardTheme.color,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: theme.dividerColor),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor:
                              theme.colorScheme.primary.withValues(alpha: 0.12),
                          child: Icon(
                            Icons.person_outline,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('hosted_by'.tr,
                                style: theme.textTheme.bodyMedium),
                            Text(
                              property.ownerName,
                              style: theme.textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border(top: BorderSide(color: theme.dividerColor)),
          ),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${property.monthlyPrice.toInt()} SAR',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  Text('per_month'.tr, style: theme.textTheme.bodyMedium),
                ],
              ),
              const SizedBox(width: 24),
              if (authService.isTenant)
                Expanded(
                  child: EjaryButton(
                    label: 'request_rental'.tr,
                    onPressed: () => Get.toNamed(
                      AppRoutes.rentalRequest,
                      arguments: property,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _Metric({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Icon(icon, color: theme.colorScheme.primary, size: 22),
        const SizedBox(height: 6),
        Text(value, style: theme.textTheme.titleMedium),
        Text(label, style: theme.textTheme.bodyMedium),
      ],
    );
  }
}
