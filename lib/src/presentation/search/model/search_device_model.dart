import 'package:coventil/src/core/base/model/base_model.dart';

class SearchDeviceModel extends BaseModel<SearchDeviceModel> {
  int? id;
  String? value;
  String? serialNumber;
  String? valueLetters;
  String? deviceType;

  SearchDeviceModel({
    this.id,
    this.value,
    this.serialNumber,
    this.valueLetters,
    this.deviceType,
  });

  @override
  SearchDeviceModel fromJson(Map<String, dynamic> json) => SearchDeviceModel(
        id: json["id"],
        value: json["value"],
        serialNumber: json["serialNumber"],
        valueLetters: json["valueLetters"],
        deviceType: json["deviceType"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "serialNumber": serialNumber,
        "valueLetters": valueLetters,
        "deviceType": deviceType,
      };
}
