import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../assets/assets_path.dart';
import '../../../themes/themes.dart';

class BestMentor extends StatelessWidget {
  const BestMentor({
    Key? key,
    required this.imgUrl,
    required this.voted,
    required this.name,
    required this.tagHeroImg,
    required this.onTap,
  }) : super(key: key);

  final String? imgUrl, voted, name;
  final String tagHeroImg;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 130,
        decoration: const BoxDecoration(
          color: DarkTheme.greyScale800,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            SizedBox(
              width: 130,
              height: 128,
              child: Hero(
                tag: tagHeroImg,
                transitionOnUserGestures: true,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: imgUrl!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Image(image: AssetImage(AssetPath.imgLoading)),
                    errorWidget: (context, url, error) =>
                        const Image(image: AssetImage(AssetPath.imgError)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(name!, style: TxtStyle.headline4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.favorite_outline_sharp, color: Colors.pink),
                const SizedBox(width: 5),
                Text(
                  '${voted!} voted',
                  style: TxtStyle.headline4
                      .copyWith(color: DarkTheme.greyScale500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
