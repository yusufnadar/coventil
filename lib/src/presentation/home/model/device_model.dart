import 'package:coventil/src/core/base/model/base_model.dart';

class DeviceModel extends BaseModel<DeviceModel> {
  String? longitude;
  String? latitude;
  String? parentDeviceSerialNumber;
  int? deviceId;
  String? serialNumber;
  String? deviceName;
  String? deviceStatus;
  String? deviceType;
  int? connectedValveCount;
  int? connectedSubDeviceCount;
  int? moisturePercentage;
  double? batteryPercentage;
  String? status;

  DeviceModel({
    this.longitude,
    this.latitude,
    this.parentDeviceSerialNumber,
    this.deviceId,
    this.serialNumber,
    this.deviceName,
    this.deviceStatus,
    this.deviceType,
    this.connectedValveCount,
    this.connectedSubDeviceCount,
    this.moisturePercentage,
    this.batteryPercentage,
    this.status,
  });

  @override
  DeviceModel fromJson(Map<String, dynamic> json) => DeviceModel(
        longitude: json["longitude"],
        latitude: json["latitude"],
        parentDeviceSerialNumber: json["parentDeviceSerialNumber"],
        deviceId: json["deviceId"],
        status: json["status"],
        serialNumber: json["serialNumber"],
        deviceName: json["deviceName"],
        deviceStatus: json["deviceStatus"],
        deviceType: json["deviceType"],
        connectedValveCount: json["connectedValveCount"],
        connectedSubDeviceCount: json["connectedSubDeviceCount"],
        moisturePercentage: json["moisturePercentage"],
        batteryPercentage:
            json["batteryPercentage"] != null ? json["batteryPercentage"].toDouble() : 0,
      );

  @override
  Map<String, dynamic> toJson() => {
        "longitude": longitude,
        "latitude": latitude,
        "parentDeviceSerialNumber": parentDeviceSerialNumber,
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
