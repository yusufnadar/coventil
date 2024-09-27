import 'package:coventil/gen/assets.gen.dart';
import 'package:coventil/src/core/constants/route/app_routes.dart';
import 'package:coventil/src/core/services/locator/locator_service.dart';
import 'package:coventil/src/core/services/route/route_service.dart';
import 'package:coventil/src/presentation/onboarding/view/onboarding_view.dart';
import 'package:coventil/src/presentation/onboarding/view_model/onboarding_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import '../model/page_content_model.dart';

mixin OnboardingMixin on State<OnboardingView> {
  final pageController = PageController();

  final pageContents = <PageContentModel>[
    PageContentModel(
      image: Assets.images.onboarding.onboardingOne.path,
      title: 'Hoş geldiniz',
      description:
          'Park & Bahçe Sulama Uygulaması Coventil\'e hoş geldiniz! İşte size hızlı bir tur',
    ),
    PageContentModel(
      image: Assets.images.onboarding.onboardingTwo.path,
      title: 'Lokasyon takibi',
      description: 'Sulama yapmak istediğiniz parkı veya bahçeyi seçin.',
    ),
    PageContentModel(
      image: Assets.images.onboarding.onboardingThree.path,
      title: 'Cihaz ekle ve vanaları yönet',
      description: 'Seçtiğiniz alanda Cihaz ekleyin ve sulama süresini ayarlayın.',
    ),
  ];

  void forward({required int index}) {
    if (index != 3) {
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      context.read<OnboardingViewModel>().changeCurrentIndex(index);
    } else {
      getIt<RouteService>().goRemoveUntil(path: AppRoutes.login);
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() => widget.firstOpen == true ? FlutterNativeSplash.remove() : null;
}
