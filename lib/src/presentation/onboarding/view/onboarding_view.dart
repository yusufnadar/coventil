import 'package:coventil/src/core/constants/color/app_colors.dart';
import 'package:coventil/src/presentation/onboarding/view_model/onboarding_view_model.dart';
import 'package:coventil/src/presentation/onboarding/widget/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/app_logo.dart';
import '../../../common/widgets/custom_button.dart';
import '../mixin/onboarding_mixin.dart';

class OnboardingView extends StatefulWidget {
  final bool? firstOpen;

  const OnboardingView({super.key, this.firstOpen});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> with OnboardingMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 26.w),
          child: Consumer<OnboardingViewModel>(
            builder: (BuildContext context, model, Widget? child) {
              return Column(
                children: [
                  buildAppLogo(),
                  OnboardingPage(pageContents: pageContents, pageController: pageController),
                  buildCircles(model),
                  buildContinueButton(model),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Padding buildCircles(OnboardingViewModel model) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          3,
          (index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: index == 1 ? 11.w : 0),
            child: CircleAvatar(
              radius: 4.r,
              backgroundColor: model.currentIndex == index ? AppColors.primaryBlue : AppColors.gray,
            ),
          ),
        ),
      ),
    );
  }

  CustomButton buildContinueButton(OnboardingViewModel model) {
    return CustomButton(
      onTap: () => forward(index: model.currentIndex + 1),
      width: 261.w,
      height: 48.h,
      title: 'Devam et',
    );
  }

  Padding buildAppLogo() {
    return Padding(
      padding: EdgeInsets.only(top: 36.h, bottom: 87.h),
      child: const AppLogo(),
    );
  }
}
