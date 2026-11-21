import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/ejary_button.dart';
import '../../../../core/widgets/ejary_text_field.dart';
import '../controllers/rental_request_controller.dart';

class RentalRequestPage extends GetView<RentalRequestController> {
  const RentalRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final durations = [3, 6, 12];

    return Scaffold(
      appBar: AppBar(
        title: Text('rental_request'.tr, style: theme.textTheme.titleLarge),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.cardTheme.color,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: theme.dividerColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.property.title,
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    controller.property.city,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('lease_duration'.tr, style: theme.textTheme.labelLarge),
            const SizedBox(height: 12),
            Obx(
              () => Row(
                children: durations.map((m) {
                  final selected = controller.selectedMonths.value == m;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(end: 8),
                      child: InkWell(
                        onTap: () => controller.setDuration(m),
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: selected
                                ? theme.colorScheme.primary
                                : theme.cardTheme.color,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: selected
                                  ? theme.colorScheme.primary
                                  : theme.dividerColor,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '$m ${'months'.tr}',
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: selected
                                    ? theme.colorScheme.onPrimary
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 22),
            Text('move_in_date'.tr, style: theme.textTheme.labelLarge),
            const SizedBox(height: 10),
            Obx(
              () => InkWell(
                onTap: () => controller.pickMoveInDate(context),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: theme.cardTheme.color,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: theme.dividerColor),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('dd MMM yyyy')
                            .format(controller.moveInDate.value),
                        style: theme.textTheme.bodyLarge,
                      ),
                      const Icon(Icons.calendar_today_outlined, size: 19),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 22),
            EjaryTextField(
              controller: controller.noteController,
              label: 'notes_owner'.tr,
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('total_contract'.tr, style: theme.textTheme.bodyLarge),
                  Obx(
                    () => Text(
                      '${controller.estimatedTotal.toInt()} SAR',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Obx(
              () => EjaryButton(
                label: 'submit_request'.tr,
                isLoading: controller.isSubmitting.value,
                onPressed: controller.submitRequest,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
