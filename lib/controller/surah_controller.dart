import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../model/surah_model.dart';

class SurahController extends GetxController {
  final GlobalKey<ScaffoldState> key = GlobalKey();
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

      final String response = await rootBundle.loadString('assets/json/surahs/surahs.json');
      final data = json.decode(response);

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
