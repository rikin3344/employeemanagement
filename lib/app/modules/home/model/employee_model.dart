import 'dart:convert';

EmployeesModel employeesModelFromJson(String str) =>
    EmployeesModel.fromJson(json.decode(str));

String employeesModelToJson(EmployeesModel data) => json.encode(data.toJson());

class EmployeesModel {
  EmployeesModel({
    required this.success,
    required this.errorcode,
    required this.data,
    required this.message,
    required this.accessToken,
  });

  final bool success;
  final String errorcode;
  final Datanum data;
  final String message;
  final String accessToken;

  factory EmployeesModel.fromJson(Map<String, dynamic> json) => EmployeesModel(
        success: json["success"],
        errorcode: json["errorcode"],
        data: Datanum.fromJson(json["data"]),
        message: json["message"],
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "errorcode": errorcode,
        "data": data.toJson(),
        "message": message,
        "access_token": accessToken,
      };
}

class Datanum {
  Datanum({
    required this.employees,
    required this.totalEmployees,
    required this.totalPendingEmployees,
    required this.totalDoneEmployees,
  });

  final List<Employee> employees;
  final int totalEmployees;
  final int totalPendingEmployees;
  final int totalDoneEmployees;

  factory Datanum.fromJson(Map<String, dynamic> json) => Datanum(
        employees: List<Employee>.from(
            json["employees"].map((x) => Employee.fromJson(x))),
        totalEmployees: json["total_employees"],
        totalPendingEmployees: json["total_pending_employees"],
        totalDoneEmployees: json["total_done_employees"],
      );

  Map<String, dynamic> toJson() => {
        "employees": List<dynamic>.from(employees.map((x) => x.toJson())),
        "total_employees": totalEmployees,
        "total_pending_employees": totalPendingEmployees,
        "total_done_employees": totalDoneEmployees,
      };
}

class Employee {
  Employee({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profilePic,
    required this.companyId,
    required this.companyName,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String profilePic;
  final String companyId;
  final String companyName;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        profilePic: json["profile_pic"],
        companyId: json["company_id"],
        companyName: json["company_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "profile_pic": profilePic,
        "company_id": companyId,
        "company_name": companyName,
      };
}
