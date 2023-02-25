import 'dart:convert';

CompanyModel companyModelFromJson(String str) =>
    CompanyModel.fromJson(json.decode(str));

String companyModelToJson(CompanyModel data) => json.encode(data.toJson());

class CompanyModel {
  CompanyModel({
    required this.success,
    required this.errorcode,
    required this.datumCompany,
    required this.message,
    required this.accessToken,
  });

  final bool success;
  final String errorcode;
  final List<DatumCompany> datumCompany;
  final String message;
  final String accessToken;

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        success: json["success"],
        errorcode: json["errorcode"],
        datumCompany: List<DatumCompany>.from(
            json["data"].map((x) => DatumCompany.fromJson(x))),
        message: json["message"],
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "errorcode": errorcode,
        "DatumCompany": List<dynamic>.from(datumCompany.map((x) => x.toJson())),
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
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.pincode,
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
  final String address1;
  final String address2;
  final String city;
  final String state;
  final String pincode;
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
        address1: json["address_1"],
        address2: json["address_2"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
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
        "address_1": address1,
        "address_2": address2,
        "city": city,
        "state": state,
        "pincode": pincode,
        "added_by": addedBy,
      };
}
