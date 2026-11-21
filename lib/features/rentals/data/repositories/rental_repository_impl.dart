import '../../domain/entities/rental_entity.dart';
import '../../domain/repositories/rental_repository.dart';
import '../datasources/rental_local_datasource.dart';
import '../models/rental_model.dart';

class RentalRepositoryImpl implements RentalRepository {
  final RentalLocalDataSource _localDataSource;

  RentalRepositoryImpl(this._localDataSource);

  @override
  Future<List<RentalEntity>> getRentalsForTenant(String tenantId) async {
    await Future.delayed(const Duration(milliseconds: 250));
    return _localDataSource
        .getAll()
        .where((r) => r.tenantId == tenantId)
        .toList();
  }

  @override
  Future<List<RentalEntity>> getRequestsForOwner(String ownerId) async {
    await Future.delayed(const Duration(milliseconds: 250));
    return _localDataSource
        .getAll()
        .where((r) => r.ownerId == ownerId)
        .toList();
  }

  @override
  Future<void> createRentalRequest(RentalEntity rental) async {
    final all = _localDataSource.getAll();
    all.insert(0, RentalModel.fromEntity(rental));
    await _localDataSource.saveAll(all);
  }

  @override
  Future<void> updateRentalStatus(String rentalId, RentalStatus status) async {
    final all = _localDataSource.getAll();
    final idx = all.indexWhere((r) => r.id == rentalId);
    if (idx != -1) {
      final old = all[idx];
      all[idx] = RentalModel(
        id: old.id,
        propertyId: old.propertyId,
        propertyTitle: old.propertyTitle,
        propertyCity: old.propertyCity,
        propertyImage: old.propertyImage,
        tenantId: old.tenantId,
        tenantName: old.tenantName,
        ownerId: old.ownerId,
        durationMonths: old.durationMonths,
        monthlyRent: old.monthlyRent,
        moveInDate: old.moveInDate,
        note: old.note,
        status: status,
      );
      await _localDataSource.saveAll(all);
    }
  }
}
