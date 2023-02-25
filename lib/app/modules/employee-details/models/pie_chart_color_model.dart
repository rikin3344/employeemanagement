import 'dart:convert';

List<PieChartColorModel> pieChartColorModelFromJson(String str) => List<PieChartColorModel>.from(json.decode(str).map((x) => PieChartColorModel.fromJson(x)));

String pieChartColorModelToJson(List<PieChartColorModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PieChartColorModel {
    PieChartColorModel({
        required this.name,
        required this.color,
        this.radius = 0.0,
    });

    final String name;
    final String color;
    double radius;

    factory PieChartColorModel.fromJson(Map<String, dynamic> json) => PieChartColorModel(
        name: json["name"],
        color: json["color"],
        radius: json["radius"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "color": color,
        "radius": radius,
    };
}
