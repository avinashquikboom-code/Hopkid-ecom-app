import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_constants.dart';

class HopkidLocalStorage {
  final FlutterSecureStorage _secureStorage;

  HopkidLocalStorage({FlutterSecureStorage? secureStorage})
      : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  Future<void> saveTokens({required String token, String? refreshToken}) async {
    await _secureStorage.write(key: AppConstants.tokenStorageKey, value: token);
    if (refreshToken != null) {
      await _secureStorage.write(
        key: AppConstants.refreshTokenKey,
        value: refreshToken,
      );
    }
  }

  Future<String?> getAccessToken() =>
      _secureStorage.read(key: AppConstants.tokenStorageKey);

  Future<void> clearTokens() async {
    await _secureStorage.delete(key: AppConstants.tokenStorageKey);
    await _secureStorage.delete(key: AppConstants.refreshTokenKey);
  }

  Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppConstants.onboardingSeenKey) ?? false;
  }

  Future<void> setOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.onboardingSeenKey, true);
  }

  Future<void> saveCartEntries(List<Map<String, dynamic>> entries) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.cartStorageKey, jsonEncode(entries));
  }

  Future<List<Map<String, dynamic>>> loadCartEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(AppConstants.cartStorageKey);
    if (raw == null || raw.isEmpty) return [];
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded.cast<Map<String, dynamic>>();
  }
}
