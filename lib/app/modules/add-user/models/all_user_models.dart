import 'dart:convert';

AllUserModel allUserModelFromJson(String str) =>
    AllUserModel.fromJson(json.decode(str));

String allUserModelToJson(AllUserModel data) => json.encode(data.toJson());

class AllUserModel {
  AllUserModel({
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

  factory AllUserModel.fromJson(Map<String, dynamic> json) => AllUserModel(
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
    required this.companiesId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.profilePic,
    required this.roleId,
    required this.addedBy,
    required this.status,
    required this.otpCode,
    required this.otpExpiredAt,
    required this.role,
    required this.company,
  });

  final String id;
  final String companiesId;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String profilePic;
  final String roleId;
  final String addedBy;
  final String status;
  final String otpCode;
  final String otpExpiredAt;
  final Company role;
  final Company company;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        companiesId: json["companies_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        profilePic: json["profile_pic"],
        roleId: json["role_id"],
        addedBy: json["added_by"],
        status: json["status"],
        otpCode: json["otp_code"],
        otpExpiredAt: json["otp_expired_at"].toString(),
        role: Company.fromJson(json["role"]),
        company: Company.fromJson(json["company"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "companies_id": companiesId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone_number": phoneNumber,
        "profile_pic": profilePic,
        "role_id": roleId,
        "added_by": addedBy,
        "status": status,
        "otp_code": otpCode,
        "otp_expired_at": otpExpiredAt.toString(),
        "role": role.toJson(),
        "company": company.toJson(),
      };
}

class Company {
  Company({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
