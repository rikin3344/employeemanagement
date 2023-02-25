import 'dart:convert';

SubmitCommentSuccessModel submitCommentSuccessModelFromJson(String str) =>
    SubmitCommentSuccessModel.fromJson(json.decode(str));

String submitCommentSuccessModelToJson(SubmitCommentSuccessModel data) =>
    json.encode(data.toJson());

class SubmitCommentSuccessModel {
  SubmitCommentSuccessModel({
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

  factory SubmitCommentSuccessModel.fromJson(Map<String, dynamic> json) =>
      SubmitCommentSuccessModel(
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
    required this.userId,
    required this.comment,
    required this.date,
    required this.time,
    required this.id,
  });

  final String userId;
  final String comment;
  final DateTime date;
  final String time;
  final int id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        comment: json["comment"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "comment": comment,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "id": id,
      };
}
