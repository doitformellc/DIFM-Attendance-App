import 'package:flutter/material.dart';
import 'package:difm_attendance_app/core/services/auth_service.dart';
import 'package:difm_attendance_app/core/services/storage_service.dart';

class AuthController {
  static Future<void> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final response = await AuthService.login(
        email: email,
        password: password,
      );

      print("========= API RESPONSE =========");
      print(response);

      final user = _readUser(response);

      print("USER:");
      print(user);

      final backendRole = _readString(user, 'role') ?? '';

      final policyAccepted =
          _readBool(user, 'policyAccepted') ??
          _readBool(response, 'policyAccepted') ??
          false;

      if (backendRole.isEmpty) {
        throw Exception('Role missing in API response');
      }

      String role;

      switch (backendRole.toUpperCase()) {
        case 'INTERN':
          role = 'intern';
          break;

        case 'HR':
        case 'HR_ADMIN':
          role = 'hr';
          break;

        case 'ADMIN':
        case 'SUPER_ADMIN':
          role = 'admin';
          break;

        default:
          throw Exception("Unknown role: $backendRole");
      }

      print("ROLE = $role");

      if (!context.mounted) return;

      if (!policyAccepted && role == 'intern') {
        Navigator.pushReplacementNamed(
          context,
          '/policy',
          arguments: {'role': role},
        );

        return;
      }

      switch (role) {
        case 'intern':
          Navigator.pushReplacementNamed(context, '/intern-dashboard');
          break;

        case 'hr':
          Navigator.pushReplacementNamed(context, '/hr-dashboard');
          break;

        case 'admin':
          Navigator.pushReplacementNamed(context, '/admin-dashboard');
          break;
      }
    } catch (e) {
      print("LOGIN ERROR:");
      print(e);

      if (!context.mounted) return;

      _showErrorDialog(context, e.toString());
    }
  }

  static Future<void> logout(BuildContext context) async {
    try {
      await AuthService.logout();

      await StorageService.clearAll();

      if (!context.mounted) return;

      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } catch (e) {
      print('LOGOUT ERROR: $e');

      if (!context.mounted) return;

      _showErrorDialog(context, e.toString());
    }
  }

  static Map? _readUser(dynamic response) {
    if (response is! Map) {
      return null;
    }

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

  static bool? _readBool(dynamic source, String key) {
    if (source is! Map) {
      return null;
    }

    final value = source[key];
    if (value is bool) {
      return value;
    }

    if (value is String) {
      return value.toLowerCase() == 'true';
    }

    return null;
  }

  static void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [Color(0xff111827), Color(0xff1e293b)],
              ),
              border: Border.all(color: Colors.redAccent.withOpacity(.4)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red.withOpacity(.15),
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.redAccent,
                    size: 45,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Login Failed',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade400),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'TRY AGAIN',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
