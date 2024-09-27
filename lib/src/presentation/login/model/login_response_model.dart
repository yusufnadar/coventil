import 'package:coventil/src/core/base/model/base_model.dart';

class LoginResponseModel extends BaseModel<LoginResponseModel> {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? role;
  List<String>? policies;
  String? token;
  String? refreshToken;

  LoginResponseModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.role,
    this.policies,
    this.token,
    this.refreshToken,
  });

  @override
  LoginResponseModel fromJson(Map<String, dynamic> json) => LoginResponseModel(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        role: json["role"],
        policies: json["policies"] != null
            ? List<String>.from(json["policies"].map((x) => x))
            : <String>[],
        token: json["token"],
        refreshToken: json["refreshToken"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "role": role,
        "policies": List<dynamic>.from(policies!.map((x) => x)),
        "token": token,
        "refreshToken": refreshToken,
      };
}
