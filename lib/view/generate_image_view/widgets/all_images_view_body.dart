import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../controller/generate_image_controller.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/utils/styles.dart';
import '../views/edit_image_view.dart';

class AllImagesViewBody extends StatelessWidget {
    AllImagesViewBody({super.key});

  final ImageController controller = Get.put(ImageController());


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (controller.imageUrls.isEmpty) {
        return const Center(
          child: Text(
            'لم يتم إيجاد صور',
            style: AppStyles.textStyle19,
          ),
        );
      } else {
        return PageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.imageUrls.length,
          itemBuilder: (context, index) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  controller.imageUrls[index].downloadUrl,
                  fit: BoxFit.cover,
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: Colors.black.withOpacity(0.2),
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.symmetric(vertical: screenHeight(context)*0.04),
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const HugeIcon(
                        icon: HugeIcons.strokeRoundedArrowRight01,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
                // Main content
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(screenHeight(context)*0.05),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => EditImageView(imageUrl: controller.imageUrls[index].downloadUrl));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(
                                controller.imageUrls[index].downloadUrl,
                                fit: BoxFit.contain,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes !=
                                          null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                            (screenHeight(context)*0.05).sh,
                            SvgPicture.asset('assets/images/logo.svg',
                                height: screenHeight(context)*0.1,
                                width: screenWidth(context)*0.1,
                                colorFilter: ColorFilter.mode(AppColors.whiteColor.withOpacity(0.2), BlendMode.srcIn)
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    });
  }
}
