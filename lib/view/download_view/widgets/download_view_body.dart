import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/view/download_view/widgets/reader_item.dart';

import '../../../utils/colors.dart';
import '../../../utils/size_config.dart';
import '../../../utils/styles.dart';

class DownloadViewBody extends StatelessWidget {
  const DownloadViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        screenWidth(context) * 0.05,
        screenHeight(context) * 0.04,
        screenWidth(context) * 0.05,
        0,
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            (screenHeight(context) * 0.03).sh,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (screenWidth(context) * 0.1).sw,
                Text(
                  'التحميلات',
                  style: AppStyles.textStyle24.copyWith(
                    color: AppColors.accentColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    CupertinoIcons.forward,
                    color: AppColors.accentColor,
                    size: 30,
                  ),
                ),
              ],
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return const ReaderItem(
                    readerName: 'ياسر الدوسري',
                    readerImage: 'https://yt3.googleusercontent.com/3gtgHqPBIn5JX3Bu_CoIAYa2VfwABbW38ONNHX3df5062x9qsZhtI371Wp5rYw7ZQ6Je5FyMNQ=s900-c-k-c0x00ffffff-no-rj',
                    downloaded: 3,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

