import 'package:coventil/src/packages/info_window/theme.dart';
import 'package:flutter/material.dart';

import 'models/citycab_info_window.dart';

class CustomWindow extends StatelessWidget {
  const CustomWindow({Key? key, required this.info}) : super(key: key);
  final CityCabInfoWindow info;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                color: CityTheme.cityWhite,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: CityTheme.cityBlack.withOpacity(.4),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              width: double.infinity,
              height: double.infinity,
              child: Row(
                children: [
                  if (info.type == InfoWindowType.position)
                    Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      color: CityTheme.cityBlue,
                      height: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${(info.time!.inMinutes) % 60}',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: CityTheme.cityWhite),
                          ),
                          Text(
                            'min',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: CityTheme.cityWhite),
                          ),
                        ],
                      ),
                    ),
                  Expanded(
                      child: Text(
                    '${info.name}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: CityTheme.cityBlack,
                        ),
                  ).paddingAll(8)),
                  Icon(Icons.arrow_forward_ios, size: 16, color: CityTheme.cityBlack),
                  const SizedBox(width: 4),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
