import 'package:shared_preferences/shared_preferences.dart';

class BreakService {
  static const _startKey='break_start';
  static const _activeKey='break_active';

  static Future<void> startBreak() async {
    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setBool(
      _activeKey,
      true,
    );

    await prefs.setInt(
      _startKey,
      DateTime.now()
          .millisecondsSinceEpoch,
    );
  }

  static Future<int> endBreak() async {
    final prefs =
        await SharedPreferences.getInstance();

    int? startEpoch =
        prefs.getInt(_startKey);

    if(startEpoch==null){
      return 0;
    }

    int endEpoch=
        DateTime.now()
            .millisecondsSinceEpoch;

    int duration=
        endEpoch-startEpoch;

    await prefs.remove(
      _startKey,
    );

    await prefs.setBool(
      _activeKey,
      false,
    );

    return duration;
  }

  static Future<bool> isBreakActive() async {
    final prefs=
        await SharedPreferences.getInstance();

    return prefs.getBool(
          _activeKey,
        ) ??
        false;
  }

  static Future<int?> getBreakStart() async {
    final prefs=
        await SharedPreferences.getInstance();

    return prefs.getInt(
      _startKey,
    );
  }
}