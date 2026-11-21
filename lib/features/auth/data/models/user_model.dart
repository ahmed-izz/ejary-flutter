import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String password;

  const UserModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.phone,
    required super.role,
    super.avatarUrl,
    this.password = '',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      role: UserRole.values.firstWhere(
        (r) => r.name == json['role'],
        orElse: () => UserRole.tenant,
      ),
      avatarUrl: json['avatarUrl'] as String?,
      password: (json['password'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'role': role.name,
      'avatarUrl': avatarUrl,
      'password': password,
    };
  }
}
