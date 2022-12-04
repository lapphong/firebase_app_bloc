import 'package:firebase_app_bloc/assets/assets_path.dart';
import 'package:flutter/material.dart';

class AvatarHome extends StatelessWidget {
  const AvatarHome({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CircleAvatar(
        child: FadeInImage.assetNetwork(
          placeholder: AssetPath.imgLoading,
          image: url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
