import 'dart:convert';

DynamicFormModel dynamicFormModelFromJson(String str) => DynamicFormModel.fromJson(json.decode(str));

String dynamicFormModelToJson(DynamicFormModel data) => json.encode(data.toJson());

class DynamicFormModel {
    DynamicFormModel({
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

    factory DynamicFormModel.fromJson(Map<String, dynamic> json) => DynamicFormModel(
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
        required this.label,
        required this.fieldName,
        required this.isDefault,
        required this.isRequired,
        required this.type,
        required this.isDeleted,
    });

    final String id;
    final String label;
    final String fieldName;
    final String isDefault;
    final String isRequired;
    final String type;
    final String isDeleted;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        label: json["label"],
        fieldName: json["field_name"],
        isDefault: json["is_default"],
        isRequired: json["is_required"],
        type: json["type"],
        isDeleted: json["is_deleted"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "field_name": fieldName,
        "is_default": isDefault,
        "is_required": isRequired,
        "type": type,
        "is_deleted": isDeleted,
    };
}
