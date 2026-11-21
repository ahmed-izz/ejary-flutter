import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/storage_keys.dart';
import 'storage_service.dart';

class LocaleService extends GetxService {
  final StorageService _storage = Get.find<StorageService>();

  static const Locale enLocale = Locale('en', 'US');
  static const Locale arLocale = Locale('ar', 'SA');

  final Rx<Locale> currentLocale = enLocale.obs;

  bool get isArabic => currentLocale.value.languageCode == 'ar';

  LocaleService init() {
    final savedCode = _storage.read<String>(StorageKeys.languageCode);
    if (savedCode == 'ar') {
      currentLocale.value = arLocale;
    } else {
      currentLocale.value = enLocale;
    }
    return this;
  }

  Future<void> toggleLocale() async {
    final next = isArabic ? enLocale : arLocale;
    currentLocale.value = next;
    await _storage.write(StorageKeys.languageCode, next.languageCode);
    await Get.updateLocale(next);
  }

  Future<void> setLocale(String langCode) async {
    final next = langCode == 'ar' ? arLocale : enLocale;
    currentLocale.value = next;
    await _storage.write(StorageKeys.languageCode, next.languageCode);
    await Get.updateLocale(next);
  }
}
