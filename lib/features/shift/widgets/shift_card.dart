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
          const EdgeInsets.all(
        20,
      ),

      decoration:
          BoxDecoration(

        borderRadius:
            BorderRadius.circular(
          20,
        ),

        gradient:
            LinearGradient(
          colors:
              shift.isNightShift
                  ? [
                      Colors.purple,
                      const Color(
                          0xff111827)
                    ]
                  : [
                      const Color(
                          0xff2563eb),
                      const Color(
                          0xff111827)
                    ],
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Text(
            shift.isNightShift
                ? "🌙 NIGHT SHIFT"
                : "${shift.shiftType.toUpperCase()} SHIFT",

            style:
                const TextStyle(
              color:
                  Colors.white,

              fontWeight:
                  FontWeight.bold,

              fontSize:22,
            ),
          ),

          const SizedBox(
            height:20,
          ),

          ShiftInfoTile(
            icon:
                Icons.person,
            title:
                shift.internName,
          ),

          const SizedBox(
            height:12,
          ),

          ShiftInfoTile(
            icon:
                Icons.access_time,

            title:
                "${shift.startTime} → ${shift.endTime}",
          ),
        ],
      ),
    );
  }
}