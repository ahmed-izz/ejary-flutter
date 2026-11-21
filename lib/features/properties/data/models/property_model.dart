import '../../domain/entities/property_entity.dart';

class PropertyModel extends PropertyEntity {
  const PropertyModel({
    required super.id,
    required super.ownerId,
    required super.ownerName,
    required super.title,
    required super.description,
    required super.city,
    required super.monthlyPrice,
    required super.bedrooms,
    required super.bathrooms,
    required super.areaSqm,
    required super.type,
    required super.imageUrls,
    required super.amenities,
    super.isAvailable = true,
  });

  factory PropertyModel.fromEntity(PropertyEntity entity) {
    return PropertyModel(
      id: entity.id,
      ownerId: entity.ownerId,
      ownerName: entity.ownerName,
      title: entity.title,
      description: entity.description,
      city: entity.city,
      monthlyPrice: entity.monthlyPrice,
      bedrooms: entity.bedrooms,
      bathrooms: entity.bathrooms,
      areaSqm: entity.areaSqm,
      type: entity.type,
      imageUrls: entity.imageUrls,
      amenities: entity.amenities,
      isAvailable: entity.isAvailable,
    );
  }

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'] as String,
      ownerId: json['ownerId'] as String,
      ownerName: json['ownerName'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      city: json['city'] as String,
      monthlyPrice: (json['monthlyPrice'] as num).toDouble(),
      bedrooms: json['bedrooms'] as int,
      bathrooms: json['bathrooms'] as int,
      areaSqm: (json['areaSqm'] as num).toDouble(),
      type: PropertyType.values.firstWhere(
        (t) => t.name == json['type'],
        orElse: () => PropertyType.apartment,
      ),
      imageUrls: List<String>.from(json['imageUrls'] as List),
      amenities: List<String>.from(json['amenities'] as List),
      isAvailable: (json['isAvailable'] as bool?) ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ownerId': ownerId,
      'ownerName': ownerName,
      'title': title,
      'description': description,
      'city': city,
      'monthlyPrice': monthlyPrice,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'areaSqm': areaSqm,
      'type': type.name,
      'imageUrls': imageUrls,
      'amenities': amenities,
      'isAvailable': isAvailable,
    };
  }
}
