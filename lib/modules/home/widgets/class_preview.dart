import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../assets/assets_path.dart';
import '../../../themes/themes.dart';
import '../../../widgets/stateless/stateless.dart';

class ClassPreview extends StatelessWidget {
  const ClassPreview({
    Key? key,
    required this.field,
    required this.imgUrl,
    required this.tagHeroImg,
    required this.onTap,
  }) : super(key: key);

  final String field, imgUrl;
  final String tagHeroImg;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          SizedBox(
            width: 152,
            height: 182,
            child: Hero(
              tag: tagHeroImg,
              transitionOnUserGestures: true,
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
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: SizedBox(
                  height: 115,
                  child: CircleButton(
                    assetPath: AssetPath.iconPlay,
                    widthIcon: 15,
                    heightIcon: 15,
                    onTap: onTap,
                  ),
                ),
              ),
              Container(
                height: 39,
                decoration: BoxDecoration(
                  color: DarkTheme.colorImgPreview,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                  child: Center(child: Text(field, style: TxtStyle.headline4)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
