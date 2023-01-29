import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_app_bloc/assets/assets_path.dart';
import 'package:firebase_app_bloc/blocs/blocs.dart';
import 'package:firebase_app_bloc/modules/details/pages/tab_course_page.dart';
import 'package:firebase_app_bloc/modules/details/pages/tab_overview_page.dart';
import 'package:firebase_app_bloc/widgets/stateless/button_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';

import '../../../models/models.dart';
import '../../../repositories/repository.dart';
import '../../../themes/themes.dart';
import '../../../utils/utils.dart';
import '../../../widgets/stateless/stateless.dart';
import '../blocs/blocs.dart';

class DetailCoursePage extends StatelessWidget {
  const DetailCoursePage({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LikeTeacherCubit>(
          create: (context) => LikeTeacherCubit(
            userBase: context.read<UserBase>(),
            profileCubit: BlocProvider.of<ProfileCubit>(context),
          ),
        ),
        BlocProvider<LikeCourseCubit>(
          create: (context) => LikeCourseCubit(
            userBase: context.read<UserBase>(),
            profileCubit: BlocProvider.of<ProfileCubit>(context),
          ),
        ),
        BlocProvider<DetailBloc>(
          create: (context) => DetailBloc(
            appBase: context.read<AppBase>(),
            userBase: context.read<UserBase>(),
            likeTeacherCubit: BlocProvider.of<LikeTeacherCubit>(context),
          ),
          lazy: false,
        ),
        BlocProvider<BuyCourseCubit>(
          create: (context) => BuyCourseCubit(
            appBase: context.read<AppBase>(),
            profileCubit: BlocProvider.of<ProfileCubit>(context),
          ),
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
  static final debounce = Debounce(milliseconds: 1000);

  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Overview'),
    const Tab(text: 'Course'),
  ];

  @override
  void initState() {
    context
        .read<DetailBloc>()
        .add(GetTeacherByIDEvent(id: widget.product.teacherID));
    context
        .read<BuyCourseCubit>()
        .getOwnCourseFromUser(idProduct: widget.product.id);
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
                          child: Hero(
                            tag: widget.product.image,
                            transitionOnUserGestures: true,
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
                  student: widget.product.studentTotal.toString(),
                ),
                BlocBuilder<BuyCourseCubit, BuyCourseState>(
                  builder: (context, state) {
                    return state.status == BuyCourseStatus.bought
                        ? TabCoursePage(product: widget.product)
                        : const Center(
                            child: Text('Please Buy course to watch',
                                style: TxtStyle.headline2));
                  },
                ),
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
        BlocBuilder<BuyCourseCubit, BuyCourseState>(
          builder: (context, state) {
            return state.status == BuyCourseStatus.bought
                ? CircleButton(assetPath: AssetPath.iconPlay, onTap: () {})
                : buildButtonBuyCourse(context);
          },
        )
      ],
    );
  }

  Widget buildButtonBuyCourse(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: DarkTheme.primaryBlue600,
        border: Border.all(color: DarkTheme.primaryBlue600),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextButton.icon(
        icon: const Icon(Icons.diamond_outlined, color: DarkTheme.white),
        onPressed: () {
          context.read<BuyCourseCubit>().buyCourse(product: widget.product);
        },
        label: Row(
          children: [
            Text(
              '${widget.product.discount.toString()} ',
              style: TxtStyle.buttonLarge.copyWith(
                color: DarkTheme.white,
                decoration: TextDecoration.underline,
              ),
            ),
            Text(
              widget.product.price.toString(),
              textScaleFactor: 0.75,
              style: TxtStyle.buttonSmall.copyWith(
                fontSize: 14,
                color: DarkTheme.white,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool? getLikeCourse() {
    final listMyFavoriteCourse =
        context.read<ProfileCubit>().state.user.favoritesCourse;
    for (var i = 0; i < listMyFavoriteCourse.length; i++) {
      if (listMyFavoriteCourse[i] == widget.product.id) {
        return true;
      }
    }
    return false;
  }

  Widget buildWidgetInImageTop(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const ButtonBack(),
        LikeButton(
          animationDuration: const Duration(milliseconds: 1000),
          isLiked: getLikeCourse(),
          likeBuilder: (bool isLiked) {
            return Icon(
              size: 35,
              Icons.favorite_sharp,
              color: isLiked ? Colors.pink : DarkTheme.greyScale500,
            );
          },
          onTap: (isLiked) async {
            debounce.run(() {
              context.read<LikeCourseCubit>().changeLikeCourseStatusByUser(
                    userID: context.read<ProfileCubit>().state.user.id,
                    productID: widget.product.id,
                    isLike: !isLiked,
                  );
            });

            return !isLiked;
          },
        )
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
