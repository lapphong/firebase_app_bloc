import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_app_bloc/assets/assets_path.dart';
import 'package:firebase_app_bloc/modules/details/pages/tab_course_page.dart';
import 'package:firebase_app_bloc/modules/details/pages/tab_overview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/models.dart';
import '../../../repositories/repository.dart';
import '../../../themes/themes.dart';
import '../../../widgets/stateless/stateless.dart';
import '../blocs/blocs.dart';

class DetailCoursePage extends StatelessWidget {
  const DetailCoursePage({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LikeCubit>(
          create: (context) => LikeCubit(userBase: context.read<UserBase>()),
        ),
        BlocProvider<DetailBloc>(
          create: (context) => DetailBloc(
            appBase: context.read<AppBase>(),
            likeCubit: BlocProvider.of<LikeCubit>(context),
          ),
          lazy: false,
        ),
      ],
      child: DetailCourseView(product: product),
    );
  }
}

class DetailCourseView extends StatefulWidget {
  const DetailCourseView({super.key, required this.product});
  final Product product;

  @override
  State<DetailCourseView> createState() => _DetailCourseViewState();
}

class _DetailCourseViewState extends State<DetailCourseView> {
  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Overview'),
    const Tab(text: 'Course'),
  ];

  @override
  void initState() {
    context
        .read<DetailBloc>()
        .add(GetTeacherByIDEvent(id: widget.product.teacherID));
    super.initState();
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
                    expandedHeight: 340.0,
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
                            height: 340,
                            fit: BoxFit.fill,
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
                              buildWidgetInImageTop(context),
                              buildWidgetInImageBottom(context),
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
              children: [
                TabOverviewPage(
                  title: widget.product.title,
                  description: widget.product.description,
                  duration: widget.product.duration,
                  requirements: widget.product.requirements,
                ),
                TabCoursePage(listVideoID: widget.product.listVideoID),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildWidgetInImageBottom(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(''),
        SizedBox(
          width: 52,
          height: 52,
          child: CircleButton(
            onTap: () {},
            widthIcon: 24,
            heightIcon: 24,
            bgColor: DarkTheme.primaryBlue600,
            assetPath: AssetPath.iconPlay,
          ),
        ),
      ],
    );
  }

  Widget buildWidgetInImageTop(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2, color: DarkTheme.white),
            ),
            child: Image.asset(AssetPath.iconArrowLeft, color: DarkTheme.white),
          ),
        ),
        Image.asset(
          AssetPath.iconMyFavorite,
          width: 30,
          height: 30,
          fit: BoxFit.cover,
          color: DarkTheme.greyScale500,
        ),
      ],
    );
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
