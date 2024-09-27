import 'package:coventil/gen/assets.gen.dart';
import 'package:coventil/src/core/constants/color/app_colors.dart';
import 'package:coventil/src/core/constants/text_styles/app_text_styles.dart';
import 'package:coventil/src/core/services/locator/locator_service.dart';
import 'package:coventil/src/core/services/network/network_service.dart';
import 'package:coventil/src/presentation/search/view_model/search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../widget/search_app_bar.dart';
import '../widget/search_list.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (BuildContext context) => SearchViewModel(getIt<NetworkService>()),
          child: Consumer<SearchViewModel>(
            builder: (BuildContext context, model, Widget? child) {
              return Column(
                children: [
                  const SearchAppBar(),
                  if (context.read<SearchViewModel>().devices.isEmpty == true)
                    Expanded(child: buildCenterSearch())
                  else
                    Expanded(child: SearchList(devices: context.read<SearchViewModel>().devices)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildCenterSearch() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.icons.search, height: 48.h, color: AppColors.gray7),
          SizedBox(height: 24.h),
          Text(
            'Ana ya da alt cihaz ara',
            style: AppStyles.regular(fontSize: 16, color: AppColors.gray7),
          ),
        ],
      ),
    );
  }
}
