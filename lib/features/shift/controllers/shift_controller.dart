import '../models/shift_model.dart';
import '../services/shift_service.dart';

class ShiftController {
  static Future<void> assign(
      ShiftModel shift) async {
    await ShiftService.assignShift(
      shift,
    );
  }

  static Future<ShiftModel?> load() {
    return ShiftService.getTodayShift();
  }
}