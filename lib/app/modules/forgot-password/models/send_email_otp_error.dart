import 'dart:convert';

SendEmailOtpError sendEmailOtpErrorFromJson(String str) =>
    SendEmailOtpError.fromJson(json.decode(str));

String sendEmailOtpErrorToJson(SendEmailOtpError data) =>
    json.encode(data.toJson());

class SendEmailOtpError {
  SendEmailOtpError({
    required this.success,
    required this.errorcode,
    required this.message,
    required this.data,
  });

  final bool success;
  final String errorcode;
  final String message;
  final List<dynamic> data;

  factory SendEmailOtpError.fromJson(Map<String, dynamic> json) =>
      SendEmailOtpError(
        success: json["success"],
        errorcode: json["errorcode"],
        message: json["message"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "errorcode": errorcode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x)),
      };
}
