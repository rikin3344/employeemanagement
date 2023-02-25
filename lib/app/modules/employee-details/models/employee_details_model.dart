import 'dart:convert';

EmployeesDetailsModel employeesDetailsModelFromJson(String str) =>
    EmployeesDetailsModel.fromJson(json.decode(str));

String employeesDetailsModelToJson(EmployeesDetailsModel data) =>
    json.encode(data.toJson());

class EmployeesDetailsModel {
  EmployeesDetailsModel({
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

  factory EmployeesDetailsModel.fromJson(Map<String, dynamic> json) =>
      EmployeesDetailsModel(
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
    required this.employees,
    required this.graphData,
  });

  final Employees employees;
  final List<GraphDatum> graphData;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        employees: Employees.fromJson(json["employees"]),
        graphData: List<GraphDatum>.from(
            json["graph_data"].map((x) => GraphDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "employees": employees.toJson(),
        "graph_data": List<dynamic>.from(graphData.map((x) => x.toJson())),
      };
}

class Employees {
  Employees({
    required this.id,
    required this.companiesId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contactNumber,
    required this.profilePic,
    required this.designation,
    required this.arrivalDate,
    required this.arrivalTime,
    required this.travelBy,
    required this.arrivalPlace,
    required this.note,
    required this.hrbpName,
    required this.hrbpContact,
    required this.hrbpEmail,
    required this.businessName,
    required this.legelEntity,
    required this.preferPackage,
    required this.status,
    required this.addedBy,
    required this.company,
    required this.familyMembers,
    required this.services,
  });

  final String id;
  final String companiesId;
  final String firstName;
  final String lastName;
  final String email;
  final String contactNumber;
  final String profilePic;
  final String designation;
  final String arrivalDate;
  final String arrivalTime;
  final String travelBy;
  final String arrivalPlace;
  final String note;
  final String hrbpName;
  final String hrbpContact;
  final String hrbpEmail;
  final String businessName;
  final String legelEntity;
  final String preferPackage;
  final String status;
  final String addedBy;
  final Company company;
  final List<FamilyMember> familyMembers;
  final List<FamilyMember> services;

  factory Employees.fromJson(Map<String, dynamic> json) => Employees(
        id: json["id"],
        companiesId: json["companies_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        contactNumber: json["contact_number"],
        profilePic: json["profile_pic"],
        designation: json["designation"],
        arrivalDate: json["arrival_date"].toString(),
        arrivalTime: json["arrival_time"],
        travelBy: json["travel_by"],
        arrivalPlace: json["arrival_place"],
        note: json["note"],
        hrbpName: json["hrbp_name"],
        hrbpContact: json["hrbp_contact"],
        hrbpEmail: json["hrbp_email"],
        businessName: json["business_name"],
        legelEntity: json["legel_entity"],
        preferPackage: json["prefer_package"],
        status: json["status"],
        addedBy: json["added_by"],
        company: Company.fromJson(json["company"]),
        familyMembers: List<FamilyMember>.from(
            json["family_members"].map((x) => FamilyMember.fromJson(x))),
        services: List<FamilyMember>.from(
            json["services"].map((x) => FamilyMember.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "companies_id": companiesId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "contact_number": contactNumber,
        "profile_pic": profilePic,
        "designation": designation,
        "arrival_date": arrivalDate,
        "arrival_time": arrivalTime,
        "travel_by": travelBy,
        "arrival_place": arrivalPlace,
        "note": note,
        "hrbp_name": hrbpName,
        "hrbp_contact": hrbpContact,
        "hrbp_email": hrbpEmail,
        "business_name": businessName,
        "legel_entity": legelEntity,
        "prefer_package": preferPackage,
        "status": status,
        "added_by": addedBy,
        "company": company.toJson(),
        "family_members":
            List<dynamic>.from(familyMembers.map((x) => x.toJson())),
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
      };
}

class Company {
  Company({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class FamilyMember {
  FamilyMember({
    required this.id,
    required this.familyMember,
    required this.addedBy,
    required this.isDefault,
    required this.status,
    required this.name,
  });

  final String id;
  final String familyMember;
  final String addedBy;
  final String isDefault;
  final String status;
  final String name;

  factory FamilyMember.fromJson(Map<String, dynamic> json) => FamilyMember(
        id: json["id"],
        familyMember:
            json["family_member"] == null ? null : json["family_member"],
        addedBy: json["added_by"],
        isDefault: json["is_default"],
        status: json["status"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "family_member": familyMember == null ? null : familyMember,
        "added_by": addedBy,
        "is_default": isDefault,
        "status": status,
        "name": name == null ? null : name,
      };
}

class GraphDatum {
  GraphDatum({
    required this.serviceName,
    required this.isRequired,
    required this.status,
  });

  final String serviceName;
  final int isRequired;
  final int status;

  factory GraphDatum.fromJson(Map<String, dynamic> json) => GraphDatum(
        serviceName: json["service_name"],
        isRequired: json["is_required"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "service_name": serviceName,
        "is_required": isRequired,
        "status": status,
      };
}
