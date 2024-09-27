import 'package:coventil/src/core/base/model/base_model.dart';

class WeatherModel extends BaseModel<WeatherModel> {
  int? current;
  List<Forecast>? forecast;

  WeatherModel({
    this.current,
    this.forecast,
  });

  @override
  WeatherModel fromJson(Map<String, dynamic> json) => WeatherModel(
        current: json["current"],
        forecast: json["forecast"] != null
            ? List<Forecast>.from(json["forecast"].map((x) => Forecast.fromJson(x)))
            : <Forecast>[],
      );

  @override
  Map<String, dynamic> toJson() => {
        "current": current,
        "forecast": List<dynamic>.from(forecast!.map((x) => x.toJson())),
      };
}

class Forecast {
  int? key;
  DateTime? date;
  double? lowTemp;
  double? highTemp;
  String? day;
  Condition? condition;

  Forecast({
    this.key,
    this.date,
    this.lowTemp,
    this.highTemp,
    this.day,
    this.condition,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
        key: json["key"],
        date: json["date"] != null ? DateTime.parse(json["date"]) : null,
        lowTemp: json["lowTemp"].toDouble(),
        highTemp: json["highTemp"].toDouble(),
        day: json["day"],
        condition: json["condition"] != null ? Condition.fromJson(json["condition"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "date":
            "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
        "lowTemp": lowTemp,
        "highTemp": highTemp,
        "day": day,
        "condition": condition?.toJson(),
      };
}

class Condition {
  String? text;
  String? icon;
  int? code;

  Condition({
    this.text,
    this.icon,
    this.code,
  });

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        text: json["text"],
        icon: json["icon"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "icon": icon,
        "code": code,
      };
}
