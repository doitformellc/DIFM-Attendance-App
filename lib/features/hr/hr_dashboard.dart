import 'package:difm_attendance_app/features/shift/screens/assign_shift_screen.dart';
import 'package:flutter/material.dart';
import 'package:difm_attendance_app/core/widgets/dashboard_card.dart';
import 'package:difm_attendance_app/features/auth/controllers/auth_controller.dart';


class HRDashboard extends StatelessWidget {
  const HRDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff111827),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'HR Dashboard',
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
                    BorderRadius
                        .circular(
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

        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: statCard(
                    'Present',
                    '84',
                    Colors.green,
                  ),
                ),

                const SizedBox(
                    width: 15),

                Expanded(
                  child: statCard(
                    'Late',
                    '12',
                    Colors.orange,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 25,
            ),

            Expanded(
              child:
                  GridView.count(
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
                        Colors.blue,

                    onTap: () {
                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder:
                              (_) =>
                                  const AssignShiftScreen(),
                        ),
                      );
                    },
                  ),

                  DashboardCard(
                    icon:
                        Icons.groups,

                    title:
                        'Manage Interns',

                    color:
                        Colors.green,

                    onTap: () {
                      _comingSoon(
                        context,
                        'Manage Interns',
                      );
                    },
                  ),

                  DashboardCard(
                    icon:
                        Icons.analytics,

                    title:
                        'Reports',

                    color:
                        Colors.purple,

                    onTap: () {
                      _comingSoon(
                        context,
                        'Reports',
                      );
                    },
                  ),

                  DashboardCard(
                    icon:
                        Icons.approval,

                    title:
                        'Late Approval',

                    color:
                        Colors.orange,

                    onTap: () {
                      _comingSoon(
                        context,
                        'Late Approval',
                      );
                    },
                  ),

                  DashboardCard(
                    icon:
                        Icons.face,

                    title:
                        'Face Logs',

                    color:
                        Colors.cyan,

                    onTap: () {
                      _comingSoon(
                        context,
                        'Face Logs',
                      );
                    },
                  ),

                  DashboardCard(
                    icon:
                        Icons.warning,

                    title:
                        'Security Alerts',

                    color:
                        Colors.red,

                    onTap: () {
                      _comingSoon(
                        context,
                        'Security Alerts',
                      );
                    },
                  ),
                ],
              ),
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

  Widget statCard(
    String title,
    String value,
    Color color,
  ) {
    return Container(
      padding:
          const EdgeInsets.all(
        20,
      ),

      decoration:
          BoxDecoration(
        borderRadius:
            BorderRadius.circular(
          22,
        ),

        color: Colors.white
            .withOpacity(
          .05,
        ),
      ),

      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 34,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          Text(
            title,
            style:
                const TextStyle(
              color:
                  Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}