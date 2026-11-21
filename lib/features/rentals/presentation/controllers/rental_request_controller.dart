import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/auth_service.dart';
import '../../../properties/domain/entities/property_entity.dart';
import '../../domain/entities/rental_entity.dart';
import '../../domain/repositories/rental_repository.dart';
import 'rentals_controller.dart';

class RentalRequestController extends GetxController {
  final RentalRepository _repository = Get.find<RentalRepository>();
  final AuthService _authService = Get.find<AuthService>();

  late final PropertyEntity property;
  final noteController = TextEditingController();

  final RxInt selectedMonths = 12.obs;
  final Rx<DateTime> moveInDate =
      DateTime.now().add(const Duration(days: 7)).obs;
  final RxBool isSubmitting = false.obs;

  double get estimatedTotal => property.monthlyPrice * selectedMonths.value;

  @override
  void onInit() {
    super.onInit();
    property = Get.arguments as PropertyEntity;
  }

  void setDuration(int months) => selectedMonths.value = months;

  Future<void> pickMoveInDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: moveInDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      moveInDate.value = picked;
    }
  }

  Future<void> submitRequest() async {
    final user = _authService.currentUser.value;
    if (user == null) return;

    isSubmitting.value = true;
    final rental = RentalEntity(
      id: 'rent_${DateTime.now().millisecondsSinceEpoch}',
      propertyId: property.id,
      propertyTitle: property.title,
      propertyCity: property.city,
      propertyImage: property.imageUrls.first,
      tenantId: user.id,
      tenantName: user.fullName,
      ownerId: property.ownerId,
      durationMonths: selectedMonths.value,
      monthlyRent: property.monthlyPrice,
      moveInDate: moveInDate.value,
      note: noteController.text.trim(),
      status: RentalStatus.pending,
    );

    await _repository.createRentalRequest(rental);
    if (Get.isRegistered<RentalsController>()) {
      await Get.find<RentalsController>().fetchRentals();
    }

    isSubmitting.value = false;
    Get.back();
    Get.snackbar(
      'rental_request'.tr,
      'request_sent'.tr,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }

  @override
  void onClose() {
    noteController.dispose();
    super.onClose();
  }
}
