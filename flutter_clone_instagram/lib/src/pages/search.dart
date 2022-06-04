import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiver/iterables.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  //이중 어레이 (2차 배열)
  List<List<int>> groupBox = [[], [], []];
  List<int> groupIndex = [0, 0, 0]; // size를 넣엇을때 size를 각 매칭 되는 위치에 더해줄 것임

  @override
  void initState() {
    super.initState();
    //그룹박스에 사이즈를 담을것
    for (var i = 0; i < 100; i++) {
      //가장 작은 것 찾아서 더해줌
      var gi = groupIndex.indexOf(min<int>(groupIndex)!); //grid index
      var size = 1;
      if (gi != 1) {
        size = Random().nextInt(100) % 2 == 0 ? 1 : 2;
      }
      groupBox[gi].add(size);
      //groupBox[i % 3].add(1);
      groupIndex[gi] += size;
    }
    //print(groupBox);
  }

  Widget _appbar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            margin: const EdgeInsets.only(left: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: const Color(0xffefefef),
            ),
            child: Row(
              children: const [
                Icon(Icons.search),
                Text(
                  '검색',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff838383),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Icon(Icons.location_pin),
        ),
      ],
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      //Column을 3줄 해서 각 컬럼을 그룹으로
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          groupBox.length,
          (index) => Expanded(
            child: Column(
              //2개짜리 (양 끝만)
              children: List.generate(
                groupBox[index].length,
                (jndex) => Container(
                  //디바이스 가로사이즈를 3등분해서 그걸 1사이즈로
                  height: Get.width * 0.33 * groupBox[index][jndex],
                  //랜덤 색상
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.primaries[
                          Random().nextInt(Colors.primaries.length)]),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQk7JDdQo9B5cO7hLYzP8lVDjJwTbxu6aiQqg&usqp=CAU',
                    fit: BoxFit.cover,
                  ),
                ),
              ).toList(),
            ),
          ),
        ).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //appbar가 왜 따로 필요한가? : 스크롤 올리고 내릴 때 앱바가 없어지기 + 생김
            //상태표시 영역 밑으로 앱바를 내리기 위해 (패딩은 디바이스에 따라 달라질 수 있으므로 SafeArea 사용)
            _appbar(),
            //body : grid로 사진들 넣기
            Expanded(
              child: _body(),
            ),
          ],
        ),
      ),
    );
  }
}
