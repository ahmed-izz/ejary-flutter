import '../../../../core/constants/storage_keys.dart';
import '../../../../core/services/storage_service.dart';
import '../../domain/entities/property_entity.dart';
import '../models/property_model.dart';

class PropertyLocalDataSource {
  final StorageService _storage;

  PropertyLocalDataSource(this._storage) {
    _seedProperties();
  }

  void _seedProperties() {
    if (_storage.hasData(StorageKeys.properties)) return;

    final initial = [
      const PropertyModel(
        id: 'prop_1',
        ownerId: 'landlord_1',
        ownerName: 'Layla Al-Harbi',
        title: 'Minimalist Linen Apartment in Al-Olaya',
        description:
            'Sunlit two-bedroom residence with natural oak finishes, floor-to-ceiling windows, and quiet courtyard views in the heart of Al-Olaya.',
        city: 'Riyadh · Al-Olaya',
        monthlyPrice: 6800,
        bedrooms: 2,
        bathrooms: 2,
        areaSqm: 135,
        type: PropertyType.apartment,
        imageUrls: [
          'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1000&q=80',
          'https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?auto=format&fit=crop&w=1000&q=80',
        ],
        amenities: [
          'Fiber Wi-Fi',
          'Central AC',
          'Private Parking',
          'Gym Access'
        ],
      ),
      const PropertyModel(
        id: 'prop_2',
        ownerId: 'landlord_1',
        ownerName: 'Layla Al-Harbi',
        title: 'Courtyard Desert Villa in Diriyah',
        description:
            'Architectural mud-tone modern villa featuring a shaded olive-tree patio, high ceilings, and serene indoor-outdoor living.',
        city: 'Riyadh · Diriyah',
        monthlyPrice: 14500,
        bedrooms: 4,
        bathrooms: 4,
        areaSqm: 340,
        type: PropertyType.villa,
        imageUrls: [
          'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?auto=format&fit=crop&w=1000&q=80',
          'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?auto=format&fit=crop&w=1000&q=80',
        ],
        amenities: [
          'Private Garden',
          'Smart Lock',
          'Maid Room',
          '2-Car Garage'
        ],
      ),
      const PropertyModel(
        id: 'prop_3',
        ownerId: 'landlord_1',
        ownerName: 'Layla Al-Harbi',
        title: 'Coastal Breeze Studio · Al-Shati',
        description:
            'Thoughtfully designed studio steps away from the Corniche. Ideal for remote professionals seeking calm and natural light.',
        city: 'Jeddah · Al-Shati',
        monthlyPrice: 3900,
        bedrooms: 1,
        bathrooms: 1,
        areaSqm: 58,
        type: PropertyType.studio,
        imageUrls: [
          'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?auto=format&fit=crop&w=1000&q=80',
          'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=1000&q=80',
        ],
        amenities: ['Sea View', 'Furnished', '24/7 Security', 'Laundry'],
      ),
      const PropertyModel(
        id: 'prop_4',
        ownerId: 'landlord_2',
        ownerName: 'Tariq Al-Qahtani',
        title: 'Boutique Creative Office Loft',
        description:
            'Open-plan workspace with acoustic timber slats, meeting alcove, and espresso bar setup.',
        city: 'Al Khobar · Corniche',
        monthlyPrice: 8200,
        bedrooms: 2,
        bathrooms: 2,
        areaSqm: 160,
        type: PropertyType.office,
        imageUrls: [
          'https://images.unsplash.com/photo-1497366216548-37526070297c?auto=format&fit=crop&w=1000&q=80',
        ],
        amenities: ['Meeting Room', 'High-Speed Fiber', 'Reception', 'Parking'],
      ),
    ];

    _storage.write(
      StorageKeys.properties,
      initial.map((e) => e.toJson()).toList(),
    );
  }

  List<PropertyModel> getAll() {
    final raw = _storage.read<List<dynamic>>(StorageKeys.properties) ?? [];
    return raw
        .map((e) => PropertyModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  Future<void> saveAll(List<PropertyModel> items) async {
    await _storage.write(
      StorageKeys.properties,
      items.map((e) => e.toJson()).toList(),
    );
  }
}
