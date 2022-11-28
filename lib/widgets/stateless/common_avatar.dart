import 'package:flutter/material.dart';


class CustomAvatar extends StatelessWidget {
  final double height;
  final double width;
  final String assetName;
  final VoidCallback? onTap;

  const CustomAvatar({
    Key? key,
    required this.width,
    required this.height,
    required this.assetName,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(assetName),
          ),
        ),
      ),
    );
  }
}