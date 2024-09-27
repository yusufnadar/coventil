import 'package:coventil/src/presentation/search/view_model/search_view_model.dart';
import 'package:coventil/src/presentation/search/widget/search_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

mixin SearchMixin on State<SearchAppBar> {
  final deviceController = TextEditingController();

  @override
  void dispose() {
    deviceController.dispose();
    super.dispose();
  }

  void onChange(String? value) {
    context.read<SearchViewModel>().search(value);
    context.read<SearchViewModel>().clear();
  }
}
