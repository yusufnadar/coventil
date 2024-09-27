import 'package:coventil/src/common/widgets/app_logo.dart';
import 'package:coventil/src/common/widgets/custom_button.dart';
import 'package:coventil/src/core/constants/color/app_colors.dart';
import 'package:coventil/src/core/constants/text_styles/app_text_styles.dart';
import 'package:coventil/src/core/services/locator/locator_service.dart';
import 'package:coventil/src/core/services/route/route_service.dart';
import 'package:coventil/src/presentation/login/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../gen/assets.gen.dart';
import '../../../common/widgets/custom_input.dart';
import '../../../core/constants/route/app_routes.dart';
import '../../../core/helper/mixin/email_control_mixin.dart';
import '../../../core/helper/mixin/password_control_mixin.dart';
import '../mixin/login_mixin.dart';

class LoginView extends StatefulWidget {
  final bool? firstOpen;

  const LoginView({super.key, this.firstOpen});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with EmailControlMixin, PasswordControlMixin, LoginMixin {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Consumer<LoginViewModel>(
        builder: (BuildContext context, model, Widget? child) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Center(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      buildAppLogo(),
                      buildLoginText(),
                      buildLoginDescription(),
                      buildEmailInputTitle(),
                      buildEmailInput(model),
                      buildPasswordInputTitle(),
                      buildPasswordInput(model),
                      buildForgotPassword(model),
                      buildLoginButton(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Padding buildLoginButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: CustomButton(title: 'Giriş Yap', onTap: login),
    );
  }

  Align buildForgotPassword(LoginViewModel model) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(bottom: 48.h),
        child: GestureDetector(
          onTap: () {
            emailController.clear();
            passwordController.clear();
            model.clear();
            getIt<RouteService>().go(path: AppRoutes.forgotPassword);
          },
          child: Text(
            'Şifremi Unuttum',
            style: AppStyles.semiBold(fontSize: 12, color: AppColors.lightGray),
          ),
        ),
      ),
    );
  }

  Padding buildEmailInput(LoginViewModel model) {
    return Padding(
      padding: EdgeInsets.only(top: 4.h, bottom: 24.h),
      child: CustomInput(
        hintText: 'E-mail adresinizi giriniz',
        controller: emailController,
        errorText: 'Not valid email',
        validator: (_) => null,
        error: model.emailError,
      ),
    );
  }

  Padding buildPasswordInput(LoginViewModel model) {
    return Padding(
      padding: EdgeInsets.only(top: 4.h, bottom: 24.h),
      child: CustomInput(
        hintText: 'Şifrenizi giriniz',
        controller: passwordController,
        suffixIcon: Assets.icons.eye,
        obscureText: model.obscure,
        suffixOnTap: model.changeObscure,
        errorText: 'Empty password',
        error: model.passwordError,
        validator: controlPassword,
      ),
    );
  }

  Align buildEmailInputTitle() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'E-mail Adresi',
        style: AppStyles.regular(fontSize: 12, color: AppColors.textDark),
      ),
    );
  }

  Align buildPasswordInputTitle() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Şifre',
        style: AppStyles.regular(fontSize: 12, color: AppColors.textDark),
      ),
    );
  }

  Padding buildLoginDescription() {
    return Padding(
      padding: EdgeInsets.only(top: 4.h, bottom: 72.h),
      child: Text(
        'Lorem ipsum dolor sit amet, consectetur.',
        style: AppStyles.regular(
          fontSize: 16,
          color: AppColors.lightGray,
        ),
      ),
    );
  }

  Text buildLoginText() {
    return Text(
      'Giriş Yap',
      style: AppStyles.semiBold(fontSize: 40, color: AppColors.textDark2),
    );
  }

  Padding buildAppLogo() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.h),
      child: const AppLogo(),
    );
  }
}
