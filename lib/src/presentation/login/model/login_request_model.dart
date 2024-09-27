import 'package:coventil/src/core/base/model/base_model.dart';

class TokenRequestModel extends BaseModel<TokenRequestModel> {
  EmailAndPasswordModel? emailAndPasswordModel;

  TokenRequestModel({this.emailAndPasswordModel});

  @override
  TokenRequestModel fromJson(Map<String, dynamic> json) => TokenRequestModel(
        emailAndPasswordModel: EmailAndPasswordModel.fromJson(json["tokenRequestModel"]),
      );

  @override
  Map<String, dynamic> toJson() => {
        "tokenRequestModel": emailAndPasswordModel?.toJson(),
      };
}

class EmailAndPasswordModel {
  String? email;
  String? password;

  EmailAndPasswordModel({
    this.email,
    this.password,
  });

  factory EmailAndPasswordModel.fromJson(Map<String, dynamic> json) => EmailAndPasswordModel(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
