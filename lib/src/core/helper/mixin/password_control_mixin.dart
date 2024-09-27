import 'package:coventil/src/core/extensions/string.dart';

mixin PasswordControlMixin {
  String? controlPassword(String? password) => password!.passwordValidator();
}
