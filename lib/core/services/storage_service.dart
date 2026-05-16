import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
class StorageService {
  static const FlutterSecureStorage _storage =
      FlutterSecureStorage();

  // ACCESS TOKEN
  static Future<void> saveAccessToken(
      String token) async {
    await _storage.write(
      key: 'accessToken',
      value: token,
    );
  }

  static Future<void> savePolicyVersion(
  String version,
) async {
  final prefs =
      await SharedPreferences.getInstance();

  await prefs.setString(
    'policy_version',
    version,
  );
}

static Future<String?> getPolicyVersion()
async {
  final prefs =
      await SharedPreferences.getInstance();

  return prefs.getString(
    'policy_version',
  );
}

  static Future<String?> getAccessToken() async {
    return await _storage.read(
      key: 'accessToken',
    );
  }

  // REFRESH TOKEN
  static Future<void> saveRefreshToken(
      String token) async {
    await _storage.write(
      key: 'refreshToken',
      value: token,
    );
  }

  static Future<String?> getRefreshToken() async {
    return await _storage.read(
      key: 'refreshToken',
    );
  }

  // USER ROLE
  static Future<void> saveUserRole(
      String role) async {
    await _storage.write(
      key: 'userRole',
      value: role,
    );
  }

  static Future<String?> getUserRole() async {
    return await _storage.read(
      key: 'userRole',
    );
  }

  // USER EMAIL
  static Future<void> saveUserEmail(
      String email) async {
    await _storage.write(
      key: 'userEmail',
      value: email,
    );
  }

  static Future<String?> getUserEmail() async {
    return await _storage.read(
      key: 'userEmail',
    );
  }

  // CLEAR ALL
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}