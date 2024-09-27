import 'package:coventil/src/core/base/model/base_model.dart';

class DeviceDetailModel extends BaseModel<DeviceDetailModel> {
  String? longitude;
  String? latitude;
  String? city;
  String? country;
  List<ConnectedTaskList>? connectedTaskList;
  List<ValveModel>? connectedValveList;
  List<ConnectedSubDeviceList>? connectedSubDeviceList;
  int? deviceId;
  String? serialNumber;
  String? deviceName;
  String? deviceStatus;
  String? deviceType;
  int? connectedValveCount;
  int? connectedSubDeviceCount;
  int? moisturePercentage;
  double? batteryPercentage;

  DeviceDetailModel({
    this.longitude,
    this.latitude,
    this.city,
    this.country,
    this.connectedTaskList,
    this.connectedValveList,
    this.connectedSubDeviceList,
    this.deviceId,
    this.serialNumber,
    this.deviceName,
    this.deviceStatus,
    this.deviceType,
    this.connectedValveCount,
    this.connectedSubDeviceCount,
    this.moisturePercentage,
    this.batteryPercentage,
  });

  @override
  DeviceDetailModel fromJson(Map<String, dynamic> json) => DeviceDetailModel(
        longitude: json["longitude"],
        latitude: json["latitude"],
        city: json["city"],
        country: json["country"],
        connectedTaskList: json["connectedTaskList"] != null
            ? List<ConnectedTaskList>.from(
                json["connectedTaskList"].map((x) => ConnectedTaskList.fromJson(x)),
              )
            : [],
        connectedValveList: json["connectedValveList"] != null
            ? List<ValveModel>.from(
                json["connectedValveList"].map((x) => ValveModel.fromJson(x)),
              )
            : [],
        connectedSubDeviceList: json["connectedSubDeviceList"] != null
            ? List<ConnectedSubDeviceList>.from(
                json["connectedSubDeviceList"].map((x) => ConnectedSubDeviceList.fromJson(x)),
              )
            : <ConnectedSubDeviceList>[],
        deviceId: json["deviceId"],
        serialNumber: json["serialNumber"],
        deviceName: json["deviceName"],
        deviceStatus: json["deviceStatus"],
        deviceType: json["deviceType"],
        connectedValveCount: json["connectedValveCount"],
        connectedSubDeviceCount: json["connectedSubDeviceCount"],
        moisturePercentage: json["moisturePercentage"],
        batteryPercentage: json["batteryPercentage"].toDouble(),
      );

  @override
  Map<String, dynamic> toJson() => {
        "longitude": longitude,
        "latitude": latitude,
        "city": city,
        "country": country,
        "connectedTaskList": connectedTaskList,
        "connectedValveList": List<dynamic>.from(connectedValveList!.map((x) => x)),
        "connectedSubDeviceList":
            List<dynamic>.from(connectedSubDeviceList!.map((x) => x.toJson())),
        "deviceId": deviceId,
        "serialNumber": serialNumber,
        "deviceName": deviceName,
        "deviceStatus": deviceStatus,
        "deviceType": deviceType,
        "connectedValveCount": connectedValveCount,
        "connectedSubDeviceCount": connectedSubDeviceCount,
        "moisturePercentage": moisturePercentage,
        "batteryPercentage": batteryPercentage,
      };
}

class ConnectedSubDeviceList {
  String? name;
  String? status;
  String? serialNumber;
  List<String>? valveNameList;

  ConnectedSubDeviceList({
    this.name,
    this.status,
    this.serialNumber,
    this.valveNameList,
  });

  factory ConnectedSubDeviceList.fromJson(Map<String, dynamic> json) => ConnectedSubDeviceList(
        name: json["name"],
        status: json["status"],
        serialNumber: json["serialNumber"],
        valveNameList: json["valveNameList"] != null
            ? List<String>.from(json["valveNameList"].map((x) => x))
            : <String>[],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "status": status,
        "serialNumber": serialNumber,
        "valveNameList": List<dynamic>.from(valveNameList!.map((x) => x)),
      };
}

class ConnectedTaskList {
  String? taskName;
  String? taskSchedule;

  ConnectedTaskList({this.taskName, this.taskSchedule});

  factory ConnectedTaskList.fromJson(Map<String, dynamic> json) => ConnectedTaskList(
        taskName: json["taskName"],
        taskSchedule: json["taskSchedule"],
      );

  Map<String, dynamic> toJson() => {
        "taskName": taskName,
        "taskSchedule": taskSchedule,
      };
}

class ValveModel {
  int? id;
  String? valveName;
  String? valveStatus;

  ValveModel({
    this.id,
    this.valveName,
    this.valveStatus,
  });

  factory ValveModel.fromJson(Map<String, dynamic> json) => ValveModel(
        id: json["id"],
        valveName: json["valveName"],
        valveStatus: json["valveStatus"],
      );

  Map<String, dynamic> toJson() => {};
}
