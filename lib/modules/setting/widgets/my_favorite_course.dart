import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../assets/assets_path.dart';
import '../../../themes/themes.dart';

class MyFavoriteCourse extends StatelessWidget {
  const MyFavoriteCourse({
    Key? key,
    required this.title,
    required this.imgUrl,
    required this.onTap,
    required this.tagHeroImg,
  }) : super(key: key);

  final String imgUrl, title;
  final VoidCallback? onTap;
  final String tagHeroImg;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            children: [
              Hero(
                tag: tagHeroImg,
                transitionOnUserGestures: true,
                child: SizedBox(
                  width: 152,
                  height: 172,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: imgUrl,
                      fit: BoxFit.fill,
                      placeholder: (_, __) =>
                          const Image(image: AssetImage(AssetPath.imgLoading)),
                      errorWidget: (context, url, error) =>
                          const Image(image: AssetImage(AssetPath.imgError)),
                    ),
                  ),
                ),
              ),
              Container(
                width: 72,
                height: 28,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: DarkTheme.colorImgPreview,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                  child: const Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      'Preview',
                      style: TxtStyle.headline6,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(title, style: TxtStyle.headline5, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
