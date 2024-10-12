class ImageModel {
  final String downloadUrl;

  ImageModel({required this.downloadUrl});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(downloadUrl: json['download_url']);
  }

  static List<ImageModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .where((item) => item['type'] == 'file' &&
        ['png', 'jpg', 'jpeg', 'gif'].contains(item['name'].split('.').last.toLowerCase()))
        .map((item) => ImageModel.fromJson(item))
        .toList();
  }
}
