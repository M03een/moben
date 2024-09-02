import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;
import 'package:moben/core/utils/size_config.dart';
import 'package:moben/core/utils/widgets/snack_bars.dart';
import '../model/azkar_category.dart';
import '../model/azkar_item_model.dart';

class AzkarController extends GetxController {
  final ScrollController scrollController = ScrollController();
  var azkarCategories = <String, AzkarCategory>{}.obs;
  var isLoading = true.obs;
  var selectedCategory = Rx<AzkarCategory?>(null);
  var currentCounts = <String, RxInt>{}.obs;
  var totalProgress = 0.0.obs;
  var currentIndex = 0.obs;


  @override
  void onInit() {
    super.onInit();
    fetchAzkarData();
  }

  Future<void> fetchAzkarData() async {
    try {
      isLoading(true);
      final jsonData = await rootBundle.rootBundle
          .loadString('assets/json/azkar/azkar.json');
      final Map<String, dynamic> data = json.decode(jsonData);

      data.forEach((key, value) {
        final categoryData = value as Map<String, dynamic>;
        final List<dynamic> azkarData = categoryData['data'];
        final imageUrl = categoryData['imageUrl'] as String;

        final items =
            azkarData.map((item) => AzkarItem.fromJson(item)).toList();
        azkarCategories[key] = AzkarCategory(
          name: key,
          imageUrl: imageUrl,
          items: items,
        );

        items.forEach((item) {
          final countKey = '${key}_${item.content}';
          currentCounts[countKey] = 0.obs;
        });
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to load data: $e');
    } finally {
      isLoading(false);
    }
  }

  void selectCategory(String categoryName) {
    selectedCategory.value = azkarCategories[categoryName];
    resetCounts(categoryName);
    updateTotalProgress();
  }

  void incrementCount(String categoryName, String content, BuildContext context) {
    final countKey = '${categoryName}_$content';
    if (currentCounts.containsKey(countKey)) {
      final currentValue = currentCounts[countKey]!.value;
      final maxCount = int.parse(azkarCategories[categoryName]!
          .items
          .firstWhere((item) => item.content == content)
          .count);

      if (currentValue < maxCount) {
        currentCounts[countKey]!.value++;
        updateTotalProgress();

        if (currentCounts[countKey]!.value == maxCount) {
          scrollToNextIndex(currentIndex.value + 1, context);
          currentIndex.value++;
        }

        if (totalProgress.value == 1.0) {
          MobenSnackBars().finishZekrSnackBar();
        }
      }
    }
  }

  void scrollToNextIndex(int index, BuildContext context) {
    if (index < selectedCategory.value!.items.length) {
      scrollController.animateTo(
        index * screenWidth(context) * 0.97,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  bool isZekrFinished(String categoryName, String content) {
    final countKey = '${categoryName}_$content';
    if (currentCounts.containsKey(countKey)) {
      final currentValue = currentCounts[countKey]!.value;
      final maxCount = int.parse(azkarCategories[categoryName]!
          .items
          .firstWhere((item) => item.content == content)
          .count);
      return currentValue >= maxCount;
    }
    return false;
  }


  void resetCounts(String categoryName) {
    azkarCategories[categoryName]?.items.forEach((item) {
      final countKey = '${categoryName}_${item.content}';
      currentCounts[countKey]?.value = 0;
    });
    updateTotalProgress();
  }

  void updateTotalProgress() {
    if (selectedCategory.value == null) return;

    int totalCount = 0;
    int completedCount = 0;

    selectedCategory.value!.items.forEach((item) {
      final itemMaxCount = int.parse(item.count);
      totalCount += itemMaxCount;

      final countKey = '${selectedCategory.value!.name}_${item.content}';
      final currentItemCount = currentCounts[countKey]?.value ?? 0;
      completedCount += currentItemCount;
    });

    totalProgress.value = totalCount > 0 ? completedCount / totalCount : 0.0;
  }
}
