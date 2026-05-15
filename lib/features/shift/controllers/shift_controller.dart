import '../models/intern_model.dart';
import '../models/shift_model.dart';
import '../models/shift_option_model.dart';
import '../services/shift_service.dart';

class ShiftController {
  static Future<void> assign({
    required String userId,
    required String shiftId,
    required String effectiveDate,
  }) async {
    await ShiftService.assignShift(
      userId: userId,
      shiftId: shiftId,
      effectiveDate: effectiveDate,
    );
  }

  static Future<ShiftModel?> load() async {
    return await ShiftService.getMyShift();
  }

  static Future<List<InternModel>> loadInterns() async {
    return await ShiftService.getInterns();
  }

  static Future<List<ShiftOptionModel>> loadShifts() async {
    return await ShiftService.getShifts();
  }
}
