import 'package:get/get.dart';

import '../../../../core/services/storage_service.dart';
import '../../../favorites/data/repositories/favorites_repository_impl.dart';
import '../../../favorites/domain/repositories/favorites_repository.dart';
import '../../../favorites/presentation/controllers/favorites_controller.dart';
import '../../../profile/presentation/controllers/profile_controller.dart';
import '../../../properties/data/datasources/property_local_datasource.dart';
import '../../../properties/data/repositories/property_repository_impl.dart';
import '../../../properties/domain/repositories/property_repository.dart';
import '../../../properties/presentation/controllers/explore_controller.dart';
import '../../../properties/presentation/controllers/my_listings_controller.dart';
import '../../../rentals/data/datasources/rental_local_datasource.dart';
import '../../../rentals/data/repositories/rental_repository_impl.dart';
import '../../../rentals/domain/repositories/rental_repository.dart';
import '../../../rentals/presentation/controllers/rentals_controller.dart';
import '../controllers/shell_controller.dart';

class ShellBinding extends Bindings {
  @override
  void dependencies() {
    final storage = Get.find<StorageService>();

    Get.lazyPut<PropertyRepository>(
      () => PropertyRepositoryImpl(PropertyLocalDataSource(storage)),
      fenix: true,
    );
    Get.lazyPut<RentalRepository>(
      () => RentalRepositoryImpl(RentalLocalDataSource(storage)),
      fenix: true,
    );
    Get.lazyPut<FavoritesRepository>(
      () => FavoritesRepositoryImpl(storage),
      fenix: true,
    );

    Get.lazyPut<ShellController>(() => ShellController());
    Get.lazyPut<ExploreController>(() => ExploreController());
    Get.lazyPut<MyListingsController>(() => MyListingsController());
    Get.lazyPut<RentalsController>(() => RentalsController());
    Get.lazyPut<FavoritesController>(() => FavoritesController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
