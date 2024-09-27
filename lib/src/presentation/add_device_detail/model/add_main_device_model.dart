import 'package:coventil/src/core/base/model/base_model.dart';

class AddMainDeviceModel extends BaseModel<AddMainDeviceModel> {
  String? name;
  int? cityId;
  int? countryId;
  int? cheftaincyId;
  int? parkAndGardenId;
  String? serialNumber;
  String? longitude;
  String? latitude;

  AddMainDeviceModel({
    this.name,
    this.cityId,
    this.countryId,
    this.cheftaincyId,
    this.parkAndGardenId,
    this.serialNumber,
    this.longitude,
    this.latitude,
  });

  @override
  AddMainDeviceModel fromJson(Map<String, dynamic> json) => AddMainDeviceModel(
        name: json["name"],
        cityId: json["cityId"],
        countryId: json["countryId"],
        cheftaincyId: json["cheftaincyId"],
        parkAndGardenId: json["parkAndGardenId"],
        serialNumber: json["serialNumber"],
        longitude: json["longitude"],
        latitude: json["latitude"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "name": name,
        "cityId": cityId,
        "countryId": countryId,
        "cheftaincyId": cheftaincyId,
        "parkAndGardenId": parkAndGardenId,
        "serialNumber": serialNumber,
        "longitude": longitude,
        "latitude": latitude,
      };
}
