import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:moben/core/utils/size_config.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import '../../../controller/single_image_controller.dart';
import '../../../core/utils/colors.dart';

class EditImageView extends StatelessWidget {
  final String imageUrl;

  EditImageView({super.key, required this.imageUrl});

  final SingleImageController controller = Get.put(SingleImageController());
  final WidgetsToImageController widgetsToImageController =
      WidgetsToImageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WidgetsToImage(
            controller: widgetsToImageController,
            child: Stack(
              fit: StackFit.expand,
              children: [
                GestureDetector(
                    child: Image.network(imageUrl, fit: BoxFit.cover)),
                Obx(() => Positioned(
                      left: 0,
                      right: 0,
                      top: controller.textPosition.value.dy,
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          controller.updateTextPosition(details.delta);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: controller.horizontalPadding.value),
                          child: GlowText(
                            controller.quranVerse.value,
                            style: TextStyle(
                              fontFamily: 'QuranicWall',
                              fontSize: controller.textSize.value,
                              color: controller.textColor.value
                                  .withOpacity(controller.textOpacity.value),
                            ),
                            textAlign: controller.textAlignment.value,
                            textDirection: TextDirection.rtl,
                            glowColor: controller.glowEnabled.value
                                ? controller.glowColor.value
                                : Colors.transparent,
                            // If glow is disabled, make color transparent
                            blurRadius: controller.glowEnabled.value
                                ? controller.blurRadius.value
                                : 0, // If glow is disabled, set blur radius to 0
                          ),
                        ),
                      ),
                    )),
                Obx(() {
                  return Align(
                    alignment: controller.logoAlignment.value,
                    child: SvgPicture.asset(
                      'assets/images/logo.svg',
                      height: screenHeight(context) * 0.1,
                      width: screenWidth(context) * 0.1,
                      colorFilter: ColorFilter.mode(
                        AppColors.whiteColor.withOpacity(0.2),
                        BlendMode.srcIn,
                      ),
                    ),
                  );
                }),

              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                _showCustomizationBottomSheet(context);
              },
              child: const Icon(Icons.edit),
            ),
          ),
        ],
      ),
    );
  }

  void _showCustomizationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.primaryColor,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          expand: false,
          builder: (_, controller) {
            return SingleChildScrollView(
              controller: controller,
              child: Column(
                children: [
                  _buildVerseSelectionSection(context),
                  _buildTextPositioningSection(),
                  _buildTextCustomizationSection(),
                  _buildHorizontalPaddingSection(),
                  _buildGlowCustomizationSection(), // Add this new section
                  _buildSaveChangesAndShareSection(context),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Row _buildSaveChangesAndShareSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accentColor,
          ),
          onPressed: () async {
            final imageBytes = await widgetsToImageController.capture();
            this.controller.captureImage(imageBytes!);
            Navigator.pop(context);
          },
          child: const Text('حفظ التغييرات'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accentColor,
          ),
          onPressed: controller.shareImage,
          child: const Text('مشاركة الصورة'),
        ),
      ],
    );
  }

  Widget _buildVerseSelectionSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Existing Surah and Verse number input fields
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  controller: controller.surahController,
                  decoration: const InputDecoration(labelText: 'رقم السورة'),
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: AppColors.accentColor),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: controller.verseStartController,
                  decoration: const InputDecoration(labelText: 'الآية الأولى'),
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: AppColors.accentColor),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: controller.verseEndController,
                  decoration: const InputDecoration(labelText: 'الآية الأخيرة'),
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: AppColors.accentColor),
                ),
              ),
            ],
          ),

          (screenHeight(context) * 0.01).sh,

          // Button to load specific verses
          ElevatedButton(
            onPressed: controller.loadSpecificQuranVerses,
            child: const Text('تحميل الآيات'),
          ),

          // New TextField to edit the verse
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Obx(() => TextField(
                  onChanged: (value) => controller.quranVerse.value = value,
                  // Dynamically update the verse
                  controller:
                      TextEditingController(text: controller.quranVerse.value),
                  decoration: const InputDecoration(labelText: 'تحرير الآية'),
                  maxLines: null,
                  // Allow multiline text for long verses
                  style: const TextStyle(color: AppColors.accentColor),
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildTextPositioningSection() {
    return Column(
      children: [
        const Text('موضع النص', style: TextStyle(color: AppColors.whiteColor)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentColor),
              onPressed: () => controller.setTextPosition(TextPosition.top),
              child: const Text('أعلى'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentColor),
              onPressed: () => controller.setTextPosition(TextPosition.center),
              child: const Text('وسط'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentColor),
              onPressed: () => controller.setTextPosition(TextPosition.bottom),
              child: const Text('أسفل'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHorizontalPaddingSection() {
    return Column(
      children: [
        const Text('التباعد الأفقي',
            style: TextStyle(color: AppColors.whiteColor)),
        Obx(() => Slider(
              value: controller.horizontalPadding.value,
              min: 0,
              max: 100,
              activeColor: AppColors.accentColor,
              onChanged: controller.setHorizontalPadding,
              label:
                  'التباعد: ${controller.horizontalPadding.value.toStringAsFixed(1)}',
            )),
      ],
    );
  }

  Widget _buildTextCustomizationSection() {
    return Column(
      children: [
        const Text('تخصيص النص', style: TextStyle(color: AppColors.whiteColor)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentColor),
              onPressed: () => controller.pickTextColor(),
              child: const Text('اللون'),
            ),
            Obx(() => Slider(
                  value: controller.textSize.value,
                  min: 10,
                  max: 50,
                  activeColor: AppColors.accentColor,
                  onChanged: controller.setTextSize,
                  label:
                      'الحجم: ${controller.textSize.value.toStringAsFixed(1)}',
                )),
          ],
        ),
        Obx(() => Slider(
              value: controller.textOpacity.value,
              min: 0,
              max: 1,
              activeColor: AppColors.accentColor,
              onChanged: controller.setTextOpacity,
              label:
                  'الشفافية: ${(controller.textOpacity.value * 100).toStringAsFixed(0)}%',
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentColor),
              onPressed: () => controller.setTextAlignment(TextAlign.right),
              child: const Text('يمين'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentColor),
              onPressed: () => controller.setTextAlignment(TextAlign.center),
              child: const Text('وسط'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentColor),
              onPressed: () => controller.setTextAlignment(TextAlign.left),
              child: const Text('يسار'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGlowCustomizationSection() {
    return Column(
      children: [
        const Text('تخصيص التوهج',
            style: TextStyle(color: AppColors.whiteColor)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('تفعيل التوهج',
                style: TextStyle(color: AppColors.whiteColor)),
            Obx(() => Switch(
                  value: controller.glowEnabled.value,
                  onChanged: controller.setGlowEnabled,
                  activeColor: AppColors.accentColor,
                )),
          ],
        ),
        Obx(() => Visibility(
              visible: controller.glowEnabled.value,
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentColor,
                    ),
                    onPressed: () => controller.pickGlowColor(),
                    child: const Text('لون التوهج'),
                  ),
                  Slider(
                    value: controller.blurRadius.value,
                    min: 0,
                    max: 20,
                    activeColor: AppColors.accentColor,
                    onChanged: controller.setBlurRadius,
                    label:
                        'نصف قطر التوهج: ${controller.blurRadius.value.toStringAsFixed(1)}',
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
