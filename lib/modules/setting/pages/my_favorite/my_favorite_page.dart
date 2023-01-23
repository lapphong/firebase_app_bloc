import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_app_bloc/modules/setting/widgets/setting_widgets.dart';
import 'package:firebase_app_bloc/themes/app_color.dart';
import 'package:firebase_app_bloc/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../assets/assets_path.dart';
import '../../../../blocs/blocs.dart';
import '../../../../repositories/repository.dart';
import '../../../../routes/route_name.dart';
import '../../../../widgets/stateless/stateless.dart';
import '../../blocs/blocs.dart';

class MyFavoritePage extends StatelessWidget {
  const MyFavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyFavoriteCubit(userBase: context.read<UserBase>()),
      child: const MyFavoriteView(),
    );
  }
}

class MyFavoriteView extends StatefulWidget {
  const MyFavoriteView({super.key});

  @override
  State<MyFavoriteView> createState() => _MyFavoriteViewState();
}

class _MyFavoriteViewState extends State<MyFavoriteView> {
  @override
  void initState() {
    super.initState();
    final listMyLearningCourse =
        context.read<ProfileCubit>().state.listMyLearning;
    context
        .read<MyFavoriteCubit>()
        .getListMyLearningCourse(listID: listMyLearningCourse);

    final listMyFavoriteCourse =
        context.read<ProfileCubit>().state.user.favoritesCourse;
    context
        .read<MyFavoriteCubit>()
        .getListMyFavoriteCourse(listID: listMyFavoriteCourse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 70),
            Container(
              padding: const EdgeInsets.only(left: 24),
              child:
                  const Text('My Learning Course :', style: TxtStyle.headline3),
            ),
            const SizedBox(height: 24),
            buildCarouselSliderMyLearning(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const Text('My Favorite Course :', style: TxtStyle.headline3),
                  buildGridViewMyFavorite(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCarouselSliderMyLearning() {
    return BlocBuilder<MyFavoriteCubit, MyFavoriteState>(
      builder: (context, state) {
        if (state.myLearningStatus == MyLearningStatus.initial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.myLearningStatus == MyLearningStatus.error) {
          return const StatusError();
        }
        return CarouselSlider.builder(
          itemCount: state.listMyLearning.length,
          itemBuilder: (context, index, realIndex) {
            return state.listMyLearning.isNotEmpty
                ? SizedBox(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: state.listMyLearning[index].image,
                        fit: BoxFit.fill,
                        placeholder: (_, __) => const Image(
                            image: AssetImage(AssetPath.imgLoading)),
                        errorWidget: (context, url, error) =>
                            const Image(image: AssetImage(AssetPath.imgError)),
                      ),
                    ),
                  )
                : Container(
                    color: DarkTheme.primaryBlue600,
                    alignment: Alignment.center,
                    child: const Text('Nothing course'),
                  );
          },
          options: CarouselOptions(
            viewportFraction: .6,
            autoPlay: true,
            aspectRatio: 16 / 10,
            autoPlayInterval: const Duration(seconds: 2),
            enlargeCenterPage: true,
          ),
        );
      },
    );
  }

  Widget buildGridViewMyFavorite() {
    return BlocBuilder<MyFavoriteCubit, MyFavoriteState>(
      builder: (context, state) {
        if (state.myFavoriteStatus == MyFavoriteStatus.initial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.myFavoriteStatus == MyFavoriteStatus.error) {
          return const StatusError();
        }
        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 4 / 6.299,
            crossAxisSpacing: 23,
            mainAxisSpacing: 23,
          ),
          itemCount: state.listMyFavorite.length,
          itemBuilder: (context, index) {
            return MyFavoriteCourse(
              title: state.listMyFavorite[index].title,
              imgUrl: state.listMyFavorite[index].image,
              tagHeroImg: state.listMyFavorite[index].image,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteName.detailCoursePage,
                  arguments: state.listMyFavorite[index],
                );
              },
            );
          },
        );
      },
    );
  }
}
