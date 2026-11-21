import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'core/bindings/initial_binding.dart';
import 'core/localization/app_translations.dart';
import 'core/services/locale_service.dart';
import 'core/services/storage_service.dart';
import 'core/services/theme_service.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initCoreServices();
  runApp(const EjaryApp());
}

Future<void> _initCoreServices() async {
  await Get.putAsync<StorageService>(() => StorageService().init());
  Get.put<ThemeService>(ThemeService().init(), permanent: true);
  Get.put<LocaleService>(LocaleService().init(), permanent: true);
}

class EjaryApp extends StatelessWidget {
  const EjaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Get.find<ThemeService>();
    final localeService = Get.find<LocaleService>();

    return GetMaterialApp(
      title: 'Ejary',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeService.themeMode,
      translations: AppTranslations(),
      locale: localeService.currentLocale.value,
      fallbackLocale: LocaleService.enLocale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ar', 'SA'),
      ],
      initialBinding: InitialBinding(),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}
