import 'package:coventil/src/core/extensions/string.dart';

mixin EmailControlMixin {
  String? controlEmail(String? email) => email!.emailValidator();
}
