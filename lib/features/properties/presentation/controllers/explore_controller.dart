import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/property_entity.dart';
import '../../domain/repositories/property_repository.dart';

class ExploreController extends GetxController
    with StateMixin<List<PropertyEntity>> {
  final PropertyRepository _repository = Get.find<PropertyRepository>();

  final searchController = TextEditingController();
  final Rxn<PropertyType> selectedType = Rxn<PropertyType>();
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    debounce(
      searchQuery,
      (_) => fetchProperties(),
      time: const Duration(milliseconds: 300),
    );
    fetchProperties();
  }

  Future<void> fetchProperties() async {
    change(null, status: RxStatus.loading());
    try {
      final items = await _repository.getProperties(
        query: searchQuery.value,
        type: selectedType.value,
      );
      if (items.isEmpty) {
        change([], status: RxStatus.empty());
      } else {
        change(items, status: RxStatus.success());
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  void selectType(PropertyType? type) {
    selectedType.value = type;
    fetchProperties();
  }

  void onSearchChanged(String value) {
    searchQuery.value = value;
  }

  void clearFilters() {
    searchController.clear();
    searchQuery.value = '';
    selectedType.value = null;
    fetchProperties();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
