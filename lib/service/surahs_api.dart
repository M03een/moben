import 'package:dio/dio.dart';

import '../model/surah_model.dart';

class SurahsApi {
  final dio = Dio();
  List<Surah> surahs = [];

  Future<dynamic> fetchSurahs() async {
    final response =
        await dio.get('https://mp3quran.net/api/v3/suwar?language=ar');
    if (response.statusCode == 200) {
      for (var element in response.data['suwar']) {
        final Surah surah = Surah.fromJson(element);
        surahs.add(surah);
      }
      return surahs;
    } else {
      return surahs;
    }
  }
}
