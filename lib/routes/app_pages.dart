import 'package:get/get.dart';

import '../features/auth/presentation/bindings/auth_binding.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/register_page.dart';
import '../features/onboarding/presentation/bindings/onboarding_binding.dart';
import '../features/onboarding/presentation/pages/onboarding_page.dart';
import '../features/onboarding/presentation/pages/splash_page.dart';
import '../features/properties/presentation/bindings/properties_binding.dart';
import '../features/properties/presentation/pages/property_details_page.dart';
import '../features/properties/presentation/pages/property_form_page.dart';
import '../features/rentals/presentation/bindings/rentals_binding.dart';
import '../features/rentals/presentation/pages/rental_request_page.dart';
import '../features/shell/presentation/bindings/shell_binding.dart';
import '../features/shell/presentation/pages/shell_page.dart';
import 'app_routes.dart';
import 'auth_middleware.dart';

abstract final class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingPage(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: AuthBinding(),
      middlewares: [GuestMiddleware()],
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterPage(),
      binding: AuthBinding(),
      middlewares: [GuestMiddleware()],
    ),
    GetPage(
      name: AppRoutes.shell,
      page: () => const ShellPage(),
      binding: ShellBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.propertyDetails,
      page: () => const PropertyDetailsPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.propertyForm,
      page: () => const PropertyFormPage(),
      binding: PropertyFormBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.rentalRequest,
      page: () => const RentalRequestPage(),
      binding: RentalRequestBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
