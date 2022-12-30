import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../themes/themes.dart';
import '../../../widgets/stateless/stateless.dart';
import '../blocs/blocs.dart';
import '../widgets/item_video_course.dart';

class TabCoursePage extends StatefulWidget {
  const TabCoursePage({super.key, required this.listVideoID});
  final List<String> listVideoID;

  @override
  State<TabCoursePage> createState() => _TabCoursePageState();
}

class _TabCoursePageState extends State<TabCoursePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context
        .read<DetailBloc>()
        .add(GetListVideoByIDEvent(courseVideoId: widget.listVideoID));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Builder(
      builder: (BuildContext context) {
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
          return Container();
        } else if (state.statusCourse == CourseStatus.loading) {
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
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ItemsVideoCourse(
                onTap: () {},
                title: item.title,
                assetName: item.imgVideo,
                time: '10:09',
                part: 'Course Part ${index + 1}',
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
