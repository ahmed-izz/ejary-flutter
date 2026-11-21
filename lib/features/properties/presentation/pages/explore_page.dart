import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../favorites/presentation/controllers/favorites_controller.dart';
import '../../domain/entities/property_entity.dart';
import '../controllers/explore_controller.dart';
import '../widgets/property_card.dart';

class ExplorePage extends GetView<ExploreController> {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final favController = Get.find<FavoritesController>();

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'discover_title'.tr,
                      style:
                          theme.textTheme.headlineLarge?.copyWith(height: 1.18),
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      controller: controller.searchController,
                      onChanged: controller.onSearchChanged,
                      decoration: InputDecoration(
                        hintText: 'search_hint'.tr,
                        prefixIcon: const Icon(Icons.search_rounded, size: 22),
                        suffixIcon: Obx(
                          () => controller.searchQuery.value.isNotEmpty
                              ? IconButton(
                                  icon:
                                      const Icon(Icons.close_rounded, size: 20),
                                  onPressed: controller.clearFilters,
                                )
                              : const SizedBox.shrink(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 40,
                      child: Obx(
                        () => ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _FilterChip(
                              label: 'all'.tr,
                              selected: controller.selectedType.value == null,
                              onTap: () => controller.selectType(null),
                            ),
                            ...PropertyType.values.map(
                              (type) => Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(start: 8),
                                child: _FilterChip(
                                  label: type.translationKey.tr,
                                  selected:
                                      controller.selectedType.value == type,
                                  onTap: () => controller.selectType(type),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            controller.obx(
              (properties) => SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                sliver: SliverList.separated(
                  itemCount: properties!.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (_, index) {
                    final item = properties[index];
                    return Obx(
                      () => PropertyCard(
                        property: item,
                        isFavorite: favController.isFavorite(item.id),
                        onFavoriteTap: () =>
                            favController.toggleFavorite(item.id),
                        onTap: () => Get.toNamed(
                          AppRoutes.propertyDetails,
                          arguments: item,
                        ),
                      ),
                    );
                  },
                ),
              ),
              onLoading: const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              onEmpty: SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.search_off_rounded, size: 48),
                      const SizedBox(height: 12),
                      Text('no_properties'.tr,
                          style: theme.textTheme.bodyLarge),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: controller.clearFilters,
                        child: Text('clear_filters'.tr),
                      ),
                    ],
                  ),
                ),
              ),
              onError: (err) => SliverFillRemaining(
                child: Center(child: Text(err ?? 'Error')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? theme.colorScheme.primary : theme.cardTheme.color,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: selected ? theme.colorScheme.primary : theme.dividerColor,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              fontSize: 13,
              color: selected ? theme.colorScheme.onPrimary : null,
            ),
          ),
        ),
      ),
    );
  }
}
