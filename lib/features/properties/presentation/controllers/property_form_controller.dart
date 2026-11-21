import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/auth_service.dart';
import '../../domain/entities/property_entity.dart';
import '../../domain/repositories/property_repository.dart';

class PropertyFormController extends GetxController {
  final PropertyRepository _repository = Get.find<PropertyRepository>();
  final AuthService _authService = Get.find<AuthService>();

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final cityController = TextEditingController();
  final priceController = TextEditingController();
  final areaController = TextEditingController();
  final descController = TextEditingController();

  PropertyEntity? editingProperty;
  PropertyType selectedType = PropertyType.apartment;
  int bedrooms = 2;
  int bathrooms = 2;
  bool isSaving = false;

  bool get isEditing => editingProperty != null;

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    if (arg is PropertyEntity) {
      editingProperty = arg;
      titleController.text = arg.title;
      cityController.text = arg.city;
      priceController.text = arg.monthlyPrice.toStringAsFixed(0);
      areaController.text = arg.areaSqm.toStringAsFixed(0);
      descController.text = arg.description;
      selectedType = arg.type;
      bedrooms = arg.bedrooms;
      bathrooms = arg.bathrooms;
    }
  }

  void setType(PropertyType type) {
    selectedType = type;
    update();
  }

  void changeBedrooms(int delta) {
    final next = bedrooms + delta;
    if (next >= 1 && next <= 10) {
      bedrooms = next;
      update();
    }
  }

  void changeBathrooms(int delta) {
    final next = bathrooms + delta;
    if (next >= 1 && next <= 10) {
      bathrooms = next;
      update();
    }
  }

  Future<void> submit() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    final user = _authService.currentUser.value;
    if (user == null) return;

    isSaving = true;
    update();

    final property = PropertyEntity(
      id: editingProperty?.id ??
          'prop_${DateTime.now().millisecondsSinceEpoch}',
      ownerId: user.id,
      ownerName: user.fullName,
      title: titleController.text.trim(),
      description: descController.text.trim(),
      city: cityController.text.trim(),
      monthlyPrice: double.tryParse(priceController.text.trim()) ?? 5000,
      bedrooms: bedrooms,
      bathrooms: bathrooms,
      areaSqm: double.tryParse(areaController.text.trim()) ?? 120,
      type: selectedType,
      imageUrls: editingProperty?.imageUrls ??
          const [
            'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1000&q=80',
          ],
      amenities: editingProperty?.amenities ??
          const ['Fiber Wi-Fi', 'Central AC', 'Private Parking'],
    );

    if (isEditing) {
      await _repository.updateProperty(property);
    } else {
      await _repository.addProperty(property);
    }

    isSaving = false;
    update();

    Get.back(result: true);
    Get.snackbar(
      'app_name'.tr,
      'property_saved'.tr,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }

  @override
  void onClose() {
    titleController.dispose();
    cityController.dispose();
    priceController.dispose();
    areaController.dispose();
    descController.dispose();
    super.onClose();
  }
}
