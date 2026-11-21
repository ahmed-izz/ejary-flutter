import '../../domain/entities/property_entity.dart';
import '../../domain/repositories/property_repository.dart';
import '../datasources/property_local_datasource.dart';
import '../models/property_model.dart';

class PropertyRepositoryImpl implements PropertyRepository {
  final PropertyLocalDataSource _localDataSource;

  PropertyRepositoryImpl(this._localDataSource);

  @override
  Future<List<PropertyEntity>> getProperties({
    String? query,
    PropertyType? type,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    var list = _localDataSource.getAll();

    if (type != null) {
      list = list.where((p) => p.type == type).toList();
    }

    if (query != null && query.trim().isNotEmpty) {
      final q = query.trim().toLowerCase();
      list = list
          .where((p) =>
              p.title.toLowerCase().contains(q) ||
              p.city.toLowerCase().contains(q) ||
              p.description.toLowerCase().contains(q))
          .toList();
    }

    return list;
  }

  @override
  Future<List<PropertyEntity>> getPropertiesByOwner(String ownerId) async {
    await Future.delayed(const Duration(milliseconds: 250));
    return _localDataSource
        .getAll()
        .where((p) => p.ownerId == ownerId)
        .toList();
  }

  @override
  Future<PropertyEntity?> getPropertyById(String id) async {
    final all = _localDataSource.getAll();
    final matches = all.where((p) => p.id == id);
    return matches.isEmpty ? null : matches.first;
  }

  @override
  Future<void> addProperty(PropertyEntity property) async {
    final all = _localDataSource.getAll();
    all.insert(0, PropertyModel.fromEntity(property));
    await _localDataSource.saveAll(all);
  }

  @override
  Future<void> updateProperty(PropertyEntity property) async {
    final all = _localDataSource.getAll();
    final idx = all.indexWhere((p) => p.id == property.id);
    if (idx != -1) {
      all[idx] = PropertyModel.fromEntity(property);
      await _localDataSource.saveAll(all);
    }
  }

  @override
  Future<void> deleteProperty(String id) async {
    final all = _localDataSource.getAll()..removeWhere((p) => p.id == id);
    await _localDataSource.saveAll(all);
  }
}
