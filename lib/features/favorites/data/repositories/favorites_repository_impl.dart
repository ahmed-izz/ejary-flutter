import '../../../../core/constants/storage_keys.dart';
import '../../../../core/services/storage_service.dart';
import '../../domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final StorageService _storage;

  FavoritesRepositoryImpl(this._storage);

  String _key(String userId) => '${StorageKeys.favorites}_$userId';

  @override
  List<String> getFavoriteIds(String userId) {
    final raw = _storage.read<List<dynamic>>(_key(userId)) ?? [];
    return raw.map((e) => e.toString()).toList();
  }

  @override
  Future<void> saveFavoriteIds(String userId, List<String> ids) async {
    await _storage.write(_key(userId), ids);
  }
}
