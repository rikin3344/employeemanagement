import 'dart:convert';

AddEmployeeModel addEmployeeModelFromJson(String str) =>
    AddEmployeeModel.fromJson(json.decode(str));

String addEmployeeModelToJson(AddEmployeeModel data) =>
    json.encode(data.toJson());

class AddEmployeeModel {
  AddEmployeeModel({
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

  factory AddEmployeeModel.fromJson(Map<String, dynamic> json) =>
      AddEmployeeModel(
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
    required this.designation,
    required this.arrivalDate,
    required this.arrivalTime,
    required this.travelBy,
    required this.arrivalPlace,
    required this.addedBy,
    required this.id,
    required this.profilePic,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String contactNumber;
  final String companiesId;
  final String designation;
  final String arrivalDate;
  final String arrivalTime;
  final String travelBy;
  final String arrivalPlace;
  final String addedBy;
  final String id;
  final String profilePic;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        contactNumber: json["contact_number"],
        companiesId: json["companies_id"],
        designation: json["designation"],
        arrivalDate: json["arrival_date"],
        arrivalTime: json["arrival_time"],
        travelBy: json["travel_by"],
        arrivalPlace: json["arrival_place"],
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
        "designation": designation,
        "arrival_date": arrivalDate,
        "arrival_time": arrivalTime,
        "travel_by": travelBy,
        "arrival_place": arrivalPlace,
        "added_by": addedBy,
        "id": id,
        "profile_pic": profilePic,
      };
}
