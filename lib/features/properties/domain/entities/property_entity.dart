enum PropertyType {
  apartment,
  villa,
  studio,
  office;

  String get translationKey => name;
}

class PropertyEntity {
  final String id;
  final String ownerId;
  final String ownerName;
  final String title;
  final String description;
  final String city;
  final double monthlyPrice;
  final int bedrooms;
  final int bathrooms;
  final double areaSqm;
  final PropertyType type;
  final List<String> imageUrls;
  final List<String> amenities;
  final bool isAvailable;

  const PropertyEntity({
    required this.id,
    required this.ownerId,
    required this.ownerName,
    required this.title,
    required this.description,
    required this.city,
    required this.monthlyPrice,
    required this.bedrooms,
    required this.bathrooms,
    required this.areaSqm,
    required this.type,
    required this.imageUrls,
    required this.amenities,
    this.isAvailable = true,
  });
}
