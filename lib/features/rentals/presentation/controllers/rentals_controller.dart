import 'package:get/get.dart';

import '../../../../core/services/auth_service.dart';
import '../../domain/entities/rental_entity.dart';
import '../../domain/repositories/rental_repository.dart';

class RentalsController extends GetxController
    with StateMixin<List<RentalEntity>> {
  final RentalRepository _repository = Get.find<RentalRepository>();
  final AuthService _authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    fetchRentals();
  }

  Future<void> fetchRentals() async {
    final user = _authService.currentUser.value;
    if (user == null) return;

    change(null, status: RxStatus.loading());
    try {
      final list = user.role.isLandlord
          ? await _repository.getRequestsForOwner(user.id)
          : await _repository.getRentalsForTenant(user.id);

      if (list.isEmpty) {
        change([], status: RxStatus.empty());
      } else {
        change(list, status: RxStatus.success());
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> updateStatus(String rentalId, RentalStatus status) async {
    await _repository.updateRentalStatus(rentalId, status);
    await fetchRentals();
  }
}
