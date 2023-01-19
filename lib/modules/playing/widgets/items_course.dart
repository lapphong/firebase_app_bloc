import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../assets/assets_path.dart';
import '../../../themes/app_color.dart';
import '../../../themes/text_style.dart';
import '../../../widgets/stateless/common_bodyitem.dart';

class ItemsCourse extends StatelessWidget {
  const ItemsCourse({
    Key? key,
    required this.assetName,
    required this.title,
    required this.part,
    required this.time,
    required this.onTap,
  }) : super(key: key);

  final String assetName, title, part, time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BodyItemNetwork2(
      onTap: onTap,
      height: 80,
      widthImg: 112,
      mid: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TxtStyle.courseText,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              part,
              style: TxtStyle.headline5.copyWith(color: DarkTheme.greyScale500),
            ),
          ],
        ),
      ),
      right: Align(
        alignment: Alignment.centerRight,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border:
                Border.all(width: 0.8, color: DarkTheme.white.withOpacity(0.2)),
          ),
          child: Image.asset(AssetPath.iconDownload, height: 20, width: 20),
        ),
      ),
      child: Stack(
        children: [
          CachedNetworkImage(
            height: 80,
            imageUrl: assetName,
            fit: BoxFit.fill,
            placeholder: (_, __) =>
                const Image(image: AssetImage(AssetPath.imgLoading)),
            errorWidget: (context, url, error) =>
                const Image(image: AssetImage(AssetPath.imgError)),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, bottom: 8),
              child: SizedBox(
                width: 36,
                height: 18,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: DarkTheme.greyScale700,
                  ),
                  alignment: Alignment.center,
                  child: Text(time, style: TxtStyle.timeText),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
