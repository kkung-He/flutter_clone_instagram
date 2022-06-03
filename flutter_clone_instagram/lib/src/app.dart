import 'package:flutter/material.dart';
import 'package:flutter_clone_instagram/src/components/image_data.dart';
import 'package:flutter_clone_instagram/src/controller/bottom_nav_controller.dart';
import 'package:flutter_clone_instagram/src/pages/home.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

//getX
class App extends GetView<BottomNavController> {
  //BottomNavController가 인스턴스로 올라가려면 get에 put을 해줘야함 (어느 시점에 put 해줄것이냐 ? 앱 실행시 바로 등록되므로 main에서 initBinding통해 올려줌)
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //WillPopScope : 뒤로가기 버튼 눌렀을때 처리 / 이벤트 : onWillPop
    return WillPopScope(
      child: Obx(
        () => Scaffold(
          //backgroundColor: Colors.red,
          //appBar: AppBar(),
          body: IndexedStack(
            index: controller.pageIndex.value,
            children: [
              const Home(),
              // Container(
              //   child: Center(child: Text('HOME')),
              // ),
              Container(
                child: Center(child: Text('SEARCH')),
              ),
              Container(
                child: Center(child: Text('UPLOAD')),
              ),
              Container(
                child: Center(child: Text('ACTIVITY')),
              ),
              Container(
                child: Center(child: Text('MYPAGE')),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            //active시 올라가버리는걸 바꿈
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            //backgroundColor: Colors.blue,
            currentIndex: controller.pageIndex.value,
            elevation: 0, //네비 선이 사라짐
            //클릭했을때 상태 관리를 get x로 할 것
            onTap: controller.changeBottomNav,
            items: [
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.homeOff),
                activeIcon: ImageData(IconsPath.homeOn),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.searchOff),
                activeIcon: ImageData(IconsPath.searchOn),
                label: 'search',
              ),
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.uploadIcon),
                label: 'upload',
              ),
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.activeOff),
                activeIcon: ImageData(IconsPath.activeOn),
                label: 'active',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                ),
                label: 'home',
              ),
            ],
          ),
        ),
      ),
      // onWillPop: () async {
      //   return false; //return 타입이 false면 닫지 않겠다 true : 앱 닫겠다.
      // },
      //뒤로 가기 버튼 눌렀을 때 호출 (bool로 리턴)
      onWillPop: controller.willPopAction,
    );
  }
}
