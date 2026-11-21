import '../entities/rental_entity.dart';

abstract class RentalRepository {
  Future<List<RentalEntity>> getRentalsForTenant(String tenantId);
  Future<List<RentalEntity>> getRequestsForOwner(String ownerId);
  Future<void> createRentalRequest(RentalEntity rental);
  Future<void> updateRentalStatus(String rentalId, RentalStatus status);
}
