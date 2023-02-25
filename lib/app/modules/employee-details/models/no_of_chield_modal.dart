import 'dart:convert';

List<NoOfChildModal> noOfChildModalFromJson(String str) => List<NoOfChildModal>.from(json.decode(str).map((x) => NoOfChildModal.fromJson(x)));

String noOfChildModalToJson(List<NoOfChildModal> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NoOfChildModal {
    NoOfChildModal({
        required this.year,
        required this.value,
    });

    final String year;
    final String value;

    factory NoOfChildModal.fromJson(Map<String, dynamic> json) => NoOfChildModal(
        year: json["year"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "year": year,
        "value": value,
    };
}
