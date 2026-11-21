import 'package:get/get.dart';

import '../../../../core/services/auth_service.dart';
import '../../../properties/domain/entities/property_entity.dart';
import '../../../properties/domain/repositories/property_repository.dart';
import '../../domain/repositories/favorites_repository.dart';

class FavoritesController extends GetxController {
  final FavoritesRepository _favRepo = Get.find<FavoritesRepository>();
  final PropertyRepository _propRepo = Get.find<PropertyRepository>();
  final AuthService _authService = Get.find<AuthService>();

  final RxSet<String> favoriteIds = <String>{}.obs;
  final RxList<PropertyEntity> favoriteProperties = <PropertyEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final userId = _authService.currentUser.value?.id;
    if (userId == null) return;

    favoriteIds.assignAll(_favRepo.getFavoriteIds(userId));
    await _syncFavoriteProperties();
  }

  bool isFavorite(String propertyId) => favoriteIds.contains(propertyId);

  Future<void> toggleFavorite(String propertyId) async {
    final userId = _authService.currentUser.value?.id;
    if (userId == null) return;

    if (favoriteIds.contains(propertyId)) {
      favoriteIds.remove(propertyId);
    } else {
      favoriteIds.add(propertyId);
    }

    await _favRepo.saveFavoriteIds(userId, favoriteIds.toList());
    await _syncFavoriteProperties();
  }

  Future<void> _syncFavoriteProperties() async {
    final all = await _propRepo.getProperties();
    favoriteProperties.assignAll(
      all.where((p) => favoriteIds.contains(p.id)).toList(),
    );
  }
}
