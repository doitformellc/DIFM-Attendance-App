class AttendanceModel {
  final String id;
  final String status;
  final String checkIn;
  final String? checkOut;

  final bool breakRunning;

  AttendanceModel({
    required this.id,
    required this.status,
    required this.checkIn,
    this.checkOut,
    required this.breakRunning,
  });

  factory AttendanceModel.fromJson(
      Map<String,dynamic> json){

    return AttendanceModel(
      id: json['_id'],
      status: json['status'],
      checkIn: json['checkIn'],
      checkOut: json['checkOut'],
      breakRunning:
      json['breakRunning']??false,
    );
  }
}