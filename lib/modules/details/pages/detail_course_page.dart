import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_app_bloc/assets/assets_path.dart';
import 'package:firebase_app_bloc/modules/details/widgets/course_teacher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/models.dart';
import '../../../themes/themes.dart';
import '../../../widgets/stateless/stateless.dart';
import '../blocs/blocs.dart';

class DeTailCoursePage extends StatefulWidget {
  const DeTailCoursePage({super.key, required this.product});
  final Product product;

  @override
  State<DeTailCoursePage> createState() => _DeTailCoursePageState();
}

class _DeTailCoursePageState extends State<DeTailCoursePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Overview'),
    const Tab(text: 'Course'),
  ];

  @override
  void initState() {
    context
        .read<DetailBloc>()
        .add(GetTeacherByIDEvent(id: widget.product.teacherID));
    _tabController = TabController(length: myTabs.length, vsync: this);
    _tabController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: myTabs.length,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    pinned: true,
                    expandedHeight: 360.0,
                    collapsedHeight: 140,
                    forceElevated: innerBoxIsScrolled,
                    flexibleSpace: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: CachedNetworkImage(
                            imageUrl: widget.product.image,
                            width: MediaQuery.of(context).size.width,
                            height: 360,
                            fit: BoxFit.cover,
                            placeholder: (_, __) => const Image(
                                image: AssetImage(AssetPath.imgLoading)),
                            errorWidget: (context, url, error) => const Image(
                                image: AssetImage(AssetPath.imgError)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () => Navigator.pop(context),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          width: 1,
                                          color: DarkTheme.greyScale100,
                                        ),
                                      ),
                                      child: Image.asset(
                                        AssetPath.iconArrowLeft,
                                        color: DarkTheme.white,
                                      ),
                                    ),
                                  ),
                                  Image.asset(
                                    AssetPath.iconMyFavorite,
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                    color: DarkTheme.greyScale400,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          context
                                              .watch<DetailBloc>()
                                              .state
                                              .teacher
                                              .name,
                                          style: TxtStyle.headline3),
                                      Text(widget.product.field,
                                          style: TxtStyle.headline4),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 52,
                                    height: 52,
                                    child: CircleButton(
                                      widthIcon: 24,
                                      heightIcon: 24,
                                      bgColor: DarkTheme.primaryBlue600,
                                      assetPath: AssetPath.iconPlay,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverPersistentHeaderDelegateImpl(
                    tabBar: TabBar(
                      tabs: myTabs,
                      controller: _tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelStyle: TxtStyle.headline4.copyWith(
                        color: DarkTheme.primaryBlue600,
                      ),
                      unselectedLabelColor: DarkTheme.greyScale500,
                      unselectedLabelStyle: TxtStyle.headline4.copyWith(
                        color: DarkTheme.greyScale500,
                      ),
                      labelColor: DarkTheme.primaryBlue600,
                      indicatorColor: DarkTheme.primaryBlue600,
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                buildTabLeft(),
                buildTabRight(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTabLeft() {
    return Builder(
      builder: (BuildContext context) {
        return CustomScrollView(
          key: PageStorageKey(myTabs[0]),
          slivers: <Widget>[
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    Text(widget.product.title, style: TxtStyle.headline1),
                    const SizedBox(height: 24),
                    BlocConsumer<DetailBloc, DetailState>(
                      listener: (context, state) {
                        if (state.status == DetailStatus.error) {
                          showAlertDialog(
                            context,
                            title: 'ERROR',
                            content: state.error.toString(),
                            defaultActionText: 'OK',
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state.status == DetailStatus.initial) {
                          return Container();
                        } else if (state.status == DetailStatus.loading) {
                          return const Center(
                              child: CupertinoActivityIndicator(
                            color: DarkTheme.white,
                          ));
                        } else if (state.status == DetailStatus.error) {
                          return const ProfileStatusError();
                        }
                        return CourseTeacher(
                          onTap: () {},
                          assetName: state.teacher.imgUrl,
                          fullName: state.teacher.name,
                          specialize: state.teacher.specialize,
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    buildTitle('Description'),
                    const SizedBox(height: 14),
                    Text(
                      widget.product.description,
                      style: TxtStyle.headline4.copyWith(
                        color: DarkTheme.greyScale500,
                      ),
                    ),
                    const SizedBox(height: 24),
                    buildTitle('What you\'ll get'),
                    const SizedBox(height: 14),
                    buildItemSubjectGet(
                      title: '${widget.product.duration} Hours of Demand Video',
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

  Widget buildTabRight() {
    return Builder(
      builder: (BuildContext context) {
        return CustomScrollView(
          key: PageStorageKey(myTabs[1]),
          slivers: <Widget>[
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        // buildListCourse(
                        //     courseItem, context),
                      ],
                    ),
                    const SizedBox(height: 100),
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
      itemCount: widget.product.requirements.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Text(
            '• ${widget.product.requirements[index]}',
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

  Widget buildTitle(String text) {
    return Text(text, style: TxtStyle.headline3);
  }
}

class SliverPersistentHeaderDelegateImpl
    extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  const SliverPersistentHeaderDelegateImpl({required this.tabBar});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Material(color: DarkTheme.greyScale900, child: tabBar);
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
