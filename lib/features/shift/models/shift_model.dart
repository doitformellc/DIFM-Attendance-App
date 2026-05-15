class ShiftModel {
  final String internId;
  final String internName;
  final String shiftType;
  final String startTime;
  final String endTime;

  ShiftModel({
    required this.internId,
    required this.internName,
    required this.shiftType,
    required this.startTime,
    required this.endTime,
  });

  bool get isNightShift => shiftType.toLowerCase() == "night";

  factory ShiftModel.fromJson(Map<String, dynamic> json) {
    return ShiftModel(
      internId: json['internId'] ?? json['user_id'] ?? '',
      internName: json['internName'] ?? json['name'] ?? '',
      shiftType: json['shiftType'] ?? json['shift_type'] ?? '',
      startTime: json['startTime'] ?? json['start_time'] ?? '',
      endTime: json['endTime'] ?? json['end_time'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'internId': internId,
      'internName': internName,
      'shiftType': shiftType,
      'startTime': startTime,
      'endTime': endTime,
    };
  }
}
