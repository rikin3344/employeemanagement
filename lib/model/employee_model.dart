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
  final List<Datum> data;
  final String message;
  final String accessToken;

  factory EmployeesModel.fromJson(Map<String, dynamic> json) => EmployeesModel(
        success: json["success"],
        errorcode: json["errorcode"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "errorcode": errorcode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "access_token": accessToken,
      };
}

class Datum {
  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
