import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../assets/assets_path.dart';
import '../../../blocs/blocs.dart';
import '../../../themes/themes.dart';
import '../../../utils/utils.dart';
import '../../../widgets/stateless/stateless.dart';
import '../blocs/blocs.dart';
import '../widgets/course_teacher.dart';

class TabOverviewPage extends StatefulWidget {
  const TabOverviewPage({
    super.key,
    required this.title,
    required this.description,
    required this.duration,
    required this.requirements,
    required this.student,
  });

  final String title, description, duration, student;
  final List<String> requirements;

  @override
  State<TabOverviewPage> createState() => _TabOverviewPageState();
}

class _TabOverviewPageState extends State<TabOverviewPage>
    with AutomaticKeepAliveClientMixin {
  static final debounce = Debounce(milliseconds: 1000);

  bool? getLikedTeacher(String idTeacher) {
    final listFavoriteFromUser =
        context.read<ProfileCubit>().state.user.favoritesTeacher;
    for (var i = 0; i < listFavoriteFromUser.length; i++) {
      if (listFavoriteFromUser[i] == idTeacher) {
        return true;
      }
    }
    return false;
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
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    Text(widget.title, style: TxtStyle.headline1),
                    const SizedBox(height: 24),
                    BlocConsumer<DetailBloc, DetailState>(
                      listener: (context, state) {
                        if (state.statusOverview == OverviewStatus.error) {
                          showAlertDialog(
                            context,
                            title: 'ERROR',
                            content: state.error.toString(),
                            defaultActionText: 'OK',
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state.statusOverview == OverviewStatus.initial) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state.statusOverview ==
                            OverviewStatus.error) {
                          return const StatusError();
                        }
                        return CourseTeacher(
                          onTap: (isLiked) async {
                            debounce.run(() {
                              context
                                  .read<LikeTeacherCubit>()
                                  .changeLikeTeacherStatusByUser(
                                    teacherID: state.teacher.id,
                                    isLike: !isLiked,
                                  );
                            });

                            return !isLiked;
                          },
                          assetName: state.teacher.imgUrl,
                          fullName: state.teacher.name,
                          specialize: state.teacher.specialize,
                          voted: state.teacher.voted,
                          isLiked: getLikedTeacher(state.teacher.id),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    buildTitle('Description'),
                    const SizedBox(height: 14),
                    Text(
                      widget.description,
                      softWrap: false,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TxtStyle.headline4
                          .copyWith(color: DarkTheme.greyScale500),
                    ),
                    const SizedBox(height: 24),
                    buildTitle('Total student: ${widget.student}'),
                    const SizedBox(height: 24),
                    buildTitle('What you\'ll get'),
                    const SizedBox(height: 14),
                    buildItemSubjectGet(
                      title: '${widget.duration} Hours of Demand Video',
                      icon: AssetPath.iconTime,
                    ),
                    const SizedBox(height: 14),
                    buildItemSubjectGet(
                      title: 'Exclusive learning materials',
                      icon: AssetPath.iconFile,
                    ),
                    const SizedBox(height: 14),
                    buildItemSubjectGet(
                      title: 'Full lifetime access',
                      icon: AssetPath.iconInfinity,
                    ),
                    const SizedBox(height: 24),
                    buildTitle('Requirements'),
                    const SizedBox(height: 10),
                    buildListViewGet(),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildListViewGet() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.requirements.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Text(
            '• ${widget.requirements[index]}',
            style: TxtStyle.headline5,
          ),
        );
      },
    );
  }

  Widget buildItemSubjectGet({required String title, required String icon}) {
    return BodyItemAsset(
      assetName: AssetPath.imgBackgroundItems,
      height: 32,
      widthImg: 32,
      mid: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Center(child: Text(title, style: TxtStyle.headline4)),
      ),
      right: const Text(''),
      child: Center(child: Image.asset(icon, width: 15, height: 15)),
    );
  }

  Widget buildTitle(String text) => Text(text, style: TxtStyle.headline3);

  @override
  bool get wantKeepAlive => true;
}
