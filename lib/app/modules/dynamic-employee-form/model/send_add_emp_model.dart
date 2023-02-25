import 'dart:convert';

SendAddDataModel sendAddDataModelFromJson(String str) => SendAddDataModel.fromJson(json.decode(str));

String sendAddDataModelToJson(SendAddDataModel data) => json.encode(data.toJson());

class SendAddDataModel {
    SendAddDataModel({
        required this.success,
        required this.errorcode,
        required this.data,
        required this.message,
        required this.accessToken,
    });

    final bool success;
    final String errorcode;
    final Data data;
    final String message;
    final String accessToken;

    factory SendAddDataModel.fromJson(Map<String, dynamic> json) => SendAddDataModel(
        success: json["success"],
        errorcode: json["errorcode"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
        accessToken: json["access_token"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "errorcode": errorcode,
        "data": data.toJson(),
        "message": message,
        "access_token": accessToken,
    };
}

class Data {
    Data({
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.contactNumber,
        required this.companiesId,
        required this.travelBy,
        required this.arrivalDate,
        required this.arrivalTime,
        required this.addedBy,
        required this.id,
        required this.profilePic,
    });

    final String firstName;
    final String lastName;
    final String email;
    final String contactNumber;
    final String companiesId;
    final String travelBy;
    final String arrivalDate;
    final String arrivalTime;
    final String addedBy;
    final String id;
    final String profilePic;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        contactNumber: json["contact_number"],
        companiesId: json["companies_id"],
        travelBy: json["travel_by"],
        arrivalDate: json["arrival_date"],
        arrivalTime: json["arrival_time"],
        addedBy: json["added_by"],
        id: json["id"],
        profilePic: json["profile_pic"],
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "contact_number": contactNumber,
        "companies_id": companiesId,
        "travel_by": travelBy,
        "arrival_date": arrivalDate,
        "arrival_time": arrivalTime,
        "added_by": addedBy,
        "id": id,
        "profile_pic": profilePic,
    };
}
