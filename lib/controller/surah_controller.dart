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
  final ScrollController scrollController = ScrollController();
  var showJumpToTopButton = false.obs; // Make it observable

  @override
  void onInit() {
    super.onInit();
    fetchSurahs();
    scrollController.addListener(_scrollListener); // Add scroll listener
  }

  void fetchSurahs() async {
    try {
      isLoading(true);
      final String response = await rootBundle.loadString('assets/json/surahs/surahs.json');
      final data = json.decode(response);
      List<Surah> surahList = (data['suwar'] as List).map((surahJson) => Surah.fromJson(surahJson)).toList();
      surahs.addAll(surahList);
      filteredSurahs.addAll(surahList);
    } catch (error) {
      print("Error fetching surahs: $error");
    } finally {
      isLoading(false);
    }
  }

  void _scrollListener() {
    if (scrollController.position.pixels > 300) {
      showJumpToTopButton(true);  // Show button if scrolled more than 300 pixels
    } else {
      showJumpToTopButton(false);  // Hide button
    }
  }

  void scrollToTop() {
    scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
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
