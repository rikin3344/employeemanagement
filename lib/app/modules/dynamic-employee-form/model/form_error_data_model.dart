import 'dart:convert';

List<DynamicFormErrorDataModal> dynamicFormErrorDataModalFromJson(String str) => List<DynamicFormErrorDataModal>.from(json.decode(str).map((x) => DynamicFormErrorDataModal.fromJson(x)));

String dynamicFormErrorDataModalToJson(List<DynamicFormErrorDataModal> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DynamicFormErrorDataModal {
    DynamicFormErrorDataModal({
        required this.fieldId,
        required this.value,
        required this.error,
        required this.fieldName,
    });

    final String fieldId;
     String value;
     String error;
     String fieldName;

    factory DynamicFormErrorDataModal.fromJson(Map<String, dynamic> json) => DynamicFormErrorDataModal(
        fieldId: json["field_id"],
        value: json["value"],
        error: json["error"],
        fieldName: json["field_name"],
    );

    Map<String, dynamic> toJson() => {
        "field_id": fieldId,
        "value": value,
        "error": error,
        "field_name": fieldName,
    };
}
