import 'package:get/get.dart';

import '../../features/auth/domain/entities/user_entity.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';

class AuthService extends GetxService {
  final Rxn<UserEntity> currentUser = Rxn<UserEntity>();

  bool get isLoggedIn => currentUser.value != null;
  bool get isLandlord => currentUser.value?.role.isLandlord ?? false;
  bool get isTenant => currentUser.value?.role.isTenant ?? true;

  AuthService init(AuthRepository repository) {
    currentUser.value = repository.getCurrentUser();
    return this;
  }

  void setUser(UserEntity user) {
    currentUser.value = user;
  }

  Future<void> signOut(AuthRepository repository) async {
    await repository.logout();
    currentUser.value = null;
  }
}
