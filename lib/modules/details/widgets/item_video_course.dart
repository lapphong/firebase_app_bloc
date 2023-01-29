import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../assets/assets_path.dart';
import '../../../themes/themes.dart';
import '../../../widgets/stateless/stateless.dart';

class ItemsVideoCourse extends StatelessWidget {
  const ItemsVideoCourse({
    Key? key,
    required this.imgUrl,
    required this.title,
    required this.part,
    required this.time,
    required this.onTap,
    required this.seen,
  }) : super(key: key);

  final String imgUrl, title, part, time;
  final VoidCallback onTap;
  final bool seen;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BodyItemNetwork2(
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
                  textAlign: TextAlign.start,
                ),
                Text(
                  part,
                  style: TxtStyle.headline5
                      .copyWith(color: DarkTheme.greyScale500),
                ),
              ],
            ),
          ),
          right: Align(
            alignment: Alignment.centerRight,
            child: seen
                ? Image.asset(AssetPath.iconChecked,
                    height: 30, width: 30, color: DarkTheme.green)
                : Container(),
          ),
          child: Stack(
            children: [
              Hero(
                tag: imgUrl,
                flightShuttleBuilder: (flightContext, animation, direction,
                    fromContext, toContext) {
                  return RotationTransition(
                    turns: Tween(begin: 0.0, end: 1.0)
                        .chain(CurveTween(curve: Curves.ease))
                        .animate(animation),
                    child: toContext.widget as Hero..child,
                  );
                },
                child: CachedNetworkImage(
                  height: 80,
                  imageUrl: imgUrl,
                  fit: BoxFit.fill,
                  placeholder: (_, __) =>
                      const Image(image: AssetImage(AssetPath.imgLoading)),
                  errorWidget: (context, url, error) =>
                      const Image(image: AssetImage(AssetPath.imgError)),
                ),
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
        ),
        const SizedBox(height: 24),
        const Divider(),
      ],
    );
  }
}
