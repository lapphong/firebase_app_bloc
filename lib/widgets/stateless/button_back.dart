import 'package:flutter/material.dart';

import '../../assets/assets_path.dart';
import '../../themes/themes.dart';

class ButtonBack extends StatelessWidget {
  const ButtonBack({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: DarkTheme.greyScale500),
        ),
        child:
            Image.asset(AssetPath.iconArrowLeft, color: DarkTheme.greyScale500),
      ),
    );
  }
}
