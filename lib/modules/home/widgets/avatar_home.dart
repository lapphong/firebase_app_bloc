import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_app_bloc/assets/assets_path.dart';
import 'package:flutter/material.dart';

class AvatarHome extends StatelessWidget {
  const AvatarHome({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: 60,
        height: 60,
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              const Image(image: AssetImage(AssetPath.imgLoading)),
          errorWidget: (context, url, error) =>
              const Image(image: AssetImage(AssetPath.imgError)),
        ),
      ),
    );
  }
}
