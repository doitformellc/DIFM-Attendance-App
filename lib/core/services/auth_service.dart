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
      body: {'email': email, 'password': password},
    );

    if (response is! Map) {
      throw Exception('Invalid login response');
    }

    final user = _readUser(response);
    final accessToken = _readFirstString(response, const [
      'accessToken',
      'access_token',
      'token',
      'jwt',
      'access',
    ]);
    final refreshToken = _readFirstString(response, const [
      'refreshToken',
      'refresh_token',
      'refresh',
    ]);

    if (accessToken == null || accessToken.isEmpty) {
      throw Exception('Access token missing');
    }

    await StorageService.saveAccessToken(accessToken);

    if (refreshToken != null && refreshToken.isNotEmpty) {
      await StorageService.saveRefreshToken(refreshToken);
    }

    // SAVE USER DATA
    final role = _readString(user, 'role') ?? _readString(response, 'role');

    if (role != null && role.isNotEmpty) {
      await StorageService.saveUserRole(role);
    }

    final userEmail =
        _readString(user, 'email') ?? _readString(response, 'email') ?? email;

    await StorageService.saveUserEmail(userEmail);

    return response;
  }

  // =========================
  // REFRESH TOKEN
  // =========================
  static Future<bool> refreshToken() async {
    try {
      final refreshToken = await StorageService.getRefreshToken();

      if (refreshToken == null) {
        return false;
      }

      final response = await ApiService.post(
        url: '${ApiConstants.baseUrl}${ApiConstants.refresh}',
        body: {'refreshToken': refreshToken},
      );

      if (response is! Map) {
        return false;
      }

      final accessToken = _readFirstString(response, const [
        'accessToken',
        'access_token',
        'token',
        'jwt',
        'access',
      ]);
      final newRefreshToken = _readFirstString(response, const [
        'refreshToken',
        'refresh_token',
        'refresh',
      ]);

      if (accessToken == null || accessToken.isEmpty) {
        return false;
      }

      await StorageService.saveAccessToken(accessToken);

      if (newRefreshToken != null && newRefreshToken.isNotEmpty) {
        await StorageService.saveRefreshToken(newRefreshToken);
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  // =========================
  // CHECK LOGIN STATUS
  // =========================
  static Future<bool> isLoggedIn() async {
    final token = await StorageService.getAccessToken();

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
      final refreshToken = await StorageService.getRefreshToken();

      // OPTIONAL BACKEND LOGOUT API
      await ApiService.post(
        url: '${ApiConstants.baseUrl}${ApiConstants.logout}',
        body: {'refreshToken': refreshToken},
      );
    } catch (e) {
      // Ignore API errors during logout
    }

    // CLEAR LOCAL STORAGE
    await StorageService.clearAll();
  }

  static Map? _readUser(Map response) {
    final user = response['user'];
    if (user is Map) {
      return user;
    }

    final data = response['data'];
    if (data is Map) {
      final nestedUser = data['user'];
      if (nestedUser is Map) {
        return nestedUser;
      }

      return data;
    }

    return response;
  }

  static String? _readString(Map? source, String key) {
    final value = source?[key];
    return value?.toString();
  }

  static String? _readFirstString(Map source, List<String> keys) {
    for (final key in keys) {
      final value = _findValue(source, key);
      if (value == null) {
        continue;
      }

      final text = value.toString();
      if (text.isNotEmpty) {
        return text;
      }
    }

    return null;
  }

  static dynamic _findValue(dynamic source, String key) {
    if (source is Map) {
      for (final entry in source.entries) {
        if (entry.key.toString() == key) {
          return entry.value;
        }
      }

      for (final value in source.values) {
        final found = _findValue(value, key);
        if (found != null) {
          return found;
        }
      }
    }

    if (source is List) {
      for (final value in source) {
        final found = _findValue(value, key);
        if (found != null) {
          return found;
        }
      }
    }

    return null;
  }
}
