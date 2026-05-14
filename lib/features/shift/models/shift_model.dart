class ShiftModel {
  final String internName;
  final String shiftType;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime effectiveDate;

  const ShiftModel({
    required this.internName,
    required this.shiftType,
    required this.startTime,
    required this.endTime,
    required this.effectiveDate,
  });

  bool get isNightShift =>
      startTime.hour > endTime.hour;
}