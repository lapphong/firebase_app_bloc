import 'package:firebase_app_bloc/modules/setting/widgets/setting_widgets.dart';
import 'package:firebase_app_bloc/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 204),
              const SizedBox(height: 24),
              const Text('My Favorite Course :', style: TxtStyle.headline3),
              BlocBuilder<MyFavoriteCubit, MyFavoriteState>(
                builder: (context, state) {
                  if (state.status == MyFavoriteStatus.init) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.status == MyFavoriteStatus.error) {
                    return const StatusError();
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
