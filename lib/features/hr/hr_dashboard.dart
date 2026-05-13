import 'package:flutter/material.dart';
import '../../../core/widgets/dashboard_card.dart';

class HRDashboard extends StatelessWidget {
  const HRDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff111827),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('HR Dashboard'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            // STATS
            Row(
              children: [
                Expanded(
                  child: statCard(
                    'Present',
                    '84',
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: statCard(
                    'Late',
                    '12',
                    Colors.orange,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 18,
                mainAxisSpacing: 18,
                children: const [
                  DashboardCard(
                    icon: Icons.schedule,
                    title: 'Assign Shifts',
                    color: Colors.blue,
                  ),
                  DashboardCard(
                    icon: Icons.groups,
                    title: 'Manage Interns',
                    color: Colors.green,
                  ),
                  DashboardCard(
                    icon: Icons.analytics,
                    title: 'Reports',
                    color: Colors.purple,
                  ),
                  DashboardCard(
                    icon: Icons.approval,
                    title: 'Late Approval',
                    color: Colors.orange,
                  ),
                  DashboardCard(
                    icon: Icons.face,
                    title: 'Face Logs',
                    color: Colors.cyan,
                  ),
                  DashboardCard(
                    icon: Icons.warning,
                    title: 'Security Alerts',
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget statCard(
    String title,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.white.withOpacity(0.05),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}