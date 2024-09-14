import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';
import '../../../core/service/permission_handler.dart';
import '../core/shared_prefrences/moben_shared_pref.dart';

class NotificationController extends GetxController {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  final MobenPermissionHandler permissionHandler = MobenPermissionHandler();
  final MobenSharedPref sharedPref = MobenSharedPref();

  // State for each notification checkbox
  var isNotification1Enabled = false.obs;
  var isNotification2Enabled = false.obs;
  var isNotification3Enabled = false.obs;
  var isNotification4Enabled = false.obs;
  var isNotification5Enabled = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeNotifications();
    _loadNotificationStates();
    _loadAndScheduleNotifications();
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _loadNotificationStates() async {
    isNotification1Enabled.value = await sharedPref.getNotificationActive(1);
    isNotification2Enabled.value = await sharedPref.getNotificationActive(2);
    isNotification3Enabled.value = await sharedPref.getNotificationActive(3);
    isNotification4Enabled.value = await sharedPref.getNotificationActive(4);
    isNotification5Enabled.value = await sharedPref.getNotificationActive(5);
  }

  Future<void> _loadAndScheduleNotifications() async {
    print("Loading and scheduling notifications...");
    await _scheduleNotificationIfTimeExists(1, "أذكار المساء");
    await _scheduleNotificationIfTimeExists(2, "أذكار الصباح");
    await _scheduleNotificationIfTimeExists(3, "قيام الليل");
    await _scheduleNotificationIfTimeExists(4, "ورد قراءة");
    await _scheduleNotificationIfTimeExists(5, "ورد حفظ");
  }

  Future<void> _scheduleNotificationIfTimeExists(int notificationId, String title) async {
    String? timeString = await sharedPref.getNotificationTime(notificationId);
    bool isActive = await sharedPref.getNotificationActive(notificationId);
    print("Notification $notificationId ($title): Time: $timeString, Active: $isActive");

    if (timeString != null && isActive) {
      DateTime now = DateTime.now();
      List<String> timeParts = timeString.split(':');
      int hour = int.parse(timeParts[0]);
      int minute = int.parse(timeParts[1]);

      DateTime scheduledTime = DateTime(
        now.year,
        now.month,
        now.day,
        hour,
        minute,
      );

      if (scheduledTime.isBefore(now)) {
        scheduledTime = scheduledTime.add(const Duration(days: 1));
      }

      await _scheduleDailyNotification(notificationId, title, scheduledTime);
    } else {
      print("No time found or notification not active for $notificationId ($title).");
    }
  }

  Future<void> openTimePickerForNotification(
      BuildContext context, int id, String title) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      DateTime scheduledTime = _getScheduledTime(pickedTime);
      print("User picked time for $title: ${pickedTime.hour}:${pickedTime.minute}");

      String formattedTime = DateFormat('HH:mm').format(scheduledTime);
      await sharedPref.setNotificationTime(id, formattedTime);
      await sharedPref.setNotificationActive(id, true);
      await _updateNotificationState(id, true);
      print("Time saved for notification $id ($title): $formattedTime");

      await _scheduleDailyNotification(id, title, scheduledTime);
    } else {
      print("Time picker canceled for notification $id ($title).");
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
    print("Scheduled time: ${scheduledTime.toString()}");
    return scheduledTime;
  }

  Future<void> _scheduleDailyNotification(int id, String title, DateTime scheduledTime) async {
    bool hasPermission = await permissionHandler.checkAndRequestExactAlarmPermission();
    if (!hasPermission) {
      print("Exact alarm permission not granted for notification $id ($title).");
      Get.snackbar(
        'Permission Required',
        'Please grant permission to schedule exact alarms in the app settings.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    print("Scheduling notification $id ($title) at $scheduledTime");
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'Your Channel Name',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        'This is your daily notification',
        tz.TZDateTime.from(scheduledTime, tz.local),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      );
      print("Notification $id ($title) scheduled successfully.");
    } catch (e) {
      print("Error scheduling notification: $e");
      Get.snackbar(
        'Notification Error',
        'Failed to schedule notification. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> _updateNotificationState(int id, bool isActive) async {
    await sharedPref.setNotificationActive(id, isActive);
    switch (id) {
      case 1:
        isNotification1Enabled.value = isActive;
        break;
      case 2:
        isNotification2Enabled.value = isActive;
        break;
      case 3:
        isNotification3Enabled.value = isActive;
        break;
      case 4:
        isNotification4Enabled.value = isActive;
        break;
      case 5:
        isNotification5Enabled.value = isActive;
        break;
    }
  }

  // Updated toggle methods
  Future<void> toggleNotification1(bool? value) async {
    await _updateNotificationState(1, value ?? false);
    if (value == true) {
      await _scheduleNotificationIfTimeExists(1, "أذكار المساء");
    }
  }

  Future<void> toggleNotification2(bool? value) async {
    await _updateNotificationState(2, value ?? false);
    if (value == true) {
      await _scheduleNotificationIfTimeExists(2, "أذكار الصباح");
    }
  }

  Future<void> toggleNotification3(bool? value) async {
    await _updateNotificationState(3, value ?? false);
    if (value == true) {
      await _scheduleNotificationIfTimeExists(3, "قيام الليل");
    }
  }

  Future<void> toggleNotification4(bool? value) async {
    await _updateNotificationState(4, value ?? false);
    if (value == true) {
      await _scheduleNotificationIfTimeExists(4, "ورد قراءة");
    }
  }

  Future<void> toggleNotification5(bool? value) async {
    await _updateNotificationState(5, value ?? false);
    if (value == true) {
      await _scheduleNotificationIfTimeExists(5, "ورد حفظ");
    }
  }
}