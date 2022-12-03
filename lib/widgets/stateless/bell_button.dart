import 'package:firebase_app_bloc/widgets/stateless/common_button.dart';
import 'package:flutter/material.dart';

import '../../assets/assets_path.dart';
import '../../themes/themes.dart';

class BellButton extends StatelessWidget {
  const BellButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const SquareButton(
      bgColor: DarkTheme.greyScale800,
      edge: 40,
      radius: 10,
      child: ImageIcon(
        size: 13,
        color: DarkTheme.white,
        AssetImage(AssetPath.iconBell),
      ),
    );
  }
}
