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
  var downloadProgress = 0.0.obs;
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



  Future<void> downloadAllSurahs() async {
    if (isDownloading.value) return;

    isDownloading.value = true;
    isPaused.value = false;
    downloadProgress.value = 0.0;
    currentDownloadingSurah.value = 1;
    downloadedSurahs.value = 0;
    _cancelToken = CancelToken();

    final String readerName = readerController.selectedReader.value;
    final List<int> downloadedSurahsList = audioPlaylistController.downloadedSurahsMap[readerName] ?? [];

    for (int i = 1; i <= 114; i++) {
      if (_cancelToken!.isCancelled) break;
      if (!downloadedSurahsList.contains(i)) {
        await downloadSurah(i);
        downloadedSurahs.value++;
      }
      currentDownloadingSurah.value = i + 1;
      downloadProgress.value = i / 114;
      updateNotification();
    }

    isDownloading.value = false;
    showCompletionNotification();
  }

  Future<void> downloadSurah(int surahNumber) async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String readerFolder = '${appDocDir.path}/${readerController.selectedReader.value}';
      await Directory(readerFolder).create(recursive: true);

      String surahUrl = '${HelperFunctions().readerUrl(id: readerController.readerIndex.value)}${surahNumber.toString().padLeft(3, '0')}.mp3';
      String savePath = '$readerFolder/${surahNumber.toString().padLeft(3, '0')}.mp3';

      await dio.download(
        surahUrl,
        savePath,
        cancelToken: _cancelToken,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            double progress = received / total;
          }
        },
      );

      // Update the downloadedSurahsMap
      List<int> currentDownloaded = audioPlaylistController.downloadedSurahsMap[readerController.selectedReader.value] ?? [];
      currentDownloaded.add(surahNumber);
      audioPlaylistController.downloadedSurahsMap[readerController.selectedReader.value] = currentDownloaded;
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.cancel) {
        print("Download cancelled for surah $surahNumber");
      } else {
        print("Download failed for surah $surahNumber: $e");
      }
    }
  }

  void pauseDownload() {
    if (isDownloading.value && !isPaused.value) {
      _cancelToken?.cancel();
      isPaused.value = true;
    }
  }

  void resumeDownload() {
    if (isPaused.value) {
      isPaused.value = false;
      downloadAllSurahs();
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
}