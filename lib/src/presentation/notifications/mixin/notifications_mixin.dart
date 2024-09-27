import 'package:coventil/src/presentation/notifications/view/notifications_view.dart';
import 'package:coventil/src/presentation/notifications/view_model/notifications_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

mixin NotificationsMixin on State<NotificationsView> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final model = context.read<NotificationsViewModel>();
    scrollController.addListener(
      () {
        if (scrollController.offset >= scrollController.position.maxScrollExtent &&
            !scrollController.position.outOfRange) {
          print('geldii');
          model.getNotificationsMore();
        }
      },
    );
  }
}
