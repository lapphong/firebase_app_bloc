import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_app_bloc/assets/assets_path.dart';
import 'package:flutter/material.dart';

class AvatarTeacher extends StatelessWidget {
  const AvatarTeacher({
    super.key,
    required this.urlImg,
    required this.tagImgHero,
  });

  final String urlImg;
  final String tagImgHero;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tagImgHero,
      transitionOnUserGestures: true,
      child: ClipOval(
        child: SizedBox(
          width: 150,
          height: 150,
          child: CachedNetworkImage(
            imageUrl: urlImg,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Image(image: AssetImage(AssetPath.imgLoading)),
            errorWidget: (context, url, error) =>
                const Image(image: AssetImage(AssetPath.imgError)),
          ),
        ),
      ),
    );
  }
}
