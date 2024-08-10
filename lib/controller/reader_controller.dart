import 'package:get/get.dart';

class ReaderController extends GetxController {
  final List<String> readerNames = ['ياسر الدوسري', 'عبدالباسط', 'المنشاوي', 'الطبلاوي'];
  var selectedReader = 'defaultReader'.obs;
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
}