import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:moben/controller/reader_controller.dart';
import 'package:moben/core/service/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

import '../core/utils/helper.dart';
import 'audio_palylist_controller.dart';

class DownloadManager extends GetxController {
  final Dio dio = Dio();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final AudioPlaylistController audioPlaylistController = Get.find<AudioPlaylistController>();
  final ReaderController readerController = Get.find<ReaderController>();

  var isDownloading = false.obs;
  var isPaused = false.obs;
  var currentDownloadingSurah = 0.obs;
  var totalSurahs = 114.obs;
  var downloadedSurahs = 0.obs;

  CancelToken? _cancelToken;

  @override
  void onInit() {
    super.onInit();
    initNotifications();
    _initialize();
  }

  Future<void> _initialize() async {
    await MobenPermissionHandler().checkNotificationPermission();
    await initNotifications();
  }

  Future<void> initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> resetDownloads() async {
    isDownloading.value = false;
    isPaused.value = false;
    currentDownloadingSurah.value = 0;
    downloadedSurahs.value = 0;

    final String readerName = readerController.downloadSelectedReader.value;
    audioPlaylistController.downloadedSurahsMap[readerName]?.clear();
    updateNotification();
  }

  Future<void> downloadAllSurahs(String selectedReader) async {
    if (isDownloading.value) return;

    isDownloading.value = true;
    isPaused.value = false;
    _cancelToken = CancelToken();

    final List<int> downloadedSurahsList = audioPlaylistController.downloadedSurahsMap[selectedReader] ?? [];

    downloadedSurahs.value = downloadedSurahsList.length;

    for (int i = 114; i >= 1; i--) {
      if (_cancelToken!.isCancelled) break;
      if (!downloadedSurahsList.contains(i)) {
        await downloadSurah(i, selectedReader);
        downloadedSurahs.value++;
        currentDownloadingSurah.value = 115 - i; // This will show progress from 1 to 114
        updateNotification();
        refreshDownloadedSurahsList(selectedReader);
      }
    }

    isDownloading.value = false;
    showCompletionNotification();
  }

  Future<void> downloadSurah(int surahNumber, String selectedReader) async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String readerFolder = '${appDocDir.path}/$selectedReader';
      await Directory(readerFolder).create(recursive: true);

      String surahUrl = '${HelperFunctions().readerUrl(id: readerController.downloadReaderIndex.value)}${surahNumber.toString().padLeft(3, '0')}.mp3';
      String savePath = '$readerFolder/${surahNumber.toString().padLeft(3, '0')}.mp3';

      await dio.download(
        surahUrl,
        savePath,
        cancelToken: _cancelToken,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            // You can add additional progress tracking here if needed
          }
        },
      );

      List<int> currentDownloaded = audioPlaylistController.downloadedSurahsMap[selectedReader] ?? [];
      currentDownloaded.add(surahNumber);
      audioPlaylistController.downloadedSurahsMap[selectedReader] = currentDownloaded;
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.cancel) {
        print("Download cancelled for surah $surahNumber");
        showCancelNotification();
      } else {
        print("Download failed for surah $surahNumber: $e");
        showInterruptionNotification();
      }
      await resetDownloads();
    }
  }

  void refreshDownloadedSurahsList(String selectedReader) {
    audioPlaylistController.refreshDownloadedSurahs(readerName: selectedReader);
  }

  void cancelDownload() {
    if (isDownloading.value && !isPaused.value) {
      _cancelToken?.cancel();
      isDownloading.value = false;
      showCancelNotification();
    }
  }

  void updateNotification() {
    flutterLocalNotificationsPlugin.show(
      0,
      'Downloading Surahs',
      'Surah ${currentDownloadingSurah.value}/114',
      NotificationDetails(
        android: AndroidNotificationDetails(
          'download_channel',
          'Download Notifications',
          channelDescription: 'Notifications for surah downloads',
          importance: Importance.low,
          priority: Priority.low,
          showProgress: true,
          maxProgress: 114,
          progress: currentDownloadingSurah.value,
        ),
      ),
    );
  }

  void showCompletionNotification() {
    flutterLocalNotificationsPlugin.show(
      0,
      'Download Complete',
      'All surahs have been downloaded',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'download_channel',
          'Download Notifications',
          channelDescription: 'Notifications for surah downloads',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }

  void showCancelNotification() {
    flutterLocalNotificationsPlugin.show(
      0,
      'Download Cancelled',
      'The download has been cancelled',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'download_channel',
          'Download Notifications',
          channelDescription: 'Notifications for surah downloads',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }

  void showInterruptionNotification() {
    flutterLocalNotificationsPlugin.show(
      0,
      'Download Interrupted',
      'The download has been interrupted due to an error',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'download_channel',
          'Download Notifications',
          channelDescription: 'Notifications for surah downloads',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }
}