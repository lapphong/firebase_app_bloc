import 'package:flutter/material.dart';

import '../../../assets/assets_path.dart';
import '../../../themes/themes.dart';
import '../../../widgets/stateless/stateless.dart';

class TitleSetting extends StatelessWidget {
  const TitleSetting({
    Key? key,
    this.title = '',
  }) : super(key: key);
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Row(
        children: [
          SquareButton(
            onTap: () {
              Navigator.pop(context);
            },
            edge: 40,
            bgColor: DarkTheme.greyScale800,
            radius: 10,
            child: const Image(
              color: DarkTheme.greyScale600,
              image: AssetImage(
                AssetPath.iconArrowLeft,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            title!,
            style: TxtStyle.headline3,
          ),
        ],
      ),
    );
  }
}
