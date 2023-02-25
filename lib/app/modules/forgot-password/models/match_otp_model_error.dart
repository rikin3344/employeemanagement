import 'dart:convert';

MatchOtpError matchOtpErrorFromJson(String str) =>
    MatchOtpError.fromJson(json.decode(str));

String matchOtpErrorToJson(MatchOtpError data) => json.encode(data.toJson());

class MatchOtpError {
  MatchOtpError({
    required this.success,
    required this.errorcode,
    required this.data,
    required this.message,
    required this.accessToken,
  });

  final bool success;
  final String errorcode;
  final List<dynamic> data;
  final String message;
  final String accessToken;

  factory MatchOtpError.fromJson(Map<String, dynamic> json) => MatchOtpError(
        success: json["success"],
        errorcode: json["errorcode"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
        message: json["message"],
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "errorcode": errorcode,
        "data": List<dynamic>.from(data.map((x) => x)),
        "message": message,
        "access_token": accessToken,
      };
}
