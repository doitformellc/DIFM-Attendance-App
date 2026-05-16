class ShiftOptionModel {
  final String id;
  final String name;
  final String shiftType;
  final String startTime;
  final String endTime;
  final bool isNightShift;

  const ShiftOptionModel({
    required this.id,
    required this.name,
    required this.shiftType,
    required this.startTime,
    required this.endTime,
    required this.isNightShift,
  });

  factory ShiftOptionModel.fromJson(Map<String, dynamic> json) {
    return ShiftOptionModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      shiftType: json['shift_type'] ?? json['shiftType'] ?? '',
      startTime: json['start_time'] ?? json['startTime'] ?? '',
      endTime: json['end_time'] ?? json['endTime'] ?? '',
      isNightShift: json['is_night_shift'] ?? json['isNightShift'] ?? false,
    );
  }

  String get label => "$name ($startTime - $endTime)";
}
