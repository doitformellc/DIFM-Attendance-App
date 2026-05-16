class BreakModel {
  final String breakStart;
  final String? breakEnd;
  final bool isRunning;
  final int duration;

  BreakModel({
    required this.breakStart,
    this.breakEnd,
    required this.isRunning,
    required this.duration,
  });

  factory BreakModel.fromJson(
      Map<String,dynamic> json){

    return BreakModel(
      breakStart:
      json['breakStart'] ?? '',

      breakEnd:
      json['breakEnd'],

      isRunning:
      json['isRunning'] ?? false,

      duration:
      json['duration'] ?? 0,
    );
  }
}