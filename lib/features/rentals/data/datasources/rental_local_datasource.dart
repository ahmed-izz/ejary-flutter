import '../../../../core/constants/storage_keys.dart';
import '../../../../core/services/storage_service.dart';
import '../../domain/entities/rental_entity.dart';
import '../models/rental_model.dart';

class RentalLocalDataSource {
  final StorageService _storage;

  RentalLocalDataSource(this._storage) {
    _seedRentals();
  }

  void _seedRentals() {
    if (_storage.hasData(StorageKeys.rentals)) return;

    final seed = [
      RentalModel(
        id: 'rent_1',
        propertyId: 'prop_1',
        propertyTitle: 'Minimalist Linen Apartment in Al-Olaya',
        propertyCity: 'Riyadh · Al-Olaya',
        propertyImage:
            'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1000&q=80',
        tenantId: 'tenant_1',
        tenantName: 'Omar Al-Mansoor',
        ownerId: 'landlord_1',
        durationMonths: 12,
        monthlyRent: 6800,
        moveInDate: DateTime.now().add(const Duration(days: 14)),
        note: 'Looking forward to a long-term family stay.',
        status: RentalStatus.pending,
      ),
    ];

    _storage.write(
      StorageKeys.rentals,
      seed.map((e) => e.toJson()).toList(),
    );
  }

  List<RentalModel> getAll() {
    final raw = _storage.read<List<dynamic>>(StorageKeys.rentals) ?? [];
    return raw
        .map((e) => RentalModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  Future<void> saveAll(List<RentalModel> items) async {
    await _storage.write(
      StorageKeys.rentals,
      items.map((e) => e.toJson()).toList(),
    );
  }
}
