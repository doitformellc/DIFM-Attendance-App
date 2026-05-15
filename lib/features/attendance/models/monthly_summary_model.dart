class MonthlySummaryModel {
  final int present;
  final int late;
  final int absent;
  final int totalHours;

  MonthlySummaryModel({
    required this.present,
    required this.late,
    required this.absent,
    required this.totalHours,
  });

  factory MonthlySummaryModel.fromJson(
      Map<String,dynamic> json){

    return MonthlySummaryModel(
      present:
      json['present'] ?? 0,

      late:
      json['late'] ?? 0,

      absent:
      json['absent'] ?? 0,

      totalHours:
      json['totalHours'] ?? 0,
    );
  }
}