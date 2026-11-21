import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/ejary_network_image.dart';
import '../../domain/entities/property_entity.dart';

class PropertyCard extends StatelessWidget {
  final PropertyEntity property;
  final VoidCallback onTap;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;
  final Widget? trailingAction;

  const PropertyCard({
    super.key,
    required this.property,
    required this.onTap,
    this.isFavorite = false,
    this.onFavoriteTap,
    this.trailingAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 10,
                  child: EjaryNetworkImage(
                    imageUrl: property.imageUrls.first,
                    width: double.infinity,
                  ),
                ),
                PositionedDirectional(
                  top: 14,
                  start: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface.withValues(alpha: 0.92),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      property.type.translationKey.tr,
                      style: theme.textTheme.labelLarge?.copyWith(fontSize: 12),
                    ),
                  ),
                ),
                if (onFavoriteTap != null)
                  PositionedDirectional(
                    top: 10,
                    end: 10,
                    child: Material(
                      color: theme.colorScheme.surface.withValues(alpha: 0.9),
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: onFavoriteTap,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            size: 20,
                            color: isFavorite
                                ? theme.colorScheme.secondary
                                : theme.iconTheme.color,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 15,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          property.city,
                          style: theme.textTheme.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (trailingAction != null) trailingAction!,
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    property.title,
                    style: theme.textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          _SpecChip(
                            icon: Icons.bed_outlined,
                            text: '${property.bedrooms}',
                          ),
                          const SizedBox(width: 12),
                          _SpecChip(
                            icon: Icons.bathtub_outlined,
                            text: '${property.bathrooms}',
                          ),
                          const SizedBox(width: 12),
                          _SpecChip(
                            icon: Icons.square_foot_outlined,
                            text: '${property.areaSqm.toInt()} ${'area'.tr}',
                          ),
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${property.monthlyPrice.toInt()} SAR ',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            TextSpan(
                              text: 'per_month'.tr,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SpecChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _SpecChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 16, color: theme.textTheme.bodyMedium?.color),
        const SizedBox(width: 4),
        Text(text, style: theme.textTheme.bodyMedium),
      ],
    );
  }
}
