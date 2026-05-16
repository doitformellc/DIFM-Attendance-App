import 'package:difm_attendance_app/core/constants/api_constants.dart';
import 'package:difm_attendance_app/core/services/api_service.dart';

import '../models/intern_model.dart';
import '../models/shift_model.dart';
import '../models/shift_option_model.dart';

class ShiftService {
  static Future<List<InternModel>> getInterns() async {
    final response = await ApiService.get(
      url: '${ApiConstants.baseUrl}${ApiConstants.interns}',
    );

    final data = _readList(response);
    return data
        .map((item) => InternModel.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  static Future<List<ShiftOptionModel>> getShifts() async {
    final response = await ApiService.get(
      url: '${ApiConstants.baseUrl}${ApiConstants.shifts}',
    );

    final data = _readList(response);
    return data
        .map(
          (item) => ShiftOptionModel.fromJson(Map<String, dynamic>.from(item)),
        )
        .toList();
  }

  static Future<void> assignShift({
    required String userId,
    required String shiftId,
    required String effectiveDate,
  }) async {
    await ApiService.post(
      url: '${ApiConstants.baseUrl}${ApiConstants.assignShift}',
      body: {
        'userId': userId,
        'shiftId': shiftId,
        'effectiveDate': effectiveDate,
      },
    );
  }

  static Future<ShiftModel?> getMyShift() async {
    final response = await ApiService.get(
      url: '${ApiConstants.baseUrl}${ApiConstants.myShift}',
    );

    if (response is! Map || response['data'] == null) {
      return null;
    }

    return ShiftModel.fromJson(Map<String, dynamic>.from(response['data']));
  }

  static List _readList(dynamic response) {
    if (response is List) {
      return response;
    }

    if (response is Map && response['data'] is List) {
      return response['data'];
    }

    return const [];
  }
}
