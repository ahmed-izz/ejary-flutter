import '../entities/property_entity.dart';

abstract class PropertyRepository {
  Future<List<PropertyEntity>> getProperties({
    String? query,
    PropertyType? type,
  });

  Future<List<PropertyEntity>> getPropertiesByOwner(String ownerId);

  Future<PropertyEntity?> getPropertyById(String id);

  Future<void> addProperty(PropertyEntity property);

  Future<void> updateProperty(PropertyEntity property);

  Future<void> deleteProperty(String id);
}
