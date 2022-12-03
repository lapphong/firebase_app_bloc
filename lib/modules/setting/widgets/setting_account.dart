import 'package:flutter/material.dart';

import '../../../assets/assets_path.dart';
import '../../../themes/themes.dart';
import '../../../widgets/stateless/stateless.dart';

class SettingAccount extends StatelessWidget {
  const SettingAccount({
    Key? key,
    this.fullName = '',
    this.userName = '',
    this.assetName = '',
    required this.onTap,
  }) : super(key: key);

  final String? fullName, userName;
  final String assetName;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return BodyItemAsset(
      onTap: onTap,
      height: 64,
      widthImg: 64,
      assetName: assetName,
      mid: Padding(
        padding: const EdgeInsets.only(left: 14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fullName!,
              style: TxtStyle.headline3,
            ),
            Text(
              userName!,
              style: TxtStyle.headline5.copyWith(color: DarkTheme.greyScale500),
            ),
          ],
        ),
      ),
      right: const Image(
        alignment: Alignment.centerRight,
        image: AssetImage(
          AssetPath.iconArrowRight,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 4.0, bottom: 4),
          child: SizedBox(
            width: 16,
            height: 16,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: DarkTheme.white,
              ),
              alignment: Alignment.center,
              child: const Image(
                image: AssetImage(AssetPath.iconCrown),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
