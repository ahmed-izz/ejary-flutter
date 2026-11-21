import 'package:get/get.dart';

import '../../../../core/services/auth_service.dart';
import '../../domain/entities/property_entity.dart';
import '../../domain/repositories/property_repository.dart';

class MyListingsController extends GetxController
    with StateMixin<List<PropertyEntity>> {
  final PropertyRepository _repository = Get.find<PropertyRepository>();
  final AuthService _authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    fetchMyListings();
  }

  Future<void> fetchMyListings() async {
    final ownerId = _authService.currentUser.value?.id;
    if (ownerId == null) return;

    change(null, status: RxStatus.loading());
    try {
      final items = await _repository.getPropertiesByOwner(ownerId);
      if (items.isEmpty) {
        change([], status: RxStatus.empty());
      } else {
        change(items, status: RxStatus.success());
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> deleteListing(String id) async {
    await _repository.deleteProperty(id);
    await fetchMyListings();
  }
}
