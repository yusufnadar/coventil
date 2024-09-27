import 'package:coventil/src/core/extensions/string.dart';
import 'package:coventil/src/core/helper/mixin/email_control_mixin.dart';
import 'package:coventil/src/core/helper/mixin/password_control_mixin.dart';
import 'package:coventil/src/presentation/login/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import '../view/login_view.dart';

mixin LoginMixin on State<LoginView>, EmailControlMixin, PasswordControlMixin {
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;

  Future<void> login() async {
    final model = context.read<LoginViewModel>();
    if (controlEmail(emailController.text) != null) {
      fillInputsRedByValidate();
    } else if (controlPassword(passwordController.text) != null) {
      fillInputsRedByValidate();
    } else {
      fillInputsWhiteByValidate();
      await model.login(email: emailController.text, password: passwordController.text);
    }
  }

  void fillInputsRedByValidate() {
    final model = context.read<LoginViewModel>();
    if (emailController.text.emailValidator() != null) {
      model.changeEmailError(value: true);
      fillInputsWhiteByValidate();
    }
    if (passwordController.text == '') {
      model.changePasswordError(value: true);
      fillInputsWhiteByValidate();
    }
  }

  void fillInputsWhiteByValidate() {
    final model = context.read<LoginViewModel>();
    if (emailController.text.emailValidator() == null) {
      model.changeEmailError(value: false);
    }
    if (passwordController.text != '') {
      model.changePasswordError(value: false);
    }
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    init();
  }

  void init() => widget.firstOpen == true ? FlutterNativeSplash.remove() : null;
}
