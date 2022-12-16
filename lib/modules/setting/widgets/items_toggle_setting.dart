import 'package:flutter/material.dart';

import '../../../assets/assets_path.dart';
import '../../../themes/themes.dart';
import '../../../widgets/stateless/stateless.dart';

class ItemsToggleSetting extends StatelessWidget {
  const ItemsToggleSetting({
    Key? key,
    this.title,
    this.assetName,
    this.onChanged,
    this.onValue,
    this.onTap,
  }) : super(key: key);

  final String? title, assetName;
  final Function(bool)? onChanged;
  final Function()? onTap;
  final bool? onValue;

  @override
  Widget build(BuildContext context) {
    return BodyItemAsset(
      onTap: onTap,
      assetName: AssetPath.imgBackgroundItems,
      height: 32,
      widthImg: 32,
      mid: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Center(child: Text(title!, style: TxtStyle.headline4)),
      ),
      right: Padding(
        padding: const EdgeInsets.only(left: 145.0),
        child: ToggleSwitchButton(value: onValue!, onChanged: onChanged),
      ),
      child: Center(
        child: Image(image: AssetImage(assetName!), width: 16, height: 16),
      ),
    );
  }
}
