import 'dart:convert';

List<RadioStatusModal> radioStatusModalFromJson(String str) => List<RadioStatusModal>.from(json.decode(str).map((x) => RadioStatusModal.fromJson(x)));

String radioStatusModalToJson(List<RadioStatusModal> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RadioStatusModal {
    RadioStatusModal({
        required this.name,
        required this.value,
    });

    final String name;
    String value;

    factory RadioStatusModal.fromJson(Map<String, dynamic> json) => RadioStatusModal(
        name: json["name"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
    };
}
