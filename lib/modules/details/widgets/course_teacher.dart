import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../../../assets/assets_path.dart';
import '../../../themes/themes.dart';
import '../../../widgets/stateless/stateless.dart';

class CourseTeacher extends StatelessWidget {
  const CourseTeacher({
    Key? key,
    required this.assetName,
    this.fullName = '',
    this.specialize = '',
    this.voted = 0,
    this.isLiked = false,
    required this.onTap,
  }) : super(key: key);

  final String? fullName, specialize;
  final int? voted;
  final String? assetName;
  final bool? isLiked;
  final Future<bool?> Function(bool)? onTap;

  @override
  Widget build(BuildContext context) {
    return BodyItemNetwork2(
      height: 64,
      widthImg: 64,
      mid: Padding(
        padding: const EdgeInsets.only(left: 14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(fullName!, style: TxtStyle.headline3),
            Text(
              specialize!,
              style: TxtStyle.headline5.copyWith(color: DarkTheme.greyScale500),
            ),
          ],
        ),
      ),
      right: Container(
        alignment: Alignment.centerRight,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.pink),
          borderRadius: BorderRadius.circular(10),
        ),
        child: LikeButton(
          size: 25,
          animationDuration: const Duration(milliseconds: 1000),
          likeCount: voted,
          isLiked: isLiked,
          countBuilder: (likeCount, isLiked, text) {
            return Text(
              text,
              style: TxtStyle.headline4.copyWith(
                  color: isLiked ? Colors.pink : DarkTheme.greyScale500),
            );
          },
          likeBuilder: (bool isLiked) {
            return isLiked
                ? const Icon(Icons.favorite_sharp, color: Colors.pink)
                : const Icon(Icons.favorite_outline_sharp, color: Colors.pink);
          },
          onTap: onTap,
        ),
      ),
      child: ClipOval(
        child: SizedBox(
          height: 100,
          width: 100,
          child: CachedNetworkImage(
            imageUrl: assetName!,
            fit: BoxFit.cover,
            placeholder: (_, __) =>
                const Image(image: AssetImage(AssetPath.imgLoading)),
            errorWidget: (context, url, error) =>
                const Image(image: AssetImage(AssetPath.imgError)),
          ),
        ),
      ),
    );
  }
}
