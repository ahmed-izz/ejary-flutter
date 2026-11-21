import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/ejary_button.dart';
import '../../../../core/widgets/ejary_text_field.dart';
import '../../domain/entities/property_entity.dart';
import '../controllers/property_form_controller.dart';

class PropertyFormPage extends StatelessWidget {
  const PropertyFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: GetBuilder<PropertyFormController>(
          builder: (c) => Text(
            c.isEditing ? 'edit_property'.tr : 'add_property'.tr,
            style: theme.textTheme.titleLarge,
          ),
        ),
      ),
      body: GetBuilder<PropertyFormController>(
        builder: (controller) => SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EjaryTextField(
                  controller: controller.titleController,
                  label: 'title_label'.tr,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'field_required'.tr
                      : null,
                ),
                const SizedBox(height: 16),
                EjaryTextField(
                  controller: controller.cityController,
                  label: 'city_label'.tr,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'field_required'.tr
                      : null,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: EjaryTextField(
                        controller: controller.priceController,
                        label: 'price_label'.tr,
                        keyboardType: TextInputType.number,
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'field_required'.tr
                            : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: EjaryTextField(
                        controller: controller.areaController,
                        label: 'area'.tr,
                        keyboardType: TextInputType.number,
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'field_required'.tr
                            : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text('type_label'.tr, style: theme.textTheme.labelLarge),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: PropertyType.values.map((t) {
                    final selected = controller.selectedType == t;
                    return ChoiceChip(
                      label: Text(t.translationKey.tr),
                      selected: selected,
                      onSelected: (_) => controller.setType(t),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: _StepperTile(
                        label: 'beds'.tr,
                        value: controller.bedrooms,
                        onMinus: () => controller.changeBedrooms(-1),
                        onPlus: () => controller.changeBedrooms(1),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StepperTile(
                        label: 'baths'.tr,
                        value: controller.bathrooms,
                        onMinus: () => controller.changeBathrooms(-1),
                        onPlus: () => controller.changeBathrooms(1),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                EjaryTextField(
                  controller: controller.descController,
                  label: 'description_label'.tr,
                  maxLines: 4,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'field_required'.tr
                      : null,
                ),
                const SizedBox(height: 28),
                EjaryButton(
                  label: controller.isEditing
                      ? 'update_property'.tr
                      : 'save_property'.tr,
                  isLoading: controller.isSaving,
                  onPressed: controller.submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StepperTile extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  const _StepperTile({
    required this.label,
    required this.value,
    required this.onMinus,
    required this.onPlus,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: theme.textTheme.bodyMedium),
          Row(
            children: [
              InkWell(
                onTap: onMinus,
                child: const Icon(Icons.remove_circle_outline, size: 22),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text('$value', style: theme.textTheme.titleMedium),
              ),
              InkWell(
                onTap: onPlus,
                child: const Icon(Icons.add_circle_outline, size: 22),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
