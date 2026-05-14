import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/shift_model.dart';

class ShiftService {
  static const String shiftKey =
      'assigned_shift';

  static Future<void> assignShift(
    ShiftModel shift,
  ) async {
    final prefs =
        await SharedPreferences
            .getInstance();

    final data = {
      'internName':
          shift.internName,
      'shiftType':
          shift.shiftType,
      'startTime':
          shift.startTime
              .toIso8601String(),
      'endTime':
          shift.endTime
              .toIso8601String(),
      'effectiveDate':
          shift.effectiveDate
              .toIso8601String(),
    };

    await prefs.setString(
      shiftKey,
      jsonEncode(data),
    );
  }

  static Future<ShiftModel?>
      getTodayShift() async {
    final prefs =
        await SharedPreferences
            .getInstance();

    final raw =
        prefs.getString(
      shiftKey,
    );

    if (raw == null) {
      return null;
    }

    final json =
        jsonDecode(raw);

    return ShiftModel(
      internName:
          json['internName'],

      shiftType:
          json['shiftType'],

      startTime:
          DateTime.parse(
        json['startTime'],
      ),

      endTime:
          DateTime.parse(
        json['endTime'],
      ),

      effectiveDate:
          DateTime.parse(
        json['effectiveDate'],
      ),
    );
  }
}