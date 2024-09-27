import 'package:coventil/src/core/base/model/base_model.dart';

class NotificationModel extends BaseModel<NotificationModel> {
  String? title;
  String? notificationType;
  bool? notificationRead;
  DateTime? createdAt;
  String? deviceName;
  String? deviceSerialNumber;
  int? deviceId;
  String? deviceType;
  int? notificationId;

  NotificationModel({
    this.title,
    this.notificationType,
    this.notificationRead,
    this.createdAt,
    this.deviceName,
    this.deviceSerialNumber,
    this.deviceId,
    this.deviceType,
    this.notificationId,
  });

  @override
  NotificationModel fromJson(Map<String, dynamic> json) => NotificationModel(
        title: json["title"],
        notificationId: json["notificationId"],
        notificationType: json["notificationType"],
        notificationRead: json["notificationRead"],
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
        deviceName: json["deviceName"],
        deviceSerialNumber: json["deviceSerialNumber"],
        deviceId: json["deviceId"],
        deviceType: json["deviceType"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "title": title,
        "notificationType": notificationType,
        "notificationRead": notificationRead,
        "notificationId": notificationId,
        "createdAt": createdAt?.toIso8601String(),
        "deviceName": deviceName,
        "deviceSerialNumber": deviceSerialNumber,
        "deviceId": deviceId,
        "deviceType": deviceType,
      };
}
