  import 'package:get/get.dart';
  import '../model/surah_model.dart';
  import '../service/surahs_api.dart';

  class SurahController extends GetxController {
    var surahs = <Surah>[].obs;
    var isLoading = true.obs;
    var filteredSurahs = <Surah>[].obs;
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
         surahs.value = surahList;
         filteredSurahs.value = surahList;
      } finally {
        isLoading(false);
      }
    }

    void searchSurahs(String query) {
      searchQuery.value = query;
      if (query.isEmpty) {
        filteredSurahs.value = surahs;
      } else {
        filteredSurahs.value = surahs.where((surah) {
          return surah.name?.toLowerCase().contains(query.toLowerCase()) ?? false;
        }).toList();
      }
    }
  }
