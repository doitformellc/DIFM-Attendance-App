import 'package:flutter/material.dart';
import '../models/shift_model.dart';
import 'shift_info_tile.dart';

class ShiftCard extends StatelessWidget {
  final ShiftModel shift;

  const ShiftCard({
    super.key,
    required this.shift,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(20),
        gradient: LinearGradient(
          colors:
              shift.isNightShift
                  ? [
                      Colors.purple,
                      Color(0xff111827)
                    ]
                  : [
                      Color(0xff2563eb),
                      Color(0xff111827)
                    ],
        ),
      ),
      child: Column(
        children: [
          Text(
            shift.isNightShift
                ? '🌙 NIGHT SHIFT'
                : '${shift.shiftType} SHIFT',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 22,
            ),
          ),
          ShiftInfoTile(
            icon: Icons.person,
            title:
                shift.internName,
          ),
          ShiftInfoTile(
            icon:
                Icons.access_time,
            title:
                '${shift.startTime.hour}:00 - ${shift.endTime.hour}:00',
          )
        ],
      ),
    );
  }
}