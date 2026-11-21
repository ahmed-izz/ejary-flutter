abstract class FavoritesRepository {
  List<String> getFavoriteIds(String userId);
  Future<void> saveFavoriteIds(String userId, List<String> ids);
}
