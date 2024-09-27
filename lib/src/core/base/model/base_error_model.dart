class BaseErrorModel {
  final int? statusCode;
  final String? message;

  BaseErrorModel({
    this.statusCode,
     required this.message,
  });

  factory BaseErrorModel.fromJson(Map<String, dynamic> json) => BaseErrorModel(
    statusCode: json['statusCode'],
        message: json['message'],
      );
}
