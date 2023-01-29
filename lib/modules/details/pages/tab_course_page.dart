import 'package:firebase_app_bloc/blocs/blocs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/models.dart';
import '../../../routes/route_name.dart';
import '../../../themes/themes.dart';
import '../../../utils/utils.dart';
import '../../../widgets/stateless/stateless.dart';
import '../blocs/blocs.dart';
import '../widgets/item_video_course.dart';

class TabCoursePage extends StatefulWidget {
  const TabCoursePage({super.key, required this.product});
  final Product product;

  @override
  State<TabCoursePage> createState() => _TabCoursePageState();
}

class _TabCoursePageState extends State<TabCoursePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.read<DetailBloc>().add(GetListVideoByIDEvent(
        userID: context.read<ProfileCubit>().state.user.id,
        product: widget.product));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Builder(
      builder: (context) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: buildListVideoCourse(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildListVideoCourse() {
    return BlocBuilder<DetailBloc, DetailState>(
      builder: (context, state) {
        if (state.statusCourse == CourseStatus.initial) {
          return const Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: CupertinoActivityIndicator(color: DarkTheme.white),
          );
        } else if (state.statusCourse == CourseStatus.error) {
          return const StatusError();
        }
        return ListView.builder(
          addAutomaticKeepAlives: true,
          shrinkWrap: true,
          itemCount: state.videoCourse.length,
          itemBuilder: (context, index) {
            final item = state.videoCourse[index];
            final itemSeen = state.videoProgress[index];
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ItemsVideoCourse(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    RouteName.playingCoursePage,
                    arguments: {
                      'videoCourse': state.videoCourse[index],
                      'context': context,
                      'product': widget.product,
                    },
                  );
                },
                title: item.title,
                imgUrl: item.imgVideo,
                time: '10:09',
                part: 'Course Part ${item.part}',
                seen: itemSeen.progress == 100 ? true : false,
              ),
            );
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
