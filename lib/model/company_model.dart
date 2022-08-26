import 'dart:convert';

CompanyModel companyModelFromJson(String str) =>
    CompanyModel.fromJson(json.decode(str));

String companyModelToJson(CompanyModel data) => json.encode(data.toJson());

List<DatumCompany> dataCompanyFromJson(String str) => List<DatumCompany>.from(
    json.decode(str).map((x) => DatumCompany.fromJson(x)));

class CompanyModel {
  CompanyModel({
    required this.success,
    required this.errorcode,
    required this.data,
    required this.message,
    required this.accessToken,
  });

  final bool success;
  final String errorcode;
  final List<DatumCompany> data;
  final String message;
  final String accessToken;

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        success: json["success"],
        errorcode: json["errorcode"],
        data: List<DatumCompany>.from(
            json["data"].map((x) => DatumCompany.fromJson(x))),
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

class DatumCompany {
  DatumCompany({
    required this.id,
    required this.name,
    required this.code,
    required this.status,
    required this.contactPerson,
    required this.email,
    required this.contactNumber,
    required this.logo,
    required this.addedBy,
  });

  final String id;
  final String name;
  final String code;
  final String status;
  final String contactPerson;
  final String email;
  final String contactNumber;
  final String logo;
  final String addedBy;

  factory DatumCompany.fromJson(Map<String, dynamic> json) => DatumCompany(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        status: json["status"],
        contactPerson: json["contact_person"],
        email: json["email"],
        contactNumber: json["contact_number"],
        logo: json["logo"],
        addedBy: json["added_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "status": status,
        "contact_person": contactPerson,
        "email": email,
        "contact_number": contactNumber,
        "logo": logo,
        "added_by": addedBy,
      };
}
