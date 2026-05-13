import 'package:flutter/material.dart';
import '../../../core/widgets/dashboard_card.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff020617),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Admin Dashboard'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: const [
            DashboardCard(
              icon: Icons.admin_panel_settings,
              title: 'Manage HR',
              color: Colors.blue,
            ),
            DashboardCard(
              icon: Icons.security,
              title: 'Security Center',
              color: Colors.red,
            ),
            DashboardCard(
              icon: Icons.key,
              title: 'API Keys',
              color: Colors.orange,
            ),
            DashboardCard(
              icon: Icons.analytics,
              title: 'Analytics',
              color: Colors.green,
            ),
            DashboardCard(
              icon: Icons.history,
              title: 'Audit Logs',
              color: Colors.purple,
            ),
            DashboardCard(
              icon: Icons.settings,
              title: 'System Settings',
              color: Colors.cyan,
            ),
          ],
        ),
      ),
    );
  }
}