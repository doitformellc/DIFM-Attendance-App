import 'package:flutter/material.dart';
import 'package:difm_attendance_app/core/widgets/dashboard_card.dart';
import 'package:difm_attendance_app/features/auth/controllers/auth_controller.dart';
import 'package:difm_attendance_app/features/attendance/controllers/break_controller.dart';
import 'package:difm_attendance_app/features/attendance/screens/face_attendance_screen.dart';
import 'package:difm_attendance_app/features/attendance/screens/break_screen.dart';
import 'package:difm_attendance_app/features/attendance/screens/correction_request_screen.dart';
import 'package:difm_attendance_app/features/attendance/services/attendance_service.dart';
import 'package:difm_attendance_app/features/shift/controllers/shift_controller.dart';
import 'package:difm_attendance_app/features/shift/models/shift_model.dart';
import 'package:difm_attendance_app/features/shift/screens/my_shift_screen.dart';
import 'package:intl/intl.dart';

class AttendancePopup {
  static Future<void> show({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",

      transitionDuration: const Duration(milliseconds: 450),

      pageBuilder: (_, __, ___) {
        return const SizedBox();
      },

      transitionBuilder: (context, anim, _, __) {
        return Transform.scale(
          scale: Curves.elasticOut.transform(anim.value),

          child: Opacity(
            opacity: anim.value,

            child: AlertDialog(
              backgroundColor: const Color(0xff1e293b),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),

              content: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  CircleAvatar(
                    radius: 38,
                    backgroundColor: color.withOpacity(.15),

                    child: Icon(icon, color: color, size: 45),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    title,

                    style: const TextStyle(
                      color: Colors.white,

                      fontWeight: FontWeight.bold,

                      fontSize: 24,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    subtitle,

                    textAlign: TextAlign.center,

                    style: const TextStyle(color: Colors.white70),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: color),

                      onPressed: () {
                        Navigator.pop(context);
                      },

                      child: const Text(
                        "OK",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class InternDashboard extends StatefulWidget {
  const InternDashboard({super.key});

  @override
  State<InternDashboard> createState() => _InternDashboardState();
}

class _InternDashboardState extends State<InternDashboard> {
  bool isBreak = false;
  bool isAttendanceLoading = false;

  ShiftModel? shift;
  DateTime? checkInTime;
  DateTime? checkOutTime;

  @override
  void initState() {
    super.initState();

    loadBreakStatus();
    loadShift();
  }

  Future loadShift() async {
    try {
      shift = await ShiftController.load();
    } catch (e) {
      print(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future loadBreakStatus() async {
    isBreak = await BreakController.isBreakRunning();

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> handleAttendance(FaceAttendanceAction action) async {
    final verified = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => FaceAttendanceScreen(action: action)),
    );

    if (verified != true || !mounted) return;

    setState(() {
      isAttendanceLoading = true;
    });

    try {
      final response = action == FaceAttendanceAction.checkIn
          ? await AttendanceService.checkIn()
          : await AttendanceService.checkout();

      final attendance = _readAttendanceData(response);
      final timestamp = action == FaceAttendanceAction.checkIn
          ? _readAttendanceTime(attendance, 'checkin_ts', 'check_in')
          : _readAttendanceTime(attendance, 'checkout_ts', 'check_out');

      setState(() {
        if (action == FaceAttendanceAction.checkIn) {
          checkInTime = timestamp ?? DateTime.now();
          checkOutTime = null;
        } else {
          checkOutTime = timestamp ?? DateTime.now();
        }
      });

      if (!mounted) return;

      AttendancePopup.show(
        context: context,
        title: action == FaceAttendanceAction.checkIn
            ? 'Checked In'
            : 'Checked Out',
        subtitle: action == FaceAttendanceAction.checkIn
            ? 'Attendance marked successfully'
            : 'Session ended successfully',
        icon: action == FaceAttendanceAction.checkIn
            ? Icons.check_circle
            : Icons.task_alt,
        color: action == FaceAttendanceAction.checkIn
            ? Colors.green
            : Colors.redAccent,
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    } finally {
      if (mounted) {
        setState(() {
          isAttendanceLoading = false;
        });
      }
    }
  }

  Map<String, dynamic> _readAttendanceData(dynamic response) {
    if (response is Map && response['data'] is Map) {
      return Map<String, dynamic>.from(response['data']);
    }

    if (response is Map) {
      return Map<String, dynamic>.from(response);
    }

    return {};
  }

  DateTime? _readAttendanceTime(
    Map<String, dynamic> attendance,
    String millisKey,
    String dateKey,
  ) {
    final millis = attendance[millisKey];
    if (millis is int) {
      return DateTime.fromMillisecondsSinceEpoch(millis);
    }

    if (millis is String) {
      final parsedMillis = int.tryParse(millis);
      if (parsedMillis != null) {
        return DateTime.fromMillisecondsSinceEpoch(parsedMillis);
      }
    }

    final date = attendance[dateKey];
    if (date is String) {
      return DateTime.tryParse(date)?.toLocal();
    }

    return null;
  }

  String _formatAttendanceTime(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0f172a),

      appBar: AppBar(
        backgroundColor: Colors.transparent,

        elevation: 0,

        title: const Text(
          "Intern Dashboard",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        actions: [
          IconButton(
            onPressed: () {
              AuthController.logout(context);
            },

            icon: Container(
              padding: const EdgeInsets.all(8),

              decoration: BoxDecoration(
                color: Colors.red.withOpacity(.15),

                borderRadius: BorderRadius.circular(12),
              ),

              child: const Icon(
                Icons.power_settings_new,
                color: Colors.redAccent,
              ),
            ),
          ),

          const SizedBox(width: 10),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),

                gradient: const LinearGradient(
                  colors: [Color(0xff2563eb), Color(0xff1d4ed8)],
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Text(
                          "Today's Shift",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                      if (checkInTime != null)
                        _AttendanceTimeBadge(
                          label: checkOutTime == null ? 'IN' : 'OUT',
                          time: _formatAttendanceTime(
                            checkOutTime ?? checkInTime!,
                          ),
                          color: checkOutTime == null
                              ? Colors.green
                              : Colors.redAccent,
                        ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Text(
                    shift == null
                        ? "No Shift Assigned"
                        : "${shift!.shiftType.toUpperCase()} Shift",

                    style: const TextStyle(
                      fontSize: 28,

                      color: Colors.white,

                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    shift == null
                        ? "Waiting for HR"
                        : "${shift!.startTime} → ${shift!.endTime}",

                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,

                crossAxisSpacing: 18,

                mainAxisSpacing: 18,

                children: [
                  DashboardCard(
                    icon: isAttendanceLoading
                        ? Icons.hourglass_top
                        : Icons.login_rounded,

                    title: "Check In",

                    color: Colors.green,

                    onTap: isAttendanceLoading
                        ? null
                        : () => handleAttendance(FaceAttendanceAction.checkIn),
                  ),

                  if (!isBreak)
                    DashboardCard(
                      icon: Icons.logout_rounded,

                      title: "Check Out",

                      color: Colors.redAccent,

                      onTap: isAttendanceLoading
                          ? null
                          : () =>
                                handleAttendance(FaceAttendanceAction.checkOut),
                    ),

                  DashboardCard(
                    icon: Icons.coffee,

                    title: isBreak ? "End Break" : "Break",

                    color: Colors.orange,

                    onTap: () async {
                      await Navigator.push(
                        context,

                        MaterialPageRoute(builder: (_) => const BreakScreen()),
                      );

                      loadBreakStatus();
                    },
                  ),

                  DashboardCard(
                    icon: Icons.schedule,

                    title: "My Shift",

                    color: Colors.blue,

                    onTap: () {
                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (_) => const MyShiftScreen(),
                        ),
                      );
                    },
                  ),

                  DashboardCard(
                    icon: Icons.edit_note,

                    title: "Correction",

                    color: Colors.purple,

                    onTap: () {
                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (_) => const CorrectionRequestScreen(),
                        ),
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

class _AttendanceTimeBadge extends StatelessWidget {
  final String label;
  final String time;
  final Color color;

  const _AttendanceTimeBadge({
    required this.label,
    required this.time,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.14),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(.7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
