import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/auth_service.dart';
import '../../../favorites/presentation/pages/favorites_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../properties/presentation/pages/explore_page.dart';
import '../../../properties/presentation/pages/my_listings_page.dart';
import '../../../rentals/presentation/pages/rentals_page.dart';
import '../controllers/shell_controller.dart';

class ShellPage extends GetView<ShellController> {
  const ShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandlord = Get.find<AuthService>().isLandlord;

    final pages = isLandlord
        ? const [
            MyListingsPage(),
            RentalsPage(),
            ExplorePage(),
            ProfilePage(),
          ]
        : const [
            ExplorePage(),
            FavoritesPage(),
            RentalsPage(),
            ProfilePage(),
          ];

    final navItems = isLandlord
        ? [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_work_outlined),
              label: 'nav_listings'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.inbox_outlined),
              label: 'nav_requests'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.explore_outlined),
              label: 'nav_explore'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline_rounded),
              label: 'nav_profile'.tr,
            ),
          ]
        : [
            BottomNavigationBarItem(
              icon: const Icon(Icons.explore_outlined),
              label: 'nav_explore'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.favorite_border_rounded),
              label: 'nav_favorites'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.description_outlined),
              label: 'nav_rentals'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline_rounded),
              label: 'nav_profile'.tr,
            ),
          ];

    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: pages,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border:
                Border(top: BorderSide(color: Theme.of(context).dividerColor)),
          ),
          child: BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changeTab,
            items: navItems,
          ),
        ),
      ),
    );
  }
}
