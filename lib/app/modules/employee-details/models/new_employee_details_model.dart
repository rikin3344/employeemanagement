import 'dart:convert';

EmployeeDetailsModel employeeDetailsModelFromJson(String str) => EmployeeDetailsModel.fromJson(json.decode(str));

String employeeDetailsModelToJson(EmployeeDetailsModel data) => json.encode(data.toJson());

class EmployeeDetailsModel {
    EmployeeDetailsModel({
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

    factory EmployeeDetailsModel.fromJson(Map<String, dynamic> json) => EmployeeDetailsModel(
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
        required this.assesmentData,
        required this.employeeServices,
    });

    final List<Employee> employees;
    final List<GraphDatum> graphData;
    final AssesmentData assesmentData;
    final List<EmployeeService> employeeServices;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        employees: List<Employee>.from(json["employees"].map((x) => Employee.fromJson(x))),
        graphData: List<GraphDatum>.from(json["graph_data"].map((x) => GraphDatum.fromJson(x))),
        assesmentData: AssesmentData.fromJson(json["assesment_data"]),
        employeeServices: List<EmployeeService>.from(json["employee_services"].map((x) => EmployeeService.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "employees": List<dynamic>.from(employees.map((x) => x.toJson())),
        "graph_data": List<dynamic>.from(graphData.map((x) => x.toJson())),
        "assesment_data": assesmentData.toJson(),
        "employee_services": List<dynamic>.from(employeeServices.map((x) => x.toJson())),
    };
}

class AssesmentData {
    AssesmentData({
        required this.id,
        required this.employeeId,
        required this.merritalStatus,
        required this.whoIsArriving,
        required this.numberOfMembers,
        required this.isDiffrentlyAbled,
        required this.isInterestedForClubMembership,
        required this.hobbies,
        required this.isSpouseWorking,
        required this.spouseRequireSuppoerToWork,
        required this.yourSpouseRequireAssistanceOn,
        required this.noOfChildAndAge,
        required this.kidsBoard,
        required this.howSoonExpectingRelocateFamily,
        required this.requiredRoomSize,
        required this.typeOfHouse,
        required this.buget,
        required this.houseShouldBe,
        required this.arriveAt,
    });

    final int id;
    final int employeeId;
    final String merritalStatus;
    final List<String> whoIsArriving;
    final String numberOfMembers;
    final int isDiffrentlyAbled;
    final int isInterestedForClubMembership;
    final List<String> hobbies;
    final String isSpouseWorking;
    final String spouseRequireSuppoerToWork;
    final List<String> yourSpouseRequireAssistanceOn;
    final List<String> noOfChildAndAge;
    final List<String> kidsBoard;
    final List<String> howSoonExpectingRelocateFamily;
    final String requiredRoomSize;
    final String typeOfHouse;
    final List<String> buget;
    final List<String> houseShouldBe;
    final String arriveAt;

    factory AssesmentData.fromJson(Map<String, dynamic> json) => AssesmentData(
        id: json["id"],
        employeeId: json["employee_id"],
        merritalStatus: json["merrital_status"],
        whoIsArriving: List<String>.from(json["who_is_arriving"].map((x) => x)),
        numberOfMembers: json["number_of_members"],
        isDiffrentlyAbled: json["is_diffrently_abled"],
        isInterestedForClubMembership: json["is_interested_for_club_membership"],
        hobbies: List<String>.from(json["hobbies"].map((x) => x)),
        isSpouseWorking: json["is_spouse_working"],
        spouseRequireSuppoerToWork: json["spouse_require_suppoer_to_work"],
        yourSpouseRequireAssistanceOn: List<String>.from(json["your_spouse_require_assistance_on"].map((x) => x)),
        noOfChildAndAge: List<String>.from(json["no_of_child_and_age"].map((x) => x)),
        kidsBoard: List<String>.from(json["kids_board"].map((x) => x)),
        howSoonExpectingRelocateFamily: List<String>.from(json["how_soon_expecting_relocate_family"].map((x) => x)),
        requiredRoomSize: json["required_room_size"],
        typeOfHouse: json["type_of_house"],
        buget: List<String>.from(json["buget"].map((x) => x)),
        houseShouldBe: List<String>.from(json["house_should_be"].map((x) => x)),
        arriveAt: json["arrive_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "merrital_status": merritalStatus,
        "who_is_arriving": List<dynamic>.from(whoIsArriving.map((x) => x)),
        "number_of_members": numberOfMembers,
        "is_diffrently_abled": isDiffrentlyAbled,
        "is_interested_for_club_membership": isInterestedForClubMembership,
        "hobbies": List<dynamic>.from(hobbies.map((x) => x)),
        "is_spouse_working": isSpouseWorking,
        "spouse_require_suppoer_to_work": spouseRequireSuppoerToWork,
        "your_spouse_require_assistance_on": List<dynamic>.from(yourSpouseRequireAssistanceOn.map((x) => x)),
        "no_of_child_and_age": List<dynamic>.from(noOfChildAndAge.map((x) => x)),
        "kids_board": List<dynamic>.from(kidsBoard.map((x) => x)),
        "how_soon_expecting_relocate_family": List<dynamic>.from(howSoonExpectingRelocateFamily.map((x) => x)),
        "required_room_size": requiredRoomSize,
        "type_of_house": typeOfHouse,
        "buget": List<dynamic>.from(buget.map((x) => x)),
        "house_should_be": List<dynamic>.from(houseShouldBe.map((x) => x)),
        "arrive_at": arriveAt,
    };
}

class EmployeeService {
    EmployeeService({
        required this.id,
        required this.name,
        required this.addedBy,
        required this.status,
        required this.isDefault,
        required this.subServices,
    });

    final String id;
    final String name;
    final String addedBy;
    final String status;
    final String isDefault;
    final List<SubService> subServices;

    factory EmployeeService.fromJson(Map<String, dynamic> json) => EmployeeService(
        id: json["id"],
        name: json["name"],
        addedBy: json["added_by"],
        status: json["status"],
        isDefault: json["is_default"],
        subServices: List<SubService>.from(json["sub_services"].map((x) => SubService.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "added_by": addedBy,
        "status": status,
        "is_default": isDefault,
        "sub_services": List<dynamic>.from(subServices.map((x) => x.toJson())),
    };
}

class SubService {
    SubService({
        required this.id,
        required this.serviceId,
        required this.employeeId,
        required this.assesmentDetailId,
        required this.field,
        required this.value,
    });

    final String id;
    final String serviceId;
    final String employeeId;
    final String assesmentDetailId;
    final String field;
    final String value;

    factory SubService.fromJson(Map<String, dynamic> json) => SubService(
        id: json["id"],
        serviceId: json["service_id"],
        employeeId: json["employee_id"],
        assesmentDetailId: json["assesment_detail_id"],
        field: json["field"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "service_id": serviceId,
        "employee_id": employeeId,
        "assesment_detail_id": assesmentDetailId,
        "field": field,
        "value": value,
    };
}

class Employee {
    Employee({
        required this.id,
        required this.label,
        required this.fieldName,
        required this.isDefault,
        required this.isRequired,
        required this.type,
        required this.isDeleted,
        required this.employeeFieldValue,
    });

    final int id;
    final String label;
    final String fieldName;
    final int isDefault;
    final int isRequired;
    final String type;
    final int isDeleted;
    final EmployeeFieldValue employeeFieldValue;

    factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        label: json["label"],
        fieldName: json["field_name"],
        isDefault: json["is_default"],
        isRequired: json["is_required"],
        type: json["type"],
        isDeleted: json["is_deleted"],
        employeeFieldValue: EmployeeFieldValue.fromJson(json["employee_field_value"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "field_name": fieldName,
        "is_default": isDefault,
        "is_required": isRequired,
        "type": type,
        "is_deleted": isDeleted,
        "employee_field_value": employeeFieldValue.toJson(),
    };
}

class EmployeeFieldValue {
    EmployeeFieldValue({
        required this.id,
        required this.employeeId,
        required this.employeeFieldId,
        required this.value,
    });

    final int id;
    final int employeeId;
    final int employeeFieldId;
    final String value;

    factory EmployeeFieldValue.fromJson(Map<String, dynamic> json) => EmployeeFieldValue(
        id: json["id"],
        employeeId: json["employee_id"],
        employeeFieldId: json["employee_field_id"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "employee_field_id": employeeFieldId,
        "value": value,
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
