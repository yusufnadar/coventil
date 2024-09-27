import 'package:coventil/src/core/base/model/base_model.dart';

class ValueModel extends BaseModel<ValueModel> {
  int? id;
  String? value;
  String? serialNumber;

  ValueModel({this.id, this.value, this.serialNumber});

  @override
  ValueModel fromJson(Map<String, dynamic> json) => ValueModel(
        id: json['id'],
        value: json['value'],
        serialNumber: json['serialNumber'],
      );

  @override
  Map<String, dynamic> toJson() => {};
}
