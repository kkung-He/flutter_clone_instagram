import 'package:flutter_clone_instagram/src/controller/bottom_nav_controller.dart';
import 'package:get/get.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    //permanent true : 앱이 종료되는 시점까지 이 인스턴스가 살아있음
    Get.put(BottomNavController(), permanent: true);
  }
}
