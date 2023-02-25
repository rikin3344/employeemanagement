import 'dart:convert';

List<CheckBoxModel> checkBoxModelFromJson(String str) =>
    List<CheckBoxModel>.from(
        json.decode(str).map((x) => CheckBoxModel.fromJson(x)));

String checkBoxModelToJson(List<CheckBoxModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CheckBoxModel {
  CheckBoxModel({
    required this.id,
    this.value = false,
    this.status = '0',
  });

  final String id;
  bool value;
  String status;

  factory CheckBoxModel.fromJson(Map<String, dynamic> json) => CheckBoxModel(
        id: json["id"],
        value: json["value"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "status": status,
      };
}
