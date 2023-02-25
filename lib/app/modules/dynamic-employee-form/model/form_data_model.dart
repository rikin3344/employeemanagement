// To parse this JSON data, do
import 'dart:convert';

List<DynamicFormDataModal> dynamicFormDataModalFromJson(String str) => List<DynamicFormDataModal>.from(json.decode(str).map((x) => DynamicFormDataModal.fromJson(x)));

String dynamicFormDataModalToJson(List<DynamicFormDataModal> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DynamicFormDataModal {
    DynamicFormDataModal({
        required this.fieldId,
        required this.value,
        required this.fieldName,
    });

    final String fieldId;
    String value;
    final String fieldName;

    factory DynamicFormDataModal.fromJson(Map<String, dynamic> json) => DynamicFormDataModal(
        fieldId: json["field_id"],
        value: json["value"],
        fieldName: json["field_name"],
    );

    Map<String, dynamic> toJson() => {
        "field_id": fieldId,
        "value": value,
        "field_name": fieldName,
    };
}
