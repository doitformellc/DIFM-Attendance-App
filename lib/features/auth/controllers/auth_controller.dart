import 'package:flutter/material.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/constants/policy_constants.dart';

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

      final user = response['user'];
      final role = user['role'].toString().toLowerCase();

      final policyAccepted = user['policyAccepted'] ?? false;

      if (!context.mounted) return;

      // POLICY GATE
      if (!policyAccepted) {
        Navigator.pushReplacementNamed(
          context,
          '/policy',
          arguments: {'role': role},
        );
        return;
      }

      // ROLE BASED REDIRECT
      final savedPolicyVersion = await StorageService.getPolicyVersion();

      if (!context.mounted) return;

      if (savedPolicyVersion != PolicyConstants.currentPolicyVersion) {
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
      if (!context.mounted) return;

      _showErrorDialog(context, 'Invalid email or password');
    }
  }

  static Future<void> logout(BuildContext context) async {
    await AuthService.logout();

    if (!context.mounted) return;

    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
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
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),

              border: Border.all(color: Colors.redAccent.withOpacity(.4)),

              boxShadow: [
                BoxShadow(
                  color: Colors.redAccent.withOpacity(.15),
                  blurRadius: 25,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.redAccent.withOpacity(.15),
                  ),
                  child: const Icon(
                    Icons.error_outline_rounded,
                    color: Colors.redAccent,
                    size: 48,
                  ),
                ),

                const SizedBox(height: 24),

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
                  style: TextStyle(color: Colors.grey.shade300, height: 1.6),
                ),

                const SizedBox(height: 28),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'TRY AGAIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
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
