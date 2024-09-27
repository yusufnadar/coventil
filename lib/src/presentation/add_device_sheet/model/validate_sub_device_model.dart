import 'package:coventil/src/core/base/model/base_model.dart';

class ValidateSubDeviceModel extends BaseModel<ValidateSubDeviceModel> {
  Data? data;

  ValidateSubDeviceModel({this.data});

  @override
  ValidateSubDeviceModel fromJson(Map<String, dynamic> json) => ValidateSubDeviceModel(
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  @override
  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  String? id;
  Controllers? controllers;

  Data({this.id, this.controllers});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        controllers: json["controllers"] != null ? Controllers.fromJson(json["controllers"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "controllers": controllers?.toJson(),
      };
}

class Controllers {
  int? rainSensorCount;
  int? soilSensorCount;

  Controllers({this.rainSensorCount, this.soilSensorCount});

  factory Controllers.fromJson(Map<String, dynamic> json) => Controllers(
        rainSensorCount: json["rainSensorCount"],
        soilSensorCount: json["soilSensorCount"],
      );

  Map<String, dynamic> toJson() => {
        "rainSensorCount": rainSensorCount,
        "soilSensorCount": soilSensorCount,
      };
}
