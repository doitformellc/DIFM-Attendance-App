import 'package:flutter/material.dart';
import 'package:difm_attendance_app/core/services/storage_service.dart';
import 'package:difm_attendance_app/core/constants/policy_constants.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


bool isPasswordVisible = false;

  void showLoginError() {
  showDialog(
    context: context,
    builder: (_) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: const LinearGradient(
              colors: [
                Color(0xff111827),
                Color(0xff1e293b),
              ],
            ),
            border: Border.all(
              color: Colors.redAccent.withOpacity(.4),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red.withOpacity(.15),
                ),
                child: const Icon(
                  Icons.close_rounded,
                  size: 45,
                  color: Colors.redAccent,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Login Failed",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                "Incorrect email or password",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade400,
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.redAccent,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        14,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "TRY AGAIN",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

  Widget _buildRoleCard({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.4),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff0f172a),
              Color(0xff111827),
              Color(0xff1e293b),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.08),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 25,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // TOP ICON
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blueAccent.withOpacity(0.12),
                      ),
                      child: const Icon(
                        Icons.admin_panel_settings_outlined,
                        color: Colors.white,
                        size: 70,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // TITLE
                    const Text(
                      'DIFM Attendance',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'Role Based Login Portal',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ROLE CARDS
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _buildRoleCard(
                          icon: Icons.school_outlined,
                          title: 'Intern',
                          color: Colors.orange,
                        ),
                        _buildRoleCard(
                          icon: Icons.groups_2_outlined,
                          title: 'HR',
                          color: Colors.green,
                        ),
                        _buildRoleCard(
                          icon: Icons.security_outlined,
                          title: 'Admin',
                          color: Colors.blue,
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // EMAIL FIELD
                    TextField(
                      controller: emailController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter Email',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                        ),
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.05),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 18,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),
//password field
TextField(
  controller: passwordController,
  obscureText: !isPasswordVisible,
  style: const TextStyle(
    color: Colors.white,
  ),
  decoration: InputDecoration(
    hintText: 'Enter Password',
    hintStyle: TextStyle(
      color: Colors.grey.shade400,
    ),

    prefixIcon: const Icon(
      Icons.lock_outline,
      color: Colors.white,
    ),

    suffixIcon: IconButton(
      onPressed: () {
        setState(() {
          isPasswordVisible =
              !isPasswordVisible;
        });
      },
      icon: Icon(
        isPasswordVisible
            ? Icons.visibility_off
            : Icons.visibility,
        color: Colors.grey.shade400,
      ),
    ),

    filled: true,
    fillColor: Colors.white.withOpacity(
      0.05,
    ),

    contentPadding:
        const EdgeInsets.symmetric(
      vertical: 18,
    ),

    border: OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
  ),
),

                    const SizedBox(height: 35),

                    // LOGIN BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff2563eb),
                          elevation: 10,
                          shadowColor: Colors.blueAccent.withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        // onPressed: () {
                        //   AuthController.login(
                        //     context: context,
                        //     email: emailController.text.trim(),
                        //     password: passwordController.text.trim(),
                        //   );
                        // },
onPressed: () async {
  final email = emailController.text.trim();
  final password = passwordController.text.trim();

  if (email == 'intern@difm.com' &&
      password == 'intern123') {

    final policyVersion =
        await StorageService.getPolicyVersion();

    if (!context.mounted) return;

    if (policyVersion !=
        PolicyConstants.currentPolicyVersion) {

      Navigator.pushReplacementNamed(
        context,
        '/policy',
        arguments: {
          'role': 'intern',
        },
      );

      return;
    }

    Navigator.pushReplacementNamed(
      context,
      '/intern-dashboard',
    );
  }

  else if (email == 'hr@difm.com' &&
      password == 'hr123') {

    Navigator.pushReplacementNamed(
      context,
      '/hr-dashboard',
    );

  } else if (email == 'admin@difm.com' &&
      password == 'admin123') {

    Navigator.pushReplacementNamed(
      context,
      '/admin-dashboard',
    );

  } else {
    showLoginError();
  }
},
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),
                    const SizedBox(height: 18),

                    // FOOTER
                    Text(
                      'Secure Employee Attendance System',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}