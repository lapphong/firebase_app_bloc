import 'package:flutter/material.dart';

import '../../../assets/assets_path.dart';
import '../../../themes/themes.dart';
import '../../../widgets/stateless/common_button.dart';

class ActivityEmpty extends StatelessWidget {
  const ActivityEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        const SquareButton(
          edge: 56,
          radius: 9.69,
          bgColor: DarkTheme.greyScale800,
          child: Image(
            width: 24,
            height: 24,
            color: DarkTheme.greyScale400,
            image: AssetImage(AssetPath.iconSearch),
          ),
        ),
        const SizedBox(height: 24),
        const Text('Empty Course', style: TxtStyle.headline3),
        Text(
          'Search your course again ',
          style: TxtStyle.headline5.copyWith(color: DarkTheme.greyScale500),
        ),
        const SizedBox(height: 32),
        const ClassicButton(
          color: DarkTheme.primaryBlue600,
          radius: 12,
          widthRadius: 0,
          colorRadius: DarkTheme.primaryBlue600,
          width: 140,
          height: 52,
          child: Text('Explore', style: TxtStyle.buttonMedium),
        ),
      ],
    );
  }
}
