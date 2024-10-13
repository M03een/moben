import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/core/utils/styles.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import '../../../controller/single_image_controller.dart';

class SingleImageView extends StatelessWidget {
  final String imageUrl;

  SingleImageView({Key? key, required this.imageUrl}) : super(key: key);
  final SingleImageController controller = Get.put(SingleImageController());
  final WidgetsToImageController widgetsToImageController = WidgetsToImageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quran Verse on Image'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              final imageBytes = await widgetsToImageController.capture();
              controller.captureImage(imageBytes!);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.surahController,
                    decoration: const InputDecoration(labelText: 'Surah Number'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: controller.verseController,
                    decoration: const InputDecoration(labelText: 'Verse Number'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                ElevatedButton(
                  onPressed: controller.loadSpecificQuranVerse,
                  child: const Text('Load Verse'),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildAlignmentCheckbox(MainAxisAlignment.start, 'Start', controller),
              _buildAlignmentCheckbox(MainAxisAlignment.center, 'Center', controller),
              _buildAlignmentCheckbox(MainAxisAlignment.end, 'End', controller),
            ],
          ),
          Expanded(
            child: WidgetsToImage(
              controller: widgetsToImageController,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(imageUrl, fit: BoxFit.cover),
                  Obx(() => Column(
                    mainAxisAlignment: controller.textAlignment.value,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          controller.quranVerse.value,
                          style: AppStyles.quranTextStyle30,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Obx(() => controller.capturedImage.value != null
          ? FloatingActionButton(
        onPressed: controller.shareImage,
        child: const Icon(Icons.share),
      )
          : const SizedBox.shrink()), // Return an empty widget if no FloatingActionButton

    );
  }

  Widget _buildAlignmentCheckbox(MainAxisAlignment alignment, String label, SingleImageController controller) {
    return Obx(() => Row(
      children: [
        Checkbox(
          value: controller.textAlignment.value == alignment,
          onChanged: (bool? value) {
            if (value == true) {
              controller.setTextAlignment(alignment);
            }
          },
        ),
        Text(label),
      ],
    ));
  }
}
