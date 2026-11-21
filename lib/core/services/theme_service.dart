import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/storage_keys.dart';
import 'storage_service.dart';

class ThemeService extends GetxService {
  final StorageService _storage = Get.find<StorageService>();

  final RxBool _isDarkMode = false.obs;
  bool get isDarkMode => _isDarkMode.value;
  ThemeMode get themeMode =>
      _isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  ThemeService init() {
    _isDarkMode.value = _storage.read<bool>(StorageKeys.isDarkMode) ?? false;
    return this;
  }

  Future<void> toggleTheme() async {
    _isDarkMode.value = !_isDarkMode.value;
    Get.changeThemeMode(themeMode);
    await _storage.write(StorageKeys.isDarkMode, _isDarkMode.value);
  }
}
