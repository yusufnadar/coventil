import 'package:coventil/src/core/base/model/base_model.dart';

class ValidateMainDeviceModel extends BaseModel<ValidateMainDeviceModel> {
  Data? data;

  ValidateMainDeviceModel({this.data});

  @override
  ValidateMainDeviceModel fromJson(Map<String, dynamic> json) => ValidateMainDeviceModel(
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  @override
  Map<String, dynamic> toJson() => {"data": data?.toJson()};
}

class Data {
  String? id;
  Location? location;

  Data({this.id, this.location});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        location: json["location"] != null ? Location.fromJson(json["location"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "location": location?.toJson(),
      };
}

class Location {
  double? longitude;
  double? latitude;

  Location({this.longitude, this.latitude});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        longitude: json["longitude"].toDouble(),
        latitude: json["latitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "longitude": longitude,
        "latitude": latitude,
      };
}
