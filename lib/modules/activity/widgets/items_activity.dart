import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../assets/assets_path.dart';
import '../../../themes/themes.dart';
import '../../../widgets/stateless/stateless.dart';

class ItemsActivity extends StatelessWidget {
  const ItemsActivity({
    super.key,
    required this.imgUrl,
    required this.title,
    required this.onTap,
    required this.duration,
    required this.timeLearned,
    this.percent = 0,
  });

  final String? imgUrl, title, duration; //,percentText;
  final double percent, timeLearned;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BodyItemNetwork(
          onTap: onTap,
          height: 73,
          widthImg: 73,
          mid: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title!, style: TxtStyle.headline4, maxLines: 2),
                Text(
                  'Time learned: ${(timeLearned * 100).toInt()}/${duration}h',
                  style: TxtStyle.headline5
                      .copyWith(color: DarkTheme.greyScale500),
                ),
                LinearPercentIndicator(
                  barRadius: const Radius.circular(10),
                  lineHeight: 5,
                  percent: percent,
                  width: 190,
                  progressColor: DarkTheme.primaryBlue600,
                  backgroundColor: DarkTheme.greyScale800,
                  padding: const EdgeInsets.only(right: 10),
                  trailing: Text(
                    "${(percent * 100).toInt()}%",
                    style: TxtStyle.headline6
                        .copyWith(color: DarkTheme.greyScale500),
                  ),
                ),
              ],
            ),
          ),
          right: const Text(''),
          child: CachedNetworkImage(
            height: 80,
            imageUrl: imgUrl!,
            fit: BoxFit.fill,
            placeholder: (_, __) =>
                const Image(image: AssetImage(AssetPath.imgLoading)),
            errorWidget: (context, url, error) =>
                const Image(image: AssetImage(AssetPath.imgError)),
          ),
        ),
        const SizedBox(height: 20),
        const Divider(),
      ],
    );
  }
}
