// To parse this JSON data, do
//
//     final fetchActivityDataModel = fetchActivityDataModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FetchActivityDataModel fetchActivityDataModelFromJson(String str) =>
    FetchActivityDataModel.fromJson(json.decode(str));

String fetchActivityDataModelToJson(FetchActivityDataModel data) =>
    json.encode(data.toJson());

class FetchActivityDataModel {
  FetchActivityDataModel({
    required this.success,
    required this.errorcode,
    required this.data,
    required this.message,
    required this.accessToken,
  });

  final bool success;
  final String errorcode;
  final Map<String, List<Datum>> data;
  final String message;
  final String accessToken;

  factory FetchActivityDataModel.fromJson(Map<String, dynamic> json) =>
      FetchActivityDataModel(
        success: json["success"],
        errorcode: json["errorcode"],
        data: Map.from(json["data"]).map((k, v) =>
            MapEntry<String, List<Datum>>(
                k, List<Datum>.from(v.map((x) => Datum.fromJson(x))))),
        message: json["message"],
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "errorcode": errorcode,
        "data": Map.from(data).map((k, v) => MapEntry<String, dynamic>(
            k, List<dynamic>.from(v.map((x) => x.toJson())))),
        "message": message,
        "access_token": accessToken,
      };
}

class Datum {
  Datum({
    required this.activityId,
    required this.userId,
    required this.comment,
    required this.date,
    required this.time,
    required this.firstName,
    required this.lastName,
  });

  final String activityId;
  final String userId;
  final String comment;
  final DateTime date;
  final String time;
  final String firstName;
  final String lastName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        activityId: json["activity_id"],
        userId: json["user_id"],
        comment: json["comment"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        firstName: json["first_name"],
        lastName: json["last_name"],
      );

  Map<String, dynamic> toJson() => {
        "activity_id": activityId,
        "user_id": userId,
        "comment": comment,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "first_name": firstName,
        "last_name": lastName,
      };
}
