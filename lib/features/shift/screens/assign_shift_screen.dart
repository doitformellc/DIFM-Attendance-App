import 'package:flutter/material.dart';

import '../controllers/shift_controller.dart';
import '../models/shift_model.dart';
import '../widgets/shift_dropdown.dart';

class AssignShiftScreen
    extends StatefulWidget {
  const AssignShiftScreen({
    super.key,
  });

  @override
  State<AssignShiftScreen>
      createState() =>
          _AssignShiftScreenState();
}

class _AssignShiftScreenState
    extends State<
        AssignShiftScreen> {
  String selectedShift =
      'Day';

  String selectedIntern =
      'Intern A';

  TimeOfDay startTime =
      const TimeOfDay(
    hour: 9,
    minute: 0,
  );

  TimeOfDay endTime =
      const TimeOfDay(
    hour: 18,
    minute: 0,
  );

  final interns = [
    'Intern A',
    'Intern B',
    'Intern C',
  ];

  Future<void>
      pickStartTime() async {
    final picked =
        await showTimePicker(
      context: context,
      initialTime:
          startTime,
    );

    if (picked != null) {
      setState(() {
        startTime =
            picked;
      });
    }
  }

  Future<void>
      pickEndTime() async {
    final picked =
        await showTimePicker(
      context: context,
      initialTime:
          endTime,
    );

    if (picked != null) {
      setState(() {
        endTime = picked;
      });
    }
  }

  Future<void>
      assignShift() async {
    final now =
        DateTime.now();

    final start =
        DateTime(
      now.year,
      now.month,
      now.day,
      startTime.hour,
      startTime.minute,
    );

    var end = DateTime(
      now.year,
      now.month,
      now.day,
      endTime.hour,
      endTime.minute,
    );

    // night shift cross-day
    if (end.isBefore(start)) {
      end = end.add(
        const Duration(
          days: 1,
        ),
      );
    }

    await ShiftController
        .assign(
      ShiftModel(
        internName:
            selectedIntern,

        shiftType:
            selectedShift,

        startTime:
            start,

        endTime: end,

        effectiveDate:
            DateTime.now(),
      ),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      const SnackBar(
        content: Text(
          'Shift Assigned Successfully',
        ),
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

        title: const Text(
          'Assign Shift',
        ),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(
          20,
        ),

        child: Column(
          children: [
            DropdownButtonFormField(
              value:
                  selectedIntern,

              dropdownColor:
                  const Color(
                0xff1e293b,
              ),

              items: interns
                  .map(
                    (e) =>
                        DropdownMenuItem(
                      value:
                          e,

                      child:
                          Text(
                        e,
                      ),
                    ),
                  )
                  .toList(),

              onChanged: (v) {
                setState(() {
                  selectedIntern =
                      v!;
                });
              },
            ),

            const SizedBox(
              height: 20,
            ),

            ShiftDropdown(
              value:
                  selectedShift,

              onChanged: (v) {
                setState(() {
                  selectedShift =
                      v!;
                });
              },
            ),

            const SizedBox(
              height: 20,
            ),

            ListTile(
              tileColor:
                  Colors.white10,

              title: Text(
                'Start: ${startTime.format(context)}',
                style:
                    const TextStyle(
                  color:
                      Colors.white,
                ),
              ),

              trailing:
                  const Icon(
                Icons.access_time,
                color:
                    Colors.white,
              ),

              onTap:
                  pickStartTime,
            ),

            const SizedBox(
              height: 20,
            ),

            ListTile(
              tileColor:
                  Colors.white10,

              title: Text(
                'End: ${endTime.format(context)}',
                style:
                    const TextStyle(
                  color:
                      Colors.white,
                ),
              ),

              trailing:
                  const Icon(
                Icons.access_time,
                color:
                    Colors.white,
              ),

              onTap:
                  pickEndTime,
            ),

            const Spacer(),

            SizedBox(
              width:
                  double.infinity,
              height: 56,

              child:
                  ElevatedButton(
                onPressed:
                    assignShift,

                child:
                    const Text(
                  'Assign Shift',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}