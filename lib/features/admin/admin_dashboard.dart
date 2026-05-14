import 'package:flutter/material.dart';
import 'package:difm_attendance_app/core/widgets/dashboard_card.dart';
import 'package:difm_attendance_app/features/auth/controllers/auth_controller.dart';
import 'package:difm_attendance_app/features/shift/screens/assign_shift_screen.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff020617),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: const Text(
          'Admin Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: () async {
              await AuthController.logout(
                context,
              );
            },
            icon: Container(
              padding:
                  const EdgeInsets.all(8),

              decoration:
                  BoxDecoration(
                color: Colors.red
                    .withOpacity(.15),

                borderRadius:
                    BorderRadius.circular(
                  12,
                ),
              ),

              child: const Icon(
                Icons.logout_rounded,
                color:
                    Colors.redAccent,
              ),
            ),
          ),

          const SizedBox(width: 12),
        ],
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(
          20,
        ),

        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing:
              18,
          mainAxisSpacing:
              18,

          children: [
            DashboardCard(
              icon:
                  Icons.schedule,

              title:
                  'Assign Shifts',

              color:
                  Colors.indigo,

              onTap: () {
                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (_) =>
                        const AssignShiftScreen(),
                  ),
                );
              },
            ),

            DashboardCard(
              icon:
                  Icons.admin_panel_settings,

              title:
                  'Manage HR',

              color:
                  Colors.blue,

              onTap: () {
                _comingSoon(
                  context,
                  'Manage HR',
                );
              },
            ),

            DashboardCard(
              icon:
                  Icons.security,

              title:
                  'Security Center',

              color:
                  Colors.red,

              onTap: () {
                _comingSoon(
                  context,
                  'Security Center',
                );
              },
            ),

            DashboardCard(
              icon:
                  Icons.key,

              title:
                  'API Keys',

              color:
                  Colors.orange,

              onTap: () {
                _comingSoon(
                  context,
                  'API Keys',
                );
              },
            ),

            DashboardCard(
              icon:
                  Icons.analytics,

              title:
                  'Analytics',

              color:
                  Colors.green,

              onTap: () {
                _comingSoon(
                  context,
                  'Analytics',
                );
              },
            ),

            DashboardCard(
              icon:
                  Icons.history,

              title:
                  'Audit Logs',

              color:
                  Colors.purple,

              onTap: () {
                _comingSoon(
                  context,
                  'Audit Logs',
                );
              },
            ),

            DashboardCard(
              icon:
                  Icons.settings,

              title:
                  'System Settings',

              color:
                  Colors.cyan,

              onTap: () {
                _comingSoon(
                  context,
                  'System Settings',
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  static void _comingSoon(
    BuildContext context,
    String title,
  ) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        backgroundColor:
            const Color(
          0xff1e293b,
        ),

        behavior:
            SnackBarBehavior
                .floating,

        content: Text(
          '$title coming soon',
        ),
      ),
    );
  }
}