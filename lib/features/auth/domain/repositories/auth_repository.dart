import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login({
    required String email,
    required String password,
  });

  Future<UserEntity> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required UserRole role,
  });

  UserEntity? getCurrentUser();
  Future<void> logout();
}
