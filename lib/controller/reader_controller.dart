import 'package:get/get.dart';

class ReaderController extends GetxController {
  final List<String> readerNames = ['ياسر الدوسري',  'المنشاوي','عبدالباسط', 'الطبلاوي'];
  var selectedReader = 'ياسر الدوسري'.obs;
  var readerIndex = 0.obs;

  @override
  void onInit() {
    selectedReader.value = readerNames[readerIndex.value];
    super.onInit();
  }

  void setSelectedReader({required int newIndex}) {
    readerIndex.value = newIndex;
    selectedReader.value = readerNames[newIndex];
  }

  bool isSelected(int index) {
    return readerIndex.value == index;
  }
}