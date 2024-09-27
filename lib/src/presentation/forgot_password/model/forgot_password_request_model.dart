import 'package:coventil/src/core/base/model/base_model.dart';

class ForgotPasswordRequestModel extends BaseModel<ForgotPasswordRequestModel> {
  final String? email;

  ForgotPasswordRequestModel({required this.email});

  @override
  ForgotPasswordRequestModel fromJson(Map<String, dynamic> json) =>
      ForgotPasswordRequestModel(email: json['email']);

  @override
  Map<String, dynamic> toJson() => {"email": email};
}
