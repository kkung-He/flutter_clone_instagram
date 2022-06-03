import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

//Type1 보다 명확하게 하는 게 좋음!
enum AvatarType { TYPE1, TYPE2, TYPE3 }

class AvatarWidget extends StatelessWidget {
  //Story 읽으면(없으면) -> 회색 아니면 색상
  bool? hasStroy;
  String thumbPath;
  String? nickname;
  AvatarType type;
  double? size;

  AvatarWidget({
    Key? key,
    required this.type,
    required this.thumbPath,
    this.hasStroy,
    this.nickname,
    this.size = 65,
  }) : super(key: key);

  Widget type1Widget() {
    return Container(
      //symmetric : 서로 간격 띄우기
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.purple,
            Colors.orange,
          ],
        ),
        shape: BoxShape.circle,
      ),
      child: type2Widget(),
      //중복 소스 이므로 처리
      //이미지 보여주기
      // child: Container(
      //   padding: const EdgeInsets.all(2),
      //   decoration: const BoxDecoration(
      //     shape: BoxShape.circle,
      //     color: Colors.white,
      //   ),
      //   child: ClipRRect(
      //     borderRadius: BorderRadius.circular(size!),
      //     child: SizedBox(
      //       width: size,
      //       height: size,
      //       child: CachedNetworkImage(
      //         imageUrl: thumbPath,
      //         fit: BoxFit.cover,
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  Widget type2Widget() {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size!),
        child: SizedBox(
          width: size,
          height: size,
          child: CachedNetworkImage(
            imageUrl: thumbPath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget type3Widget() {
    return Row(
      children: [
        type1Widget(),
        Text(
          nickname ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AvatarType.TYPE1:
        //그라데이션 있는 것
        return type1Widget();

      case AvatarType.TYPE2:
        return type2Widget();
      case AvatarType.TYPE3:
        return type3Widget();
    }
  }
}
