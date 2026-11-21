enum UserRole {
  tenant,
  landlord;

  bool get isLandlord => this == UserRole.landlord;
  bool get isTenant => this == UserRole.tenant;
}

class UserEntity {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final UserRole role;
  final String? avatarUrl;

  const UserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.role,
    this.avatarUrl,
  });
}
