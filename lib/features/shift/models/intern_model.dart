class InternModel {
  final String id;
  final String name;
  final String email;
  final String employeeCode;
  final String department;

  const InternModel({
    required this.id,
    required this.name,
    required this.email,
    required this.employeeCode,
    required this.department,
  });

  factory InternModel.fromJson(Map<String, dynamic> json) {
    return InternModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      employeeCode: json['employee_code'] ?? '',
      department: json['department'] ?? '',
    );
  }
}
