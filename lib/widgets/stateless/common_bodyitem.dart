import 'package:firebase_app_bloc/themes/app_color.dart';
import 'package:flutter/material.dart';

class BodyItemNetwork extends StatelessWidget {
  const BodyItemNetwork({
    Key? key,
    this.height = 0,
    this.widthImg = 0,
    //this.assetName = '',
    this.radius = 10,
    this.mid,
    this.child,
    required this.right,
    this.onTap,
  }) : super(key: key);

  final double height, widthImg, radius;
  //final String assetName;
  final Widget? mid, child;
  final Widget right;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: widthImg,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radius),
                    child: child,
                  ),
                ),
                SizedBox(height: height, child: mid),
                Expanded(child: right),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BodyItemNetwork2 extends StatelessWidget {
  const BodyItemNetwork2({
    Key? key,
    this.height = 0,
    this.widthImg = 0,
    this.radius = 10,
    this.mid,
    this.child,
    required this.right,
    this.onTap,
  }) : super(key: key);

  final double height, widthImg, radius;
  final Widget? mid, child;
  final Widget right;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: DarkTheme.primaryBlue600.withOpacity(0.6),
      highlightColor: DarkTheme.primaryBlue600.withOpacity(0.6),
      child: Column(
        children: [
          SizedBox(
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: widthImg,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radius),
                    child: child,
                  ),
                ),
                Expanded(flex: 3, child: SizedBox(height: height, child: mid)),
                Expanded(flex: 1, child: right),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BodyItemAsset extends StatelessWidget {
  const BodyItemAsset({
    Key? key,
    this.height = 0,
    this.widthImg = 0,
    this.assetName = '',
    this.radius = 10,
    this.mid,
    required this.right,
    this.child,
    this.onTap,
  }) : super(key: key);

  final double height, widthImg, radius;
  final String assetName;
  final Widget? mid, child;
  final Widget right;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: widthImg,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(assetName),
                    ),
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  child: child,
                ),
                SizedBox(
                  height: height,
                  child: mid,
                ),
                Expanded(child: right),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
