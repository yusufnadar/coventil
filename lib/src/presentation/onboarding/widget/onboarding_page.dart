import 'package:coventil/src/presentation/onboarding/model/page_content_model.dart';
import 'package:coventil/src/presentation/onboarding/view_model/onboarding_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/color/app_colors.dart';
import '../../../core/constants/text_styles/app_text_styles.dart';
import 'expandable_page_view.dart';

class OnboardingPage extends StatelessWidget {
  final List<PageContentModel> pageContents;
  final PageController pageController;

  const OnboardingPage({super.key, required this.pageContents, required this.pageController});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<OnboardingViewModel>(context, listen: false);
    return ExpandablePageView(
      itemCount: pageContents.length,
      controller: pageController,
      onPageChanged: model.changeCurrentIndex,
      itemBuilder: (context, index) {
        return Column(
          children: [
            buildImage(index),
            buildTitle(index),
            buildDescription(index),
          ],
        );
      },
    );
  }

  Text buildDescription(int index) {
    return Text(
      pageContents[index].description,
      style: AppStyles.regular(color: AppColors.textDark),
      textAlign: TextAlign.center,
    );
  }

  Padding buildTitle(int index) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h, bottom: 24.h),
      child: Text(
        pageContents[index].title,
        style: AppStyles.bold(fontSize: 24),
      ),
    );
  }

  Image buildImage(int index) => Image.asset(pageContents[index].image, height: 206.h);
}
