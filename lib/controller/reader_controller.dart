import 'package:get/get.dart';

class ReaderController extends GetxController {
  final List<String> readerNames = [
    'ياسر الدوسري',
    'المنشاوي',
    'عبدالباسط',
    'الطبلاوي'
  ];
  final List<String> downloadReaderNames = [
    'ياسر الدوسري',
    'المنشاوي',
    'عبدالباسط',
    'الطبلاوي'
  ];
  final List<String> downloadReaderPics = [
    'assets/images/readers/reader_1.png',
    'assets/images/readers/reader_2.png',
    'assets/images/readers/reader_3.png',
    'assets/images/readers/reader_4.png'
  ];
  var selectedReader = 'ياسر الدوسري'.obs;
  var downloadSelectedReader = 'ياسر الدوسري'.obs;
  var readerIndex = 0.obs;
  var downloadReaderIndex = 0.obs;

  @override
  void onInit() {
    selectedReader.value = readerNames[readerIndex.value];
    super.onInit();
  }

  void setSelectedReader({required int newIndex}) {
    readerIndex.value = newIndex;
    selectedReader.value = readerNames[newIndex];
  }

  void setDownloadSelectedReader({required int newIndex}) {
    downloadReaderIndex.value = newIndex;
    downloadSelectedReader.value = readerNames[newIndex];
  }

  bool isSelected(int index) {
    return readerIndex.value == index;
  }
}
