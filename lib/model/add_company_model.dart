import 'dart:convert';

AddCompanyModel addCompanyModelFromJson(String str) =>
    AddCompanyModel.fromJson(json.decode(str));

String addCompanyModelToJson(AddCompanyModel data) =>
    json.encode(data.toJson());

class AddCompanyModel {
  AddCompanyModel({
    required this.success,
    required this.errorcode,
    required this.data,
    required this.message,
    required this.accessToken,
  });

  final bool success;
  final String errorcode;
  final Data data;
  final String message;
  final String accessToken;

  factory AddCompanyModel.fromJson(Map<String, dynamic> json) =>
      AddCompanyModel(
        success: json["success"],
        errorcode: json["errorcode"],
        data: Data.fromJson(json["data"]),
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

class Data {
  Data({
    required this.name,
    required this.contactPerson,
    required this.email,
    required this.contactNumber,
    required this.addedBy,
    required this.code,
    required this.id,
    required this.logo,
  });

  final String name;
  final String contactPerson;
  final String email;
  final String contactNumber;
  final String addedBy;
  final String code;
  final String id;
  final String logo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        contactPerson: json["contact_person"],
        email: json["email"],
        contactNumber: json["contact_number"],
        addedBy: json["added_by"],
        code: json["code"],
        id: json["id"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "contact_person": contactPerson,
        "email": email,
        "contact_number": contactNumber,
        "added_by": addedBy,
        "code": code,
        "id": id,
        "logo": logo,
      };
}
