import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl(this._localDataSource);

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final users = _localDataSource.getAllUsers();

    final match = users.where(
      (u) =>
          u.email.toLowerCase() == email.trim().toLowerCase() &&
          u.password == password,
    );

    if (match.isEmpty) {
      throw Exception('invalid_credentials');
    }

    final user = match.first;
    await _localDataSource.saveSession(user);
    return user;
  }

  @override
  Future<UserEntity> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required UserRole role,
  }) async {
    await Future.delayed(const Duration(milliseconds: 550));
    final users = _localDataSource.getAllUsers();

    final exists = users.any(
      (u) => u.email.toLowerCase() == email.trim().toLowerCase(),
    );
    if (exists) {
      throw Exception('email_exists');
    }

    final newUser = UserModel(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      fullName: fullName.trim(),
      email: email.trim().toLowerCase(),
      phone: phone.trim(),
      role: role,
      password: password,
    );

    await _localDataSource.saveUser(newUser);
    await _localDataSource.saveSession(newUser);
    return newUser;
  }

  @override
  UserEntity? getCurrentUser() => _localDataSource.getSession();

  @override
  Future<void> logout() => _localDataSource.clearSession();
}
