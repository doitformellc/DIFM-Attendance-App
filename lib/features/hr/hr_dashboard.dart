import 'package:flutter/material.dart';
import 'package:difm_attendance_app/core/widgets/dashboard_card.dart';
import 'package:difm_attendance_app/features/auth/controllers/auth_controller.dart';
import 'package:difm_attendance_app/features/shift/screens/assign_shift_screen.dart';

class HRDashboard extends StatelessWidget {
  const HRDashboard({super.key});

  void comingSoon(
    BuildContext context,
    String title,
  ) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        backgroundColor:
            const Color(0xff1e293b),

        content: Text(
          '$title coming soon',
        ),

        behavior:
            SnackBarBehavior.floating,
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
          const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color:
            Colors.white.withOpacity(
          .05,
        ),

        borderRadius:
            BorderRadius.circular(
          20,
        ),
      ),

      child: Column(
        children: [

          Text(
            value,

            style: TextStyle(
              fontSize: 28,
              fontWeight:
                  FontWeight.bold,
              color: color,
            ),
          ),

          const SizedBox(
            height: 8,
          ),

          Text(
            title,

            style:
                const TextStyle(
              color:
                  Colors.white70,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(
        0xff111827,
      ),

      appBar: AppBar(
        backgroundColor:
            Colors.transparent,

        title:
            const Text(
          "HR Dashboard",
        ),

        actions: [

          IconButton(
            onPressed: () {
              AuthController.logout(
                context,
              );
            },

            icon: Container(
              padding:
                  const EdgeInsets
                      .all(
                8,
              ),

              decoration:
                  BoxDecoration(
                color: Colors.red
                    .withOpacity(
                  .15,
                ),

                borderRadius:
                    BorderRadius
                        .circular(
                  12,
                ),
              ),

              child:
                  const Icon(
                Icons.logout,
                color:
                    Colors.redAccent,
              ),
            ),
          ),

          const SizedBox(
            width: 12,
          )
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
                    "Assigned",
                    "48",
                    Colors.blue,
                  ),
                ),

                const SizedBox(
                  width: 15,
                ),

                Expanded(
                  child: statCard(
                    "Active",
                    "18",
                    Colors.green,
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

                crossAxisCount:
                    2,

                crossAxisSpacing:
                    18,

                mainAxisSpacing:
                    18,

                children: [

                  DashboardCard(
                    icon:
                        Icons.schedule,

                    title:
                        "Assign Shift",

                    color:
                        Colors.indigo,

                    onTap:
                        () {

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
                        "Interns",

                    color:
                        Colors.green,

                    onTap:
                        (){
                      comingSoon(
                        context,
                        "Interns",
                      );
                    },
                  ),

                  DashboardCard(
                    icon:
                        Icons.approval,

                    title:
                        "Late Approval",

                    color:
                        Colors.orange,

                    onTap:
                        (){
                      comingSoon(
                        context,
                        "Late Approval",
                      );
                    },
                  ),

                  DashboardCard(
                    icon:
                        Icons.analytics,

                    title:
                        "Reports",

                    color:
                        Colors.purple,

                    onTap:
                        (){
                      comingSoon(
                        context,
                        "Reports",
                      );
                    },
                  ),

                  DashboardCard(
                    icon:
                        Icons.warning,

                    title:
                        "Security",

                    color:
                        Colors.red,

                    onTap:
                        (){
                      comingSoon(
                        context,
                        "Security",
                      );
                    },
                  ),

                  DashboardCard(
                    icon:
                        Icons.face,

                    title:
                        "Face Logs",

                    color:
                        Colors.cyan,

                    onTap:
                        (){
                      comingSoon(
                        context,
                        "Face Logs",
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
}