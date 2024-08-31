import 'package:flutter/material.dart';
import 'package:moben/core/utils/size_config.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/styles.dart';

class PrayCounter extends StatelessWidget {
  const PrayCounter({
    super.key,
    required this.label,
    required this.increment,
    required this.decrement,
    required this.value,
  });

  final String label;
  final int value;
  final Function() increment;
  final Function() decrement;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight(context) * 0.02,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppStyles.textStyle19.copyWith(fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: increment,
                icon: const Icon(
                  Icons.add,
                  color: AppColors.whiteColor,
                  size: 30,
                ),
              ),
              10.sh,
              Text(
                '$value',
                style: AppStyles.textStyle24,
              ),
              10.sh,
              IconButton(
                onPressed: decrement,
                icon: const Icon(
                  Icons.remove,
                  color: AppColors.whiteColor,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
