import 'dart:convert';

FamilyMemberModel familyMemberModelFromJson(String str) =>
    FamilyMemberModel.fromJson(json.decode(str));

String familyMemberModelToJson(FamilyMemberModel data) =>
    json.encode(data.toJson());

class FamilyMemberModel {
  FamilyMemberModel({
    required this.success,
    required this.errorcode,
    required this.data,
    required this.message,
    required this.accessToken,
  });

  final bool success;
  final String errorcode;
  final List<FamilyData> data;
  final String message;
  final String accessToken;

  factory FamilyMemberModel.fromJson(Map<String, dynamic> json) =>
      FamilyMemberModel(
        success: json["success"],
        errorcode: json["errorcode"],
        data: List<FamilyData>.from(
            json["data"].map((x) => FamilyData.fromJson(x))),
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

class FamilyData {
  FamilyData({
    required this.id,
    required this.familyMember,
    required this.addedBy,
    required this.isDefault,
    required this.status,
  });

  final String id;
  final String familyMember;
  final String addedBy;
  final String isDefault;
  final String status;

  factory FamilyData.fromJson(Map<String, dynamic> json) => FamilyData(
        id: json["id"],
        familyMember: json["family_member"],
        addedBy: json["added_by"],
        isDefault: json["is_default"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "family_member": familyMember,
        "added_by": addedBy,
        "is_default": isDefault,
        "status": status,
      };
}
