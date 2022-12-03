import 'package:flutter/material.dart';

class AvatarHome extends StatelessWidget {
  const AvatarHome({super.key, required this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: CircleAvatar(
        radius: 100,
        backgroundImage: AssetImage(url!),
      ),
    );
  }
}
