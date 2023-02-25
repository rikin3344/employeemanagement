import 'dart:convert';

TransportationModal transportationModalFromJson(String str) => TransportationModal.fromJson(json.decode(str));

String transportationModalToJson(TransportationModal data) => json.encode(data.toJson());

class TransportationModal {
    TransportationModal({
        required this.success,
        required this.errorcode,
        required this.data,
        required this.message,
        required this.accessToken,
    });

    final bool success;
    final String errorcode;
    final List<TransportationData> data;
    final String message;
    final String accessToken;

    factory TransportationModal.fromJson(Map<String, dynamic> json) => TransportationModal(
        success: json["success"],
        errorcode: json["errorcode"],
        data: List<TransportationData>.from(json["data"].map((x) => TransportationData.fromJson(x))),
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

class TransportationData {
    TransportationData({
        required this.id,
        required this.name,
        required this.status,
    });

    final String id;
    final String name;
    final String status;

    factory TransportationData.fromJson(Map<String, dynamic> json) => TransportationData(
        id: json["id"],
        name: json["name"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
    };
}
