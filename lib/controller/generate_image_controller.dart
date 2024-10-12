import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../model/image_model.dart';

class ImageController extends GetxController {
  var imageUrls = <ImageModel>[].obs;
  var isLoading = false.obs;
  final Dio _dio = Dio();

  @override
  void onInit() {
    fetchImages();
    super.onInit();
  }


  Future<void> fetchImages() async {
    isLoading.value = true;
    const String owner = 'M03een';
    const String repo = 'wallpapers';
    const String path = '';

    try {
      final response = await _dio.get(
        'https://api.github.com/repos/$owner/$repo/contents/$path',
        options: Options(
          headers: {'Accept': 'application/vnd.github.v3+json'},
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> items = response.data;
        imageUrls.value = ImageModel.fromJsonList(items);
      } else {
        print('Failed to fetch images: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching images with Dio: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
