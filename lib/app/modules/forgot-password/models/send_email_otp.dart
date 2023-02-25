import 'dart:convert';

SendEmailOtp sendEmailOtpFromJson(String str) =>
    SendEmailOtp.fromJson(json.decode(str));

String sendEmailOtpToJson(SendEmailOtp data) => json.encode(data.toJson());

class SendEmailOtp {
  SendEmailOtp({
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

  factory SendEmailOtp.fromJson(Map<String, dynamic> json) => SendEmailOtp(
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
  });

  final String id;
  final String companiesId;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final dynamic profilePic;
  final String roleId;
  final String addedBy;
  final String status;
  final String otpCode;
  final String otpExpiredAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"].toString(),
        companiesId: json["companies_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phoneNumber: json["phone_number"].toString(),
        profilePic: json["profile_pic"],
        roleId: json["role_id"].toString(),
        addedBy: json["added_by"].toString(),
        status: json["status"].toString(),
        otpCode: json["otp_code"].toString(),
        otpExpiredAt: json["otp_expired_at"].toString(),
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
      };
}
