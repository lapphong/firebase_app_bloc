import 'package:flutter/material.dart';

import '../../themes/app_color.dart';

class ClassicButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final double? radius;
  final double widthRadius;
  final Color colorRadius;
  final Widget? child;
  final VoidCallback? onTap;

  const ClassicButton({
    Key? key,
    this.width,
    this.height,
    this.color,
    this.radius,
    this.widthRadius = 0,
    this.colorRadius = DarkTheme.white,
    this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            width: widthRadius,
            color: colorRadius,
          ),
          borderRadius: BorderRadius.circular(radius!),
        ),
        child: child,
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final String? assetPath;
  final VoidCallback? onTap;
  final double? widthIcon, heightIcon;

  const CircleButton({
    Key? key,
    required this.assetPath,
    required this.onTap,
    this.widthIcon = 20,
    this.heightIcon = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      height: 52,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const CircleBorder()),
          backgroundColor: MaterialStateProperty.all(DarkTheme.primaryBlue600),
          overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
            if (states.contains(MaterialState.pressed)) {
              return DarkTheme.greyScale500;
            }
          }),
        ),
        child: Image.asset(
          assetPath!,
          width: widthIcon,
          height: heightIcon,
          color: DarkTheme.white,
        ),
      ),
    );
  }
}

class SquareButton extends StatelessWidget {
  final double? edge;
  final double? radius;
  final Color? bgColor;
  final Widget? child;
  final VoidCallback? onTap;

  const SquareButton({
    Key? key,
    this.edge,
    this.radius,
    this.bgColor,
    this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(radius!),
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: edge,
        width: edge,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(radius!),
        ),
        child: child,
      ),
    );
  }
}
