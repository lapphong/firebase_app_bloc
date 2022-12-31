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
  }) : super(key: key);

  final String? titleCourse, teacherID, imgUrl;

  @override
  State<ItemsFilteredCategory> createState() => _ItemsFilteredCategoryState();
}

class _ItemsFilteredCategoryState extends State<ItemsFilteredCategory> {
  // late final Teacher teacher;
  // @override
  // void initState() {
  //   super.initState();
  //   teacher = context
  //       .read<MentorBloc>()
  //       .state
  //       .list
  //       .where((Teacher teacher) => widget.teacherID == teacher.id)
  //       .first;
  // }

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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.titleCourse!, style: TxtStyle.headline4),
              Text(
                widget.teacherID!,
                style:
                    TxtStyle.headline6.copyWith(color: DarkTheme.greyScale500),
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
