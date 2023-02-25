import 'dart:convert';

AddCompanyModel addCompanyModelFromJson(String str) =>
    AddCompanyModel.fromJson(json.decode(str));

String addCompanyModelToJson(AddCompanyModel data) =>
    json.encode(data.toJson());

class AddCompanyModel {
  AddCompanyModel({
    required this.success,
    required this.errorcode,
    required this.addDatumCompany,
    required this.message,
    required this.accessToken,
  });

  final bool success;
  final String errorcode;
  final AddDatumCompany addDatumCompany;
  final String message;
  final String accessToken;

  factory AddCompanyModel.fromJson(Map<String, dynamic> json) =>
      AddCompanyModel(
        success: json["success"],
        errorcode: json["errorcode"],
        addDatumCompany: AddDatumCompany.fromJson(json["data"]),
        message: json["message"],
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "errorcode": errorcode,
        "AddDatumCompany": addDatumCompany.toJson(),
        "message": message,
        "access_token": accessToken,
      };
}

class AddDatumCompany {
  AddDatumCompany({
    required this.name,
    required this.contactPerson,
    required this.email,
    required this.contactNumber,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.pincode,
    required this.addedBy,
    required this.code,
    required this.id,
    required this.logo,
  });

  final String name;
  final String contactPerson;
  final String email;
  final String contactNumber;
  final String address1;
  final String address2;
  final String city;
  final String state;
  final String pincode;
  final String addedBy;
  final String code;
  final String id;
  final String logo;

  factory AddDatumCompany.fromJson(Map<String, dynamic> json) =>
      AddDatumCompany(
        name: json["name"],
        contactPerson: json["contact_person"],
        email: json["email"],
        contactNumber: json["contact_number"],
        address1: json["address_1"],
        address2: json["address_2"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
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
        "address_1": address1,
        "address_2": address2,
        "city": city,
        "state": state,
        "pincode": pincode,
        "added_by": addedBy,
        "code": code,
        "id": id,
        "logo": logo,
      };
}
