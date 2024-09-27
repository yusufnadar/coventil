import 'package:coventil/src/core/helper/mixin/email_control_mixin.dart';
import 'package:coventil/src/presentation/forgot_password/view/forgot_password_view.dart';
import 'package:coventil/src/presentation/forgot_password/view_model/forgot_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

mixin ForgotPasswordMixin on State<ForgotPasswordView>, EmailControlMixin {
  final emailController = TextEditingController();

  Future<void> go() async {
    final model = context.read<ForgotPasswordViewModel>();
    if (controlEmail(emailController.text) != null) {
      model.changeIsError(isError: true);
    } else {
      model.changeIsError(isError: false);
      FocusManager.instance.primaryFocus?.unfocus();
      await model.go(email: emailController.text);
    }
  }
}
