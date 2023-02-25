import 'dart:convert';

List<FieldValueModal> fieldValueModalFromJson(String str) => List<FieldValueModal>.from(json.decode(str).map((x) => FieldValueModal.fromJson(x)));

String fieldValueModalToJson(List<FieldValueModal> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FieldValueModal {
    FieldValueModal({
        required this.field,
        required this.value,
    });

    final String field;
    final String value;

    factory FieldValueModal.fromJson(Map<String, dynamic> json) => FieldValueModal(
        field: json["field"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "field": field,
        "value": value,
    };
}
