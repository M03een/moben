import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moben/view/play_view/widgets/surah_bottom_sheet_body.dart';

import '../../../utils/colors.dart';
import '../../../utils/size_config.dart';
import '../../../utils/styles.dart';
import '../../../utils/widgets/custom_bottom_sheet.dart';
import '../../../utils/widgets/glass_container.dart';

class SurahWidget extends StatelessWidget {
  const SurahWidget({
    super.key, required this.surahName, required this.isMakkia,
  });

  final String surahName;
  final bool isMakkia;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      horMargin: 5,
      height: screenHeight(context) * 0.15,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(
                  CupertinoIcons.book_fill,
                  color: AppColors.accentColor,
                  size: 25,
                ),
                (screenWidth(context)*0.01).sw,
                Text(
                  'السورة',
                  style: AppStyles.textStyle19
                      .copyWith(color: AppColors.accentColor),
                )
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  surahName,
                  style: AppStyles.textStyle15.copyWith(
                      color: AppColors.accentColor,
                      fontWeight: FontWeight.w600),
                ),
                IconButton(
                  onPressed: () {
                    showSurahBottomSheet(context);
                  },
                  icon: const Icon(
                    CupertinoIcons.chevron_compact_down,
                    color: AppColors.accentColor,
                    size: 25,
                  ),
                ),
                const Spacer(),
                Text(
                 isMakkia? 'مكية' : 'مدنية',
                  style: AppStyles.textStyle15.copyWith(
                      color: AppColors.accentColor,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showSurahBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: AppColors.primaryColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          )),
      context: context,
      builder: (context) => CustomBottomSheet(child: SurahBottomSheetBody(),

      ),
    );
  }
}
