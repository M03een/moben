import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;
import '../../../core/service/permission_handler.dart';

class NotificationController extends GetxController {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  final MobenPermissionHandler permissionHandler = MobenPermissionHandler();

  // State for each notification checkbox
  var isNotification1Enabled = false.obs;
  var isNotification2Enabled = false.obs;
  var isNotification3Enabled = false.obs;

  void toggleNotification1(bool? value) {
    isNotification1Enabled.value = value ?? false;
  }

  void toggleNotification2(bool? value) {
    isNotification2Enabled.value = value ?? false;
  }

  void toggleNotification3(bool? value) {
    isNotification3Enabled.value = value ?? false;
  }

  // Method to handle time picker for Notification 1
  Future<void> openTimePickerForNotification1(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      DateTime scheduledTime = _getScheduledTime(pickedTime);
      await _scheduleNotification(1, "Notification 1", scheduledTime);
    }
  }

  // Method to handle time picker for Notification 2
  Future<void> openTimePickerForNotification2(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      DateTime scheduledTime = _getScheduledTime(pickedTime);
      await _scheduleNotification(2, "Notification 2", scheduledTime);
    }
  }

  // Method to handle time picker for Notification 3
  Future<void> openTimePickerForNotification3(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      DateTime scheduledTime = _getScheduledTime(pickedTime);
      await _scheduleNotification(3, "Notification 3", scheduledTime);
    }
  }

  DateTime _getScheduledTime(TimeOfDay pickedTime) {
    DateTime now = DateTime.now();
    DateTime scheduledTime = DateTime(
      now.year,
      now.month,
      now.day,
      pickedTime.hour,
      pickedTime.minute,
    );
    if (scheduledTime.isBefore(now)) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }
    return scheduledTime;
  }

  Future<void> _scheduleNotification(int id, String title, DateTime scheduledTime) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'Your Channel Name',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      'This is a scheduled notification',
      tz.TZDateTime.from(scheduledTime, tz.local),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
