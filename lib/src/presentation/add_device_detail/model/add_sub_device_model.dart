import 'package:coventil/src/core/base/model/base_model.dart';

class AddSubDeviceModel extends BaseModel<AddSubDeviceModel> {
  String? name;
  int? cityId;
  int? countryId;
  int? cheftaincyId;
  int? parkAndGardenId;
  List<String>? valveNames;
  int? valveCount;
  String? parentDeviceSerialNumber;
  String? serialNumber;
  String? longitude;
  String? latitude;
  int? rainSensorSlotCount;
  int? soilSensorSlotCount;

  AddSubDeviceModel({
    this.name,
    this.cityId,
    this.countryId,
    this.cheftaincyId,
    this.parkAndGardenId,
    this.valveNames,
    this.valveCount,
    this.parentDeviceSerialNumber,
    this.serialNumber,
    this.longitude,
    this.latitude,
    this.rainSensorSlotCount,
    this.soilSensorSlotCount,
  });

  @override
  AddSubDeviceModel fromJson(Map<String, dynamic> json) => AddSubDeviceModel(
        name: json["name"],
        cityId: json["cityId"],
        countryId: json["countryId"],
        cheftaincyId: json["cheftaincyId"],
        parkAndGardenId: json["parkAndGardenId"],
        valveNames:
            json["valveNames"] != null ? List<String>.from(json["valveNames"].map((x) => x)) : null,
        valveCount: json["valveCount"],
        parentDeviceSerialNumber: json["parentDeviceSerialNumber"],
        serialNumber: json["serialNumber"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        rainSensorSlotCount: json["rainSensorSlotCount"],
        soilSensorSlotCount: json["soilSensorSlotCount"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "name": name,
        "cityId": cityId,
        "countryId": countryId,
        "cheftaincyId": cheftaincyId,
        "parkAndGardenId": parkAndGardenId,
        "valveNames": List<dynamic>.from(valveNames!.map((x) => x)),
        "valveCount": valveCount,
        "parentDeviceSerialNumber": parentDeviceSerialNumber,
        "serialNumber": serialNumber,
        "longitude": longitude,
        "latitude": latitude,
        "rainSensorSlotCount": rainSensorSlotCount,
        "soilSensorSlotCount": soilSensorSlotCount,
      };
}
