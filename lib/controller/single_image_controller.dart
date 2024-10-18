import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

enum TextPosition { top, center, bottom }


class SingleImageController extends GetxController {
  var quranVerse = ''.obs;
  var textAlignment = TextAlign.center.obs;
  var capturedImage = Rxn<Uint8List>();
  TextEditingController surahController = TextEditingController();
  TextEditingController verseStartController = TextEditingController();
  TextEditingController verseEndController = TextEditingController();
  var isSaving = false.obs;

  var textPosition = Rx<Offset>(const Offset(0, 200));
  var textColor = Rx<Color>(Colors.white);
  var textSize = 30.0.obs;
  var textOpacity = 1.0.obs;
  var horizontalPadding = 20.0.obs;

  var glowEnabled = false.obs;
  var glowColor = Colors.white.obs;
  var blurRadius = 10.0.obs;

  var logoAlignment = Alignment.bottomCenter.obs;


  @override
  void onInit() {
    super.onInit();
    ever(textPosition, (_) => updateLogoPosition());
  }

  Future<void> saveChanges(Uint8List? imageBytes) async {
    if (imageBytes != null) {
      isSaving.value = true;
      try {
        await Future.delayed(const Duration(seconds: 2));
        captureImage(imageBytes);
      } catch (e) {
        Get.snackbar('Error', 'Failed to save image');
      } finally {
        isSaving.value = false;
      }
    }
  }


  void pickColorFromImage(Offset position , String imageUrl) async {
    final image = await getImageFromNetwork(imageUrl); // get the image from the network
    final pixelData = await getPixelColor(image, position);
    setTextColor(pixelData);
  }

  Future<ui.Image> getImageFromNetwork(String imageUrl) async {
    final completer = Completer<ui.Image>();
    final networkImage = NetworkImage(imageUrl);
    networkImage.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(info.image);
      }),
    );
    return completer.future;
  }

  Future<Color> getPixelColor(ui.Image image, Offset position) async {
    final byteData = await image.toByteData(
      format: ui.ImageByteFormat.rawRgba,
    );
    final pixelOffset = position.dy.toInt() * image.width + position.dx.toInt();
    final color = Color(byteData!.getUint32(pixelOffset * 4));
    return color;
  }

  Future<void> loadSpecificQuranVerses() async {
    final String response = await rootBundle.loadString('assets/json/quran/quran.json');
    final data = await json.decode(response);
    final verses = data['quran'] as List;

    String surahNumber = surahController.text.padLeft(3, '0');
    int verseStart = int.tryParse(verseStartController.text) ?? 1;
    int verseEnd = int.tryParse(verseEndController.text) ?? verseStart;

    List<String> selectedVerses = [];
    for (int i = verseStart; i <= verseEnd; i++) {
      final verse = verses.firstWhere(
            (v) => v['surah_number'] == surahNumber && v['verse_number'] == i,
        orElse: () => null,
      );
      if (verse != null) {
        selectedVerses.add(verse['content']);
      }
    }

    if (selectedVerses.isNotEmpty) {
      quranVerse.value = selectedVerses.join(' ● ');
    } else {
      quranVerse.value = 'الآيات غير موجودة';
    }
  }

  Future<void> shareImage() async {
    if (capturedImage.value != null) {
      try {
        final directory = await getTemporaryDirectory();
        final file = File('${directory.path}/shared_image.png');
        await file.writeAsBytes(capturedImage.value!);
        await Share.shareXFiles([XFile(file.path)], text: 'شاهد هذه الصورة مع آية قرآنية!');
      } catch (e) {
        Get.snackbar('خطأ', 'فشل مشاركة الصورة: $e');
      }
    }
  }

  void setTextAlignment(TextAlign alignment) {
    textAlignment.value = alignment;
  }

  void setGlowEnabled(bool value) {
    glowEnabled.value = value;
  }

  void pickGlowColor() {
    Get.dialog(
      AlertDialog(
        title: const Text('اختر لون التوهج'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: glowColor.value,
            onColorChanged: setGlowColor,
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('حسنا'),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  void captureImage(Uint8List imageBytes) {
    capturedImage.value = imageBytes;
  }

  void updateTextPosition(Offset delta) {
    textPosition.value += delta;
    updateLogoPosition();
  }
  void updateLogoPosition() {
    if (textPosition.value.dy < Get.context!.height * 0.33) {
      // If text is in the top third, logo goes to bottom
      logoAlignment.value = Alignment.bottomCenter;
    } else if (textPosition.value.dy < Get.context!.height * 0.66) {
      // If text is in the middle third, logo goes to bottom
      logoAlignment.value = Alignment.bottomCenter;
    } else {
      // If text is in the bottom third, logo goes to top
      logoAlignment.value = Alignment.topCenter;
    }
  }

  void setTextPosition(TextPosition position) {
    switch (position) {
      case TextPosition.top:
        textPosition.value = const Offset(0, 20);
        break;
      case TextPosition.center:
        textPosition.value = const Offset(0, 0);
        break;
      case TextPosition.bottom:
        textPosition.value = const Offset(0, -20);
        break;
    }
  }

  void setHorizontalPadding(double padding) {
    horizontalPadding.value = padding;
  }

  void pickTextColor() {
    Get.dialog(
      AlertDialog(
        title: const Text('اختر لون النص'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: textColor.value,
            onColorChanged: setTextColor,
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('حسنا'),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  void setTextColor(Color color) {
    textColor.value = color;
  }

  void setTextSize(double size) {
    textSize.value = size;
  }

  void setTextOpacity(double opacity) {
    textOpacity.value = opacity;
  }

  void toggleGlow(bool enabled) {
    glowEnabled.value = enabled;
  }

  void setGlowColor(Color color) {
    glowColor.value = color;
  }

  void setBlurRadius(double radius) {
    blurRadius.value = radius;
  }
}
