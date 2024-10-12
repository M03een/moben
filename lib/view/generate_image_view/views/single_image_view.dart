import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

import 'package:widgets_to_image/widgets_to_image.dart';

class SingleImageView extends StatefulWidget {
  final String imageUrl;

  const SingleImageView({super.key, required this.imageUrl});

  @override
  _SingleImageViewState createState() => _SingleImageViewState();
}

class _SingleImageViewState extends State<SingleImageView> {
  WidgetsToImageController controller = WidgetsToImageController();
  Uint8List? capturedImage;
  String quranVerse = '';

  @override
  void initState() {
    super.initState();
    loadRandomQuranVerse();
  }

  Future<void> loadRandomQuranVerse() async {
    final String response = await rootBundle.loadString('assets/json/quran/quran.json');
    final data = await json.decode(response);
    final verses = data['quran'] as List;
    final random = Random();
    final randomVerse = verses[random.nextInt(verses.length)];
    setState(() {
      quranVerse = randomVerse['content'];
    });
  }

  Future<void> shareImage() async {
    if (capturedImage != null) {
      try {
        final directory = await getTemporaryDirectory();
        final file = File('${directory.path}/shared_image.png');
        await file.writeAsBytes(capturedImage!);
        await Share.shareXFiles([XFile(file.path)], text: 'Check out this image with a Quran verse!');
      } catch (e) {
        Get.snackbar('Error', 'Failed to share image: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quran Verse on Image'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              final imageBytes = await controller.capture();
              setState(() {
                capturedImage = imageBytes;
              });
            },
          ),
        ],
      ),
      body: WidgetsToImage(
        controller: controller,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(widget.imageUrl, fit: BoxFit.cover),
            Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  quranVerse,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: capturedImage != null
          ? FloatingActionButton(
        onPressed: shareImage,
        child: const Icon(Icons.share),
      )
          : null,
    );
  }
}