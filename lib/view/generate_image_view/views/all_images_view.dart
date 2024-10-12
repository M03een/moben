import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moben/core/utils/colors.dart';
import 'package:moben/core/utils/size_config.dart';
import 'package:moben/core/utils/styles.dart';
import 'package:moben/view/generate_image_view/views/single_image_view.dart';
import '../../../controller/generate_image_controller.dart';

class AllImagesView extends StatelessWidget {
  final ImageController controller = Get.put(ImageController());

  AllImagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: const
      //   leading: I
      // ),
      body: Obx(() {
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
                          Get.to(() => SingleImageView(imageUrl: controller.imageUrls[index].downloadUrl));
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
      }),
    );
  }
}
