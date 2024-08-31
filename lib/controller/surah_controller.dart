import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../model/surah_model.dart';

class SurahController extends GetxController {
  var surahs = <Surah>[].obs;
  var filteredSurahs = <Surah>[].obs;
  var isLoading = true.obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    fetchSurahs();
    super.onInit();
  }

  void fetchSurahs() async {
    try {
      isLoading(true);

      // Load JSON data from the asset file
      final String response = await rootBundle.loadString('assets/json/surahs/surahs.json');
      final data = json.decode(response);

      // Convert the JSON data into a list of Surah objects
      List<Surah> surahList = (data['suwar'] as List)
          .map((surahJson) => Surah.fromJson(surahJson))
          .toList();

      surahs.addAll(surahList);
      filteredSurahs.addAll(surahList);
    } catch (error) {
      print("Error fetching surahs: $error");
    } finally {
      isLoading(false);
    }
  }

  void searchSurahs(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredSurahs.assignAll(surahs);
    } else {
      filteredSurahs.assignAll(surahs.where((surah) {
        return surah.name?.toLowerCase().contains(query.toLowerCase()) ?? false;
      }).toList());
    }
  }

  int get filteredSurahsLength => filteredSurahs.length;
}
