import 'package:shared_preferences/shared_preferences.dart';

class MobenSharedPref {
  static const _keyIsLoggedIn = 'isLoggedIn';
  static const _keyNotification1Time = 'notification1Time';
  static const _keyNotification2Time = 'notification2Time';
  static const _keyNotification3Time = 'notification3Time';
  static const _keyNotification4Time = 'notification4Time'; // ورد قراءة
  static const _keyNotification5Time = 'notification5Time'; // ورد حفظ


  static const _keyNotification1Active = 'notification1Active';
  static const _keyNotification2Active = 'notification2Active';
  static const _keyNotification3Active = 'notification3Active';
  static const _keyNotification4Active = 'notification4Active';
  static const _keyNotification5Active = 'notification5Active';

  Future<void> setLoggedIn(bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, isLoggedIn);
  }

  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyIsLoggedIn);
  }

  // Save notification time as string "HH:mm"
  Future<void> setNotificationTime(int notificationId, String time) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = _getNotificationKey(notificationId);
    await prefs.setString(key, time);
  }

  // Get notification time as string "HH:mm"
  Future<String?> getNotificationTime(int notificationId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = _getNotificationKey(notificationId);
    return prefs.getString(key);
  }

  String _getNotificationKey(int notificationId) {
    switch (notificationId) {
      case 1:
        return _keyNotification1Time;
      case 2:
        return _keyNotification2Time;
      case 3:
        return _keyNotification3Time;
      case 4:
        return _keyNotification4Time; // ورد قراءة
      case 5:
        return _keyNotification5Time; // ورد حفظ
      default:
        return '';
    }
  }

  Future<void> setNotificationActive(int notificationId, bool isActive) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = _getNotificationActiveKey(notificationId);
    await prefs.setBool(key, isActive);
  }

  // New method to get notification active state
  Future<bool> getNotificationActive(int notificationId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = _getNotificationActiveKey(notificationId);
    return prefs.getBool(key) ?? false;
  }

  String _getNotificationActiveKey(int notificationId) {
    switch (notificationId) {
      case 1:
        return _keyNotification1Active;
      case 2:
        return _keyNotification2Active;
      case 3:
        return _keyNotification3Active;
      case 4:
        return _keyNotification4Active;
      case 5:
        return _keyNotification5Active;
      default:
        return '';
    }
  }
}
