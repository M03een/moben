import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;
import '../model/azkar_category.dart';
import '../model/azkar_item_model.dart';

class AzkarController extends GetxController {
  var azkarCategories = <String, AzkarCategory>{}.obs;
  var isLoading = true.obs;
  var selectedCategory = Rx<AzkarCategory?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchAzkarData();
  }

  Future<void> fetchAzkarData() async {
    try {
      isLoading(true);
      final jsonData = await rootBundle.rootBundle.loadString('assets/json/azkar/azkar.json');
      final Map<String, dynamic> data = json.decode(jsonData);

      data.forEach((key, value) {
        final categoryData = value as Map<String, dynamic>;
        final List<dynamic> azkarData = categoryData['data'];
        final imageUrl = categoryData['imageUrl'] as String;

        azkarCategories[key] = AzkarCategory(
          name: key,
          imageUrl: imageUrl,
          items: azkarData.map((item) => AzkarItem.fromJson(item)).toList(),
        );
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to load data: $e');
    } finally {
      isLoading(false);
    }
  }

  void selectCategory(String categoryName) {
    selectedCategory.value = azkarCategories[categoryName];
  }
}