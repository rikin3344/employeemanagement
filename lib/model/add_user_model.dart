import 'dart:convert';

AddUserModel addUserModelFromJson(String str) =>
    AddUserModel.fromJson(json.decode(str));

String addUserModelToJson(AddUserModel data) => json.encode(data.toJson());

class AddUserModel {
  AddUserModel({
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

  factory AddUserModel.fromJson(Map<String, dynamic> json) => AddUserModel(
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
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.companiesId,
    required this.roleId,
    required this.addedBy,
    required this.id,
    required this.profilePic,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String companiesId;
  final String roleId;
  final String addedBy;
  final String id;
  final String profilePic;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        companiesId: json["companies_id"],
        roleId: json["role_id"],
        addedBy: json["added_by"],
        id: json["id"],
        profilePic: json["profile_pic"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone_number": phoneNumber,
        "companies_id": companiesId,
        "role_id": roleId,
        "added_by": addedBy,
        "id": id,
        "profile_pic": profilePic,
      };
}
