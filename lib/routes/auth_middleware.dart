import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/services/auth_service.dart';
import 'app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final authService = Get.find<AuthService>();
    if (!authService.isLoggedIn) {
      return const RouteSettings(name: AppRoutes.login);
    }
    return null;
  }
}

class GuestMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final authService = Get.find<AuthService>();
    if (authService.isLoggedIn) {
      return const RouteSettings(name: AppRoutes.shell);
    }
    return null;
  }
}
