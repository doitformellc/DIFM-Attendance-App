import '../services/break_service.dart';

class BreakController {

  static Future<void>
      startBreak() async {

    await BreakService
        .startBreak();
  }

  static Future<Duration>
      endBreak() async {

    int milliseconds=
        await BreakService
            .endBreak();

    return Duration(
      milliseconds:
          milliseconds,
    );
  }

  static Future<bool>
      isBreakRunning() async {

    return await BreakService
        .isBreakActive();
  }
}