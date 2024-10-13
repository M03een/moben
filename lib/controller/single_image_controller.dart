import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';

class SingleImageController extends GetxController {
  var quranVerse = ''.obs;
  var textAlignment = MainAxisAlignment.center.obs;
  var capturedImage = Rxn<Uint8List>();
  TextEditingController surahController = TextEditingController();
  TextEditingController verseController = TextEditingController();

  Future<void> loadSpecificQuranVerse() async {
    final String response = await rootBundle.loadString('assets/json/quran/quran.json');
    final data = await json.decode(response);
    final verses = data['quran'] as List;

    String surahNumber = surahController.text.padLeft(3, '0');
    int verseNumber = int.tryParse(verseController.text) ?? 1;

    final verse = verses.firstWhere(
          (v) => v['surah_number'] == surahNumber && v['verse_number'] == verseNumber,
      orElse: () => null,
    );

    if (verse != null) {
      quranVerse.value = verse['content'];
    } else {
      quranVerse.value = 'Verse not found';
    }
  }

  Future<void> shareImage() async {
    if (capturedImage.value != null) {
      try {
        final directory = await getTemporaryDirectory();
        final file = File('${directory.path}/shared_image.png');
        await file.writeAsBytes(capturedImage.value!);
        await Share.shareXFiles([XFile(file.path)], text: 'Check out this image with a Quran verse!');
      } catch (e) {
        Get.snackbar('Error', 'Failed to share image: $e');
      }
    }
  }

  void setTextAlignment(MainAxisAlignment alignment) {
    textAlignment.value = alignment;
  }

  void captureImage(Uint8List imageBytes) {
    capturedImage.value = imageBytes;
  }
}
