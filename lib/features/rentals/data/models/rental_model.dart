import '../../domain/entities/rental_entity.dart';

class RentalModel extends RentalEntity {
  const RentalModel({
    required super.id,
    required super.propertyId,
    required super.propertyTitle,
    required super.propertyCity,
    required super.propertyImage,
    required super.tenantId,
    required super.tenantName,
    required super.ownerId,
    required super.durationMonths,
    required super.monthlyRent,
    required super.moveInDate,
    super.note = '',
    super.status = RentalStatus.pending,
  });

  factory RentalModel.fromEntity(RentalEntity entity) {
    return RentalModel(
      id: entity.id,
      propertyId: entity.propertyId,
      propertyTitle: entity.propertyTitle,
      propertyCity: entity.propertyCity,
      propertyImage: entity.propertyImage,
      tenantId: entity.tenantId,
      tenantName: entity.tenantName,
      ownerId: entity.ownerId,
      durationMonths: entity.durationMonths,
      monthlyRent: entity.monthlyRent,
      moveInDate: entity.moveInDate,
      note: entity.note,
      status: entity.status,
    );
  }

  factory RentalModel.fromJson(Map<String, dynamic> json) {
    return RentalModel(
      id: json['id'] as String,
      propertyId: json['propertyId'] as String,
      propertyTitle: json['propertyTitle'] as String,
      propertyCity: json['propertyCity'] as String,
      propertyImage: json['propertyImage'] as String,
      tenantId: json['tenantId'] as String,
      tenantName: json['tenantName'] as String,
      ownerId: json['ownerId'] as String,
      durationMonths: json['durationMonths'] as int,
      monthlyRent: (json['monthlyRent'] as num).toDouble(),
      moveInDate: DateTime.parse(json['moveInDate'] as String),
      note: (json['note'] as String?) ?? '',
      status: RentalStatus.values.firstWhere(
        (s) => s.name == json['status'],
        orElse: () => RentalStatus.pending,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'propertyId': propertyId,
      'propertyTitle': propertyTitle,
      'propertyCity': propertyCity,
      'propertyImage': propertyImage,
      'tenantId': tenantId,
      'tenantName': tenantName,
      'ownerId': ownerId,
      'durationMonths': durationMonths,
      'monthlyRent': monthlyRent,
      'moveInDate': moveInDate.toIso8601String(),
      'note': note,
      'status': status.name,
    };
  }
}
