import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_clone_instagram/src/components/message_popup.dart';
import 'package:flutter_clone_instagram/src/pages/upload.dart';
import 'package:get/get.dart';

enum PageName { HOME, SEARCH, UPLOAD, ACTIVITY, MYPAGE }

class BottomNavController extends GetxController {
  RxInt pageIndex = 0.obs;
  List<int> bottomHistory = [0]; //최초페이지 0

  void changeBottomNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];
    switch (page) {
      case PageName.UPLOAD:
        Get.to(() => const Upload());
        break;
      case PageName.HOME:
      case PageName.SEARCH:
      case PageName.ACTIVITY:
      case PageName.MYPAGE:
        _changePage(value, hasGesture: hasGesture);
        break;
    }
  }

  void _changePage(int value, {bool hasGesture = true}) {
    pageIndex(value);
    if (!hasGesture) return;
    //[0,1,2,3,4,0] : 계속 쌓임 다만, 같은페이지에서 같은페이지는 눌리지 않음
    if (bottomHistory.last != value) {
      bottomHistory.add(value);
      //print(bottomHistory);
    }
    //[0,1,2,3,4] 한 뒤 더 안쌓임
    // if (bottomHistory.contains(value)) {
    //   bottomHistory.remove(value);
    // }
    // bottomHistory.add(value);
    // print(bottomHistory);
  }

  Future<bool> willPopAction() async {
    if (bottomHistory.length == 1) {
      //1개: 쌓인게 없다
      //print('exit!');
      // 종료 다이얼로그 띄우고 종료
      showDialog(
        context: Get.context!,
        builder: (context) => MessagePopup(
          message: '종료하시겠습니까?',
          okCallback: () {
            exit(0);
          },
          cancelCallback: Get.back,
          title: '시스템',
        ),
      );
      return true;
    } else {
      //print('goto before page!');
      //bottomHistory.removeAt(bottomHistory.length - 1);
      bottomHistory.removeLast();
      var index = bottomHistory.last;
      changeBottomNav(index, hasGesture: false);
      //print(bottomHistory);
      return false;
    }
  }
}
