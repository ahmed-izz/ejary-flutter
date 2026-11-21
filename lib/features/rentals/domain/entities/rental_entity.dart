enum RentalStatus {
  pending,
  approved,
  rejected,
  completed;

  String get translationKey => 'status_$name';
}

class RentalEntity {
  final String id;
  final String propertyId;
  final String propertyTitle;
  final String propertyCity;
  final String propertyImage;
  final String tenantId;
  final String tenantName;
  final String ownerId;
  final int durationMonths;
  final double monthlyRent;
  final DateTime moveInDate;
  final String note;
  final RentalStatus status;

  const RentalEntity({
    required this.id,
    required this.propertyId,
    required this.propertyTitle,
    required this.propertyCity,
    required this.propertyImage,
    required this.tenantId,
    required this.tenantName,
    required this.ownerId,
    required this.durationMonths,
    required this.monthlyRent,
    required this.moveInDate,
    this.note = '',
    this.status = RentalStatus.pending,
  });

  double get totalAmount => monthlyRent * durationMonths;
}
