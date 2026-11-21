import 'package:get/get.dart';

import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../services/auth_service.dart';
import '../services/storage_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    final storage = Get.find<StorageService>();

    final authLocal = AuthLocalDataSource(storage);
    final authRepo = Get.put<AuthRepository>(
      AuthRepositoryImpl(authLocal),
      permanent: true,
    );

    Get.put<AuthService>(
      AuthService().init(authRepo),
      permanent: true,
    );
  }
}
