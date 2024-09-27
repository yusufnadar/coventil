abstract class BaseModel<T> {
  Map<String, dynamic> toJson();

  T fromJson(Map<String, dynamic> json);
}

class BaseModelI<T extends BaseModel> {
  dynamic errors;
  String elapsedTime;
  int statusCode;
  bool isError;
  dynamic message;
  final T? result;

  BaseModelI({
    required this.errors,
    required this.elapsedTime,
    required this.statusCode,
    required this.isError,
    required this.message,
    required this.result,
  });

  factory BaseModelI.fromJson(Map<String, dynamic> json, T model) => BaseModelI(
        errors: json["errors"],
        elapsedTime: json["elapsedTime"],
        statusCode: json["statusCode"],
        isError: json["isError"],
        message: json["message"],
        result: json["result"] != null ? model.fromJson(json["result"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "errors": errors,
        "elapsedTime": elapsedTime,
        "statusCode": statusCode,
        "isError": isError,
        "message": message,
      };
}

class ListBaseModelI<T extends BaseModel> {
  final bool? status;
  final List<T>? result;
  final int? nextPage;
  final int? totalPages;

  ListBaseModelI({this.status, this.result,this.nextPage,this.totalPages});

  factory ListBaseModelI.fromJson(Map<String, dynamic> json, T model) {
    return ListBaseModelI(
      status: json['status'],
      nextPage: json['nextPage'],
      totalPages: json['totalPages'],
      result: json["result"] != null ? List<T>.from(json['result'].map((e) => model.fromJson(e))) : null,
    );
  }
}
