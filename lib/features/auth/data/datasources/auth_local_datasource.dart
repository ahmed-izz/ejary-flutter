import '../../../../core/constants/storage_keys.dart';
import '../../../../core/services/storage_service.dart';
import '../../domain/entities/user_entity.dart';
import '../models/user_model.dart';

class AuthLocalDataSource {
  final StorageService _storage;

  AuthLocalDataSource(this._storage) {
    _seedInitialUsers();
  }

  void _seedInitialUsers() {
    if (_storage.hasData(StorageKeys.users)) return;

    final seedUsers = [
      const UserModel(
        id: 'tenant_1',
        fullName: 'Omar Al-Mansoor',
        email: 'tenant@ejary.sa',
        phone: '+966 50 123 4567',
        role: UserRole.tenant,
        password: 'password123',
      ),
      const UserModel(
        id: 'landlord_1',
        fullName: 'Layla Al-Harbi',
        email: 'owner@ejary.sa',
        phone: '+966 55 987 6543',
        role: UserRole.landlord,
        password: 'password123',
      ),
    ];

    _storage.write(
      StorageKeys.users,
      seedUsers.map((u) => u.toJson()).toList(),
    );
  }

  List<UserModel> getAllUsers() {
    final raw = _storage.read<List<dynamic>>(StorageKeys.users) ?? [];
    return raw
        .map((e) => UserModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  Future<void> saveUser(UserModel user) async {
    final users = getAllUsers()..add(user);
    await _storage.write(
      StorageKeys.users,
      users.map((u) => u.toJson()).toList(),
    );
  }

  Future<void> saveSession(UserModel user) async {
    await _storage.write(StorageKeys.currentUser, user.toJson());
  }

  UserModel? getSession() {
    final raw = _storage.read<Map<dynamic, dynamic>>(StorageKeys.currentUser);
    if (raw == null) return null;
    return UserModel.fromJson(Map<String, dynamic>.from(raw));
  }

  Future<void> clearSession() async {
    await _storage.remove(StorageKeys.currentUser);
  }
}
