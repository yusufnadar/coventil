import 'dart:developer';

import 'package:coventil/src/core/base/model/base_model.dart';
import 'package:coventil/src/core/constants/end_points/app_end_point.dart';
import 'package:coventil/src/core/constants/enums/http_type_enums.dart';
import 'package:coventil/src/core/services/network/network_service.dart';
import 'package:coventil/src/presentation/notifications/model/notification_model.dart';
import 'package:flutter/material.dart';

class NotificationsViewModel extends ChangeNotifier {
  NotificationsViewModel(this._networkService);

  final NetworkService _networkService;

  final notifications = <NotificationModel>[];

  bool completed = false;
  int page = 1;

  Future<void> getNotifications() async {
    final res = await _networkService.start(
      AppEndpoints.getNotifications,
      httpTypes: HttpTypes.get,
    );
    res.fold(
      (error) {
        log('getNotifications error $error');
      },
      (result) {
        final res = ListBaseModelI.fromJson(result!, NotificationModel());
        notifications.clear();
        notifications.addAll(res.result!);
        notifyListeners();
        if (res.nextPage == null) {
          completed = true;
        } else {
          page++;
        }
        notifyListeners();
      },
    );
  }

  Future<void> getNotificationsMore() async {
    if (completed == true) return;
    print(page);
    final res = await _networkService.start(
      AppEndpoints.getNotifications,
      httpTypes: HttpTypes.get,
      queryParameters: {'pageNumber': page},
    );
    res.fold(
      (error) {
        log('getNotificationsMore error $error');
      },
      (result) {
        final res = ListBaseModelI.fromJson(result!, NotificationModel());
        notifications.addAll(res.result!);
        if (page == res.totalPages) {
          completed = true;
        } else {
          page++;
        }
        notifyListeners();
      },
    );
  }

  Future<void> readNotification({required int index,required int notificationId}) async {
    final res = await _networkService.start(
      AppEndpoints.readNotification,
      httpTypes: HttpTypes.post,
      data: {"notificationId": notificationId},
    );
    res.fold(
      (error) {
        log('readNotification error $error');
      },
      (result) {
        notifications[index].notificationRead = true;
        notifyListeners();
        log('readNotification success');
      },
    );
  }
}
