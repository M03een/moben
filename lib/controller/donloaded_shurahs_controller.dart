import 'dart:io';

import 'package:get/get.dart';
import 'package:moben/controller/reader_controller.dart';
import 'package:path_provider/path_provider.dart';

class DownloadedSurahsController extends GetxController {
  final ReaderController readerController = Get.put(ReaderController());
  var downloadedSurahs = <File>[].obs;
  var readerName = ''.obs;

  @override
  void onInit() {
    readerName = readerController.downloadSelectedReader;
    _fetchDownloadedSurahs(readerName: readerName.value);
    super.onInit();
  }

  Future<void> _fetchDownloadedSurahs({required String readerName}) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String readerFolderPath = '${appDocDir.path}/$readerName';
    Directory readerFolder = Directory(readerFolderPath);

    if (await readerFolder.exists()) {
      List<File> files = readerFolder.listSync().whereType<File>().toList();

      files.sort((a, b) {
        int aNumber = _extractSurahNumber(a.path);
        int bNumber = _extractSurahNumber(b.path);
        return aNumber.compareTo(bNumber);
      });

      downloadedSurahs.value = files;
    }
  }

  int _extractSurahNumber(String filePath) {
    String fileName = filePath.split('/').last;
    String numberPart = fileName.split('.').first;
    return int.tryParse(numberPart) ?? 0;
  }
}