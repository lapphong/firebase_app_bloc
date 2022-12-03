import 'package:flutter/material.dart';

import '../../assets/assets_path.dart';
import '../../themes/app_color.dart';
import '../../themes/text_style.dart';
import 'common_avatar.dart';

class Discount extends StatelessWidget {
  const Discount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          //width: 327,
          height: 104,
          decoration: BoxDecoration(
            image:
                const DecorationImage(image: AssetImage(AssetPath.imgVector)),
            color: DarkTheme.colorBox,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 30.0, right: 12),
                child: CustomAvatar(
                  height: 46,
                  width: 46,
                  assetName: AssetPath.iconBox,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 23.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Get 20% Discount',
                      style: TxtStyle.headline3,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Sign up or log in to your premium\naccount to get unlimited access.',
                      style: TxtStyle.headline6
                          .copyWith(color: DarkTheme.greyScale500),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 270.0, right: 20),
          child: CustomAvatar(
            width: 22,
            height: 26,
            assetName: AssetPath.iconRectangle,
          ),
        ),
      ],
    );
  }
}
