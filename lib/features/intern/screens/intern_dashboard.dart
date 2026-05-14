import 'package:flutter/material.dart';
import '../../../core/widgets/dashboard_card.dart';
import 'package:difm_attendance_app/features/auth/controllers/auth_controller.dart';
class InternDashboard extends StatelessWidget {
  const InternDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0f172a),

appBar: AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  title: const Text(
    'Intern Dashboard',
    style: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  ),
  actions: [
    IconButton(
      tooltip: 'Logout',
      onPressed: () async {
        await AuthController.logout(context);
      },
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.logout_rounded,
          color: Colors.redAccent,
        ),
      ),
    ),
    const SizedBox(width: 12),
  ],
),
      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SHIFT CARD
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff2563eb),
                    Color(0xff1d4ed8),
                  ],
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today Shift',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    'Day Shift',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 6),

                  Text(
                    '8:00 AM → 4:00 PM',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Quick Actions',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 18),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 18,
                mainAxisSpacing: 18,
                children: const [
                  DashboardCard(
                    icon: Icons.login,
                    title: 'Check In',
                    color: Colors.green,
                  ),
                  DashboardCard(
                    icon: Icons.logout,
                    title: 'Check Out',
                    color: Colors.red,
                  ),
                  DashboardCard(
                    icon: Icons.coffee,
                    title: 'Break',
                    color: Colors.orange,
                  ),
                  DashboardCard(
                    icon: Icons.history,
                    title: 'History',
                    color: Colors.purple,
                  ),
                  DashboardCard(
                    icon: Icons.face,
                    title: 'Face Verification',
                    color: Colors.cyan,
                  ),
                  DashboardCard(
                    icon: Icons.policy,
                    title: 'Policy',
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}