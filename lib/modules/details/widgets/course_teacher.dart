import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../assets/assets_path.dart';
import '../../../themes/themes.dart';
import '../../../widgets/stateless/stateless.dart';

class CourseTeacher extends StatelessWidget {
  const CourseTeacher({
    Key? key,
    required this.assetName,
    this.fullName = '',
    this.specialize = '',
    this.voted = '',
    required this.onTap,
  }) : super(key: key);

  final String? fullName, specialize, voted;
  final String? assetName;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return BodyItemNetwork(
      onTap: onTap,
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
      right: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.pink),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.favorite_outline_sharp, color: Colors.pink),
              const SizedBox(width: 5),
              Text(
                voted!,
                style:
                    TxtStyle.headline4.copyWith(color: DarkTheme.greyScale500),
              ),
            ],
          ),
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
