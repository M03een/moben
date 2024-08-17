import 'package:get/get.dart';
import '../model/surah_model.dart';
import '../service/surahs_api.dart';

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
      List<Surah> surahList = await SurahsApi().fetchSurahs();
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
