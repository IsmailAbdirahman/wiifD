import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:wiifd/data_model/todo_info_model.dart';

import '../main.dart';

final notificationProvider = Provider((ref) => NotificationService());

class NotificationService {
  init() {
    AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
              channelGroupKey: 'Today TodoList',
              channelKey: 'key1',
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests',
              defaultColor: Color(0xFF9D50DD),
              ledColor: Colors.white)
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupkey: 'basic_channel_group',
              channelGroupName: 'Basic group')
        ],
        debug: true);
  }

  notifyBeforeDeleting(TodoInfo todoInfo) async {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(todoInfo.notifyTime!);
    String timeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: int.parse(todoInfo.id!),
            channelKey: 'key1',
            title: ": ${todoInfo.title}",
            summary: todoInfo.description),
        schedule: NotificationCalendar(
          allowWhileIdle: true,
          repeats: false,
          hour: time.hour,
          minute: time.minute,
          second: 0,
          timeZone: timeZone,
        ));
  }


  Future deleteNotificationID(int id) async {
    await AwesomeNotifications().cancel(id);
  }
}
