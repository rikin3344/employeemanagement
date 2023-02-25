import 'dart:convert';

NullEmployeeDetailsModel nullEmployeeDetailsModelFromJson(String str) => NullEmployeeDetailsModel.fromJson(json.decode(str));

String nullEmployeeDetailsModelToJson(NullEmployeeDetailsModel data) => json.encode(data.toJson());

class NullEmployeeDetailsModel {
    NullEmployeeDetailsModel({
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

    factory NullEmployeeDetailsModel.fromJson(Map<String, dynamic> json) => NullEmployeeDetailsModel(
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
    final List<GraphDatum123> graphData;
    final List<dynamic> assesmentData;
    final List<dynamic> employeeServices;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        employees: List<Employee>.from(json["employees"].map((x) => Employee.fromJson(x))),
        graphData: List<GraphDatum123>.from(json["graph_data"].map((x) => GraphDatum123.fromJson(x))),
        assesmentData: List<dynamic>.from(json["assesment_data"].map((x) => x)),
        employeeServices: List<dynamic>.from(json["employee_services"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "employees": List<dynamic>.from(employees.map((x) => x.toJson())),
        "graph_data": List<dynamic>.from(graphData.map((x) => x.toJson())),
        "assesment_data": List<dynamic>.from(assesmentData.map((x) => x)),
        "employee_services": List<dynamic>.from(employeeServices.map((x) => x)),
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

class GraphDatum123 {
    GraphDatum123({
        required this.serviceName,
        required this.isRequired,
        required this.status,
    });

    final String serviceName;
    final int isRequired;
    final int status;

    factory GraphDatum123.fromJson(Map<String, dynamic> json) => GraphDatum123(
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
