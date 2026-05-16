import 'package:flutter/material.dart';
import 'package:difm_attendance_app/core/widgets/dashboard_card.dart';
import 'package:difm_attendance_app/features/auth/controllers/auth_controller.dart';
import 'package:difm_attendance_app/features/shift/screens/assign_shift_screen.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  void comingSoon(
    BuildContext context,
    String title,
  ) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          '$title coming soon',
        ),

        behavior:
            SnackBarBehavior
                .floating,

        backgroundColor:
            const Color(
          0xff1e293b,
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
        18,
      ),

      decoration:
          BoxDecoration(
        color: Colors.white
            .withOpacity(
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
              color: color,
              fontWeight:
                  FontWeight.bold,
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
        0xff020617,
      ),

      appBar: AppBar(
        backgroundColor:
            Colors.transparent,

        title:
            const Text(
          "Admin Dashboard",
        ),

        actions: [

          IconButton(
            onPressed: (){
              AuthController.logout(
                context,
              );
            },

            icon: Container(
              padding:
                  const EdgeInsets.all(
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
            width:12,
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
                  child:
                      statCard(
                    "Total Shift",
                    "125",
                    Colors.indigo,
                  ),
                ),

                const SizedBox(
                  width:15,
                ),

                Expanded(
                  child:
                      statCard(
                    "Running",
                    "38",
                    Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height:25,
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

                children:[

                  DashboardCard(
                    icon:
                        Icons.schedule,

                    title:
                        "Assign Shift",

                    color:
                        Colors.blue,

                    onTap:
                        (){

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
                        Icons.admin_panel_settings,

                    title:
                        "Manage HR",

                    color:
                        Colors.indigo,

                    onTap:
                        (){
                      comingSoon(
                        context,
                        "Manage HR",
                      );
                    },
                  ),

                  DashboardCard(
                    icon:
                        Icons.security,

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
                        Icons.analytics,

                    title:
                        "Analytics",

                    color:
                        Colors.green,

                    onTap:
                        (){
                      comingSoon(
                        context,
                        "Analytics",
                      );
                    },
                  ),

                  DashboardCard(
                    icon:
                        Icons.history,

                    title:
                        "Audit Logs",

                    color:
                        Colors.orange,

                    onTap:
                        (){
                      comingSoon(
                        context,
                        "Audit Logs",
                      );
                    },
                  ),

                  DashboardCard(
                    icon:
                        Icons.settings,

                    title:
                        "Settings",

                    color:
                        Colors.purple,

                    onTap:
                        (){
                      comingSoon(
                        context,
                        "Settings",
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}