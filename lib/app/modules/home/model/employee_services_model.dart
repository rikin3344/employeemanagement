import 'dart:convert';

EmployeeServicesModel employeeServicesModelFromJson(String str) =>
    EmployeeServicesModel.fromJson(json.decode(str));

String employeeServicesModelToJson(EmployeeServicesModel data) =>
    json.encode(data.toJson());

class EmployeeServicesModel {
  EmployeeServicesModel({
    required this.success,
    required this.errorcode,
    required this.data,
    required this.message,
    required this.accessToken,
  });

  final bool success;
  final String errorcode;
  final List<ServiceData> data;
  final String message;
  final String accessToken;

  factory EmployeeServicesModel.fromJson(Map<String, dynamic> json) =>
      EmployeeServicesModel(
        success: json["success"],
        errorcode: json["errorcode"],
        data: List<ServiceData>.from(
            json["data"].map((x) => ServiceData.fromJson(x))),
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

class ServiceData {
  ServiceData({
    required this.id,
    required this.name,
    required this.addedBy,
    required this.status,
    required this.isDefault,
  });

  final String id;
  final String name;
  final String addedBy;
  final String status;
  final String isDefault;

  factory ServiceData.fromJson(Map<String, dynamic> json) => ServiceData(
        id: json["id"],
        name: json["name"],
        addedBy: json["added_by"],
        status: json["status"],
        isDefault: json["is_default"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "added_by": addedBy,
        "status": status,
        "is_default": isDefault,
      };
}
