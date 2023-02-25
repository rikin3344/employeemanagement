import 'dart:convert';

FetchActivityEmptyDataModel fetchActivityEmptyDataModelFromJson(String str) =>
    FetchActivityEmptyDataModel.fromJson(json.decode(str));

String fetchActivityEmptyDataModelToJson(FetchActivityEmptyDataModel data) =>
    json.encode(data.toJson());

class FetchActivityEmptyDataModel {
  FetchActivityEmptyDataModel({
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

  factory FetchActivityEmptyDataModel.fromJson(Map<String, dynamic> json) =>
      FetchActivityEmptyDataModel(
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
