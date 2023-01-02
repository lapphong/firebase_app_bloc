import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../assets/assets_path.dart';
import '../../../models/models.dart';
import '../../../themes/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../widgets/stateless/stateless.dart';
import '../../home/blocs/blocs.dart';

class ItemsFilteredCategory extends StatefulWidget {
  const ItemsFilteredCategory({
    Key? key,
    required this.titleCourse,
    required this.teacherID,
    required this.imgUrl,
    required this.assessmentScore,
    required this.reviewer,
    required this.duration,
  }) : super(key: key);

  final String? titleCourse, teacherID, imgUrl, assessmentScore, reviewer;
  final String? duration;

  @override
  State<ItemsFilteredCategory> createState() => _ItemsFilteredCategoryState();
}

class _ItemsFilteredCategoryState extends State<ItemsFilteredCategory> {
  late String assessmentScore =
      (double.parse(widget.assessmentScore!) / double.parse(widget.reviewer!))
          .toStringAsFixed(1);

  @override
  Widget build(BuildContext context) {
    return BodyItemNetwork(
      widthImg: 112,
      height: 90,
      mid: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: SizedBox(
          width: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.titleCourse!, style: TxtStyle.headline4),
              Text(
                'Course duration: ${widget.duration}h',
                style:
                    TxtStyle.headline5.copyWith(color: DarkTheme.greyScale500),
              ),
              Row(
                children: [
                  Text(
                    '$assessmentScore/5 ⭐  (',
                    style: TxtStyle.headline5
                        .copyWith(color: DarkTheme.greyScale500),
                  ),
                  Image.asset(AssetPath.iconUser, height: 12),
                  Text(' ${widget.reviewer})',
                      style: TxtStyle.headline5
                          .copyWith(color: DarkTheme.greyScale500)),
                ],
              ),
            ],
          ),
        ),
      ),
      //childImg: ,
      right: const Text(''),
      child: CachedNetworkImage(
        height: 90,
        imageUrl: widget.imgUrl!,
        fit: BoxFit.cover,
        placeholder: (_, __) =>
            const Image(image: AssetImage(AssetPath.imgLoading)),
        errorWidget: (context, url, error) =>
            const Image(image: AssetImage(AssetPath.imgError)),
      ),
    );
  }
}
