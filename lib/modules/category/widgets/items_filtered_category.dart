import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../assets/assets_path.dart';
import '../../../themes/themes.dart';
import '../../../widgets/stateless/stateless.dart';

class ItemsFilteredCategory extends StatelessWidget {
  ItemsFilteredCategory({
    Key? key,
    required this.onTap,
    required this.titleCourse,
    required this.imgUrl,
    required this.assessmentScore,
    required this.reviewer,
    required this.duration,
  }) : super(key: key);

  final String? titleCourse, imgUrl, duration;
  final int assessmentScore, reviewer;
  final VoidCallback? onTap;

  late final  String _assessmentScore =
      (assessmentScore / reviewer).toDouble().toStringAsFixed(1);

  @override
  Widget build(BuildContext context) {
    return BodyItemNetwork(
      onTap: onTap,
      widthImg: 112,
      height: 90,
      mid: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: SizedBox(
          width: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(titleCourse!, style: TxtStyle.headline4),
              Text(
                'Course duration: ${duration}h',
                style:
                    TxtStyle.headline5.copyWith(color: DarkTheme.greyScale500),
              ),
              Row(
                children: [
                  Text(
                    '$_assessmentScore/5 ⭐  (',
                    style: TxtStyle.headline5
                        .copyWith(color: DarkTheme.greyScale500),
                  ),
                  Image.asset(AssetPath.iconUser, height: 12),
                  Text(' $reviewer)',
                      style: TxtStyle.headline5
                          .copyWith(color: DarkTheme.greyScale500)),
                ],
              ),
            ],
          ),
        ),
      ),
      //childImg: ,
      right: const Text(''),
      child: CachedNetworkImage(
        height: 90,
        imageUrl: imgUrl!,
        fit: BoxFit.cover,
        placeholder: (_, __) =>
            const Image(image: AssetImage(AssetPath.imgLoading)),
        errorWidget: (context, url, error) =>
            const Image(image: AssetImage(AssetPath.imgError)),
      ),
    );
  }
}
