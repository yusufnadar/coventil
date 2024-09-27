import 'package:coventil/src/common/widgets/app_logo.dart';
import 'package:coventil/src/common/widgets/custom_button.dart';
import 'package:coventil/src/common/widgets/custom_input.dart';
import 'package:coventil/src/core/constants/color/app_colors.dart';
import 'package:coventil/src/core/constants/text_styles/app_text_styles.dart';
import 'package:coventil/src/core/services/locator/locator_service.dart';
import 'package:coventil/src/core/services/route/route_service.dart';
import 'package:coventil/src/presentation/forgot_password/view_model/forgot_password_view_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../gen/assets.gen.dart';
import '../../../core/helper/mixin/email_control_mixin.dart';
import '../mixin/forgot_password_mixin.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView>
    with EmailControlMixin, ForgotPasswordMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Center(
            child: Column(
              children: [
                buildAppLogo(),
                buildForgotPasswordTitle(),
                buildEmailInputTitle(),
                buildEmailInput(),
                buildGoButton(),
                buildGoBackOrLogin(),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  RichText buildGoBackOrLogin() {
    return RichText(
      text: TextSpan(
        children: [
          /*
          TextSpan(
            text: 'Geri dön    ',
            style: AppStyles.regular(fontSize: 12, color: AppColors.gray2),
            recognizer: TapGestureRecognizer()..onTap = () => getIt<RouteService>().pop(),
          ),
           */
          TextSpan(
            text: 'Giriş Yap',
            style: AppStyles.medium(fontSize: 12, color: AppColors.blue),
            recognizer: TapGestureRecognizer()..onTap = () => getIt<RouteService>().pop(),
          ),
        ],
      ),
    );
  }

  Padding buildGoButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: CustomButton(onTap: go, title: 'Devam et'),
    );
  }

  Consumer buildEmailInput() {
    return Consumer<ForgotPasswordViewModel>(
      builder: (BuildContext context, model, Widget? child) {
        return CustomInput(
          hintText: 'İş e-posta adresinizi giriniz',
          controller: emailController,
          validator: (_)=> null,
          suffixIcon: (model.isSuccess == true && model.isError == false) ? Assets.icons.successCircle : null,
          error: model.isError,
        );
      },
    );
  }

  Padding buildEmailInputTitle() {
    return Padding(
      padding: EdgeInsets.only(top: 24.h, bottom: 4.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'E-posta',
          style: AppStyles.medium(color: AppColors.textDark),
        ),
      ),
    );
  }

  Text buildForgotPasswordTitle() {
    return Text(
      'Şifremi Sıfırla',
      style: AppStyles.semiBold(fontSize: 32, color: AppColors.textDark2),
    );
  }

  Padding buildAppLogo() {
    return Padding(
      padding: EdgeInsets.only(top: 36.h, bottom: 167.h),
      child: const AppLogo(),
    );
  }
}
