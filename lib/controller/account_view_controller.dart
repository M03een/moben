import 'package:get/get.dart';
class AccountViewController extends GetxController {

  var isAccount = true.obs;

  toggleTabViewToAccount(){
    isAccount.value = true;
  }

  toggleTabViewToRank(){
    isAccount.value = false;
  }

}