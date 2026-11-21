import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/services/auth_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/ejary_network_image.dart';
import '../../domain/entities/rental_entity.dart';
import '../controllers/rentals_controller.dart';

class RentalsPage extends GetView<RentalsController> {
  const RentalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLandlord = Get.find<AuthService>().isLandlord;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isLandlord ? 'incoming_requests'.tr : 'my_rentals'.tr,
          style: theme.textTheme.headlineMedium,
        ),
      ),
      body: controller.obx(
        (items) => RefreshIndicator(
          onRefresh: controller.fetchRentals,
          child: ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: items!.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (_, index) {
              final rental = items[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          EjaryNetworkImage(
                            imageUrl: rental.propertyImage,
                            width: 74,
                            height: 74,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _StatusBadge(status: rental.status),
                                const SizedBox(height: 6),
                                Text(
                                  rental.propertyTitle,
                                  style: theme.textTheme.titleMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  isLandlord
                                      ? rental.tenantName
                                      : rental.propertyCity,
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${rental.durationMonths} ${'months'.tr} · ${DateFormat('dd MMM yyyy').format(rental.moveInDate)}',
                            style: theme.textTheme.bodyMedium,
                          ),
                          Text(
                            '${rental.totalAmount.toInt()} SAR',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      if (isLandlord &&
                          rental.status == RentalStatus.pending) ...[
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => controller.updateStatus(
                                  rental.id,
                                  RentalStatus.rejected,
                                ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.error,
                                  side:
                                      const BorderSide(color: AppColors.error),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text('decline'.tr),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: FilledButton(
                                onPressed: () => controller.updateStatus(
                                  rental.id,
                                  RentalStatus.approved,
                                ),
                                style: FilledButton.styleFrom(
                                  backgroundColor: theme.colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text('approve'.tr),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        onLoading: const Center(child: CircularProgressIndicator()),
        onEmpty: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.description_outlined, size: 52),
                const SizedBox(height: 12),
                Text(
                  'no_rentals'.tr,
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

class _StatusBadge extends StatelessWidget {
  final RentalStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      RentalStatus.pending => AppColors.warning,
      RentalStatus.approved => AppColors.success,
      RentalStatus.rejected => AppColors.error,
      RentalStatus.completed => AppColors.primary,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.translationKey.tr,
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
