import '../constants/api_constants.dart';
import 'api_service.dart';
import 'storage_service.dart';

class AuthService {
  // =========================
  // LOGIN
  // =========================
  static Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    final response = await ApiService.post(
      url: '${ApiConstants.baseUrl}${ApiConstants.login}',
      body: {
        'email': email,
        'password': password,
      },
    );

    // SAVE TOKENS
    await StorageService.saveAccessToken(
      response['accessToken'],
    );

    await StorageService.saveRefreshToken(
      response['refreshToken'],
    );

    // SAVE USER DATA
    await StorageService.saveUserRole(
      response['user']['role'],
    );

    await StorageService.saveUserEmail(
      response['user']['email'],
    );

    return response;
  }

  // =========================
  // REFRESH TOKEN
  // =========================
  static Future<bool> refreshToken() async {
    try {
      final refreshToken =
          await StorageService.getRefreshToken();

      if (refreshToken == null) {
        return false;
      }

      final response = await ApiService.post(
        url: '${ApiConstants.baseUrl}${ApiConstants.refresh}',
        body: {
          'refreshToken': refreshToken,
        },
      );

      await StorageService.saveAccessToken(
        response['accessToken'],
      );

      await StorageService.saveRefreshToken(
        response['refreshToken'],
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  // =========================
  // CHECK LOGIN STATUS
  // =========================
  static Future<bool> isLoggedIn() async {
    final token =
        await StorageService.getAccessToken();

    return token != null;
  }

  // =========================
  // GET USER ROLE
  // =========================
  static Future<String?> getUserRole() async {
    return await StorageService.getUserRole();
  }

  // =========================
  // GET USER EMAIL
  // =========================
  static Future<String?> getUserEmail() async {
    return await StorageService.getUserEmail();
  }

  // =========================
  // LOGOUT
  // =========================
  static Future<void> logout() async {
    try {
      final refreshToken =
          await StorageService.getRefreshToken();

      // OPTIONAL BACKEND LOGOUT API
      await ApiService.post(
        url: '${ApiConstants.baseUrl}${ApiConstants.logout}',
        body: {
          'refreshToken': refreshToken,
        },
      );
    } catch (e) {
      // Ignore API errors during logout
    }

    // CLEAR LOCAL STORAGE
    await StorageService.clearAll();
  }
}