import 'package:firebase_app_bloc/assets/assets_path.dart';
import 'package:firebase_app_bloc/blocs/blocs.dart';
import 'package:firebase_app_bloc/generated/l10n.dart';
import 'package:firebase_app_bloc/repositories/test_repo.dart';
import 'package:firebase_app_bloc/routes/route_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/repository.dart';
import '../../../themes/themes.dart';
import '../../../utils/utils.dart';
import '../../../widgets/stateless/stateless.dart';
import '../blocs/blocs.dart';
import '../widgets/home_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ClassBloc>(
          create: (context) => ClassBloc(appBase: context.read<AppBase>()),
        ),
        BlocProvider<MentorBloc>(
          create: (context) => MentorBloc(appBase: context.read<AppBase>()),
        ),
      ],
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _scrollListBestMentorController = ScrollController();
  final _scrollListProductController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ClassBloc>().add(GetListProductEvent());
    context.read<MentorBloc>().add(GetListBestMentorEvent());
    _scrollListBestMentorController.addListener(_onScrollListBestMentor);
    _scrollListProductController.addListener(_onScrollListProduct);
  }

  @override
  void dispose() {
    _scrollListBestMentorController
      ..removeListener(_onScrollListBestMentor)
      ..dispose();

    _scrollListProductController
      ..removeListener(_onScrollListProduct)
      ..dispose();
    super.dispose();
  }

  void _onScrollListBestMentor() {
    if (_isBottom && !context.read<MentorBloc>().state.hasReachedMax) {
      context.read<MentorBloc>().add(LoadMoreBestMentorEvent());
    }
  }

  void _onScrollListProduct() {
    if (!_scrollListProductController.hasClients) return;

    final thresholdReached =
        _scrollListProductController.position.extentAfter <=
            _scrollListBestMentorController.position.maxScrollExtent - 120;

    if (thresholdReached && !context.read<ClassBloc>().state.hasReachedMax) {
      context.read<ClassBloc>().add(LoadMoreProductEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollListBestMentorController.hasClients) return false;
    final maxScroll = _scrollListBestMentorController.position.maxScrollExtent;
    final currentScroll = _scrollListBestMentorController.offset;
    return currentScroll >= (maxScroll * 0.5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollListProductController,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    buildDeTailAccount(),
                    buildTextFieldSearch(context),
                    const SizedBox(height: 20),
                    const Discount(),
                    buildTitleContentHome(
                        S.of(context).bestMentors, S.current.seeAll),
                    const SizedBox(height: 14),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: buildListBestMentors(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    buildTitleContentHome(
                        S.of(context).classPreview, S.current.seeAll),
                    const SizedBox(height: 14),
                    buildGridViewPreview(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDeTailAccount() {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.profileStatus == ProfileStatus.error) {
          showAlertDialog(
            context,
            title: 'ERROR',
            content: state.error.toString(),
            defaultActionText: 'OK',
          );
        }
      },
      builder: (context, state) {
        if (state.profileStatus == ProfileStatus.initial) {
          return Container();
        } else if (state.profileStatus == ProfileStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.profileStatus == ProfileStatus.error) {
          return const StatusError();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AvatarHome(url: state.user.profileImage),
                const BellButton(),
              ],
            ),
            const SizedBox(height: 10),
            Text(S.current.hi(state.user.name), style: TxtStyle.headline2),
            Text(
              S.of(context).welcomeBackToUdemy,
              style: TxtStyle.headline5.copyWith(color: DarkTheme.greyScale500),
            ),
          ],
        );
      },
    );
  }

  Widget buildListBestMentors() {
    return SizedBox(
      height: 175,
      child: BlocConsumer<MentorBloc, MentorState>(
        listener: (context, state) {
          if (state.hasReachedMax) {
            snackBar(context);
          }
        },
        builder: (context, state) {
          if (state.status == MentorStatus.initial) {
            return Container();
          } else if (state.status == MentorStatus.loading) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (state.status == MentorStatus.error) {
            return const StatusError();
          }
          return ListView.builder(
            controller: _scrollListBestMentorController,
            itemCount: state.hasReachedMax == true
                ? state.list.length
                : state.list.length + 1,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return index >= state.list.length
                  ? const SizedBox(
                      height: 50,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: BestMentor(
                        imgUrl: state.list[index].imgUrl,
                        name: state.list[index].name,
                        voted: state.list[index].voted.toString(),
                        onTap: () {},
                      ),
                    );
            },
          );
        },
      ),
    );
  }

  Widget buildGridViewPreview() {
    return BlocConsumer<ClassBloc, ClassState>(
      listener: (context, state) {
        if (state.hasReachedMax) {
          snackBar(context);
        }
      },
      builder: (context, state) {
        if (state.status == ClassStatus.initial) {
          return Container();
        } else if (state.status == ClassStatus.loading) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (state.status == ClassStatus.error) {
          return const StatusError();
        }
        return CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 5 / 6.299,
                crossAxisSpacing: 23,
                mainAxisSpacing: 23,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ClassPreview(
                    field: state.list[index].field,
                    assetName: state.list[index].image,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        RouteName.detailCoursePage,
                        arguments: state.list[index],
                      );
                    },
                  );
                },
                childCount: state.list.length,
              ),
            ),
            SliverToBoxAdapter(
              child: !state.hasReachedMax
                  ? Container(
                      padding: const EdgeInsets.only(top: 16),
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    )
                  : const SizedBox(),
            ),
          ],
        );
      },
    );
  }

  Widget buildTextFieldSearch(BuildContext context) {
    return TextFieldSearch(
      hintText: S.of(context).searchYourFocus,
      key: const Key('homePage_searchInput_textField'),
      onChange: (textSearch) => {},
      //debounce.run(() => context.read<SignInCubit>().emailChanged(email)),
      //errorText: state.email.invalid ? 'Email is valid' : null,
    );
  }

  void snackBar(BuildContext context) {
    return showSnackBar(
      context,
      'Max limit has been reached',
      Image.asset(AssetPath.iconChecked, color: DarkTheme.green),
    );
  }

  Widget buildTitleContentHome(String textTitle, String textButton) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(textTitle, style: TxtStyle.headline3),
        TextButton(
          onPressed: () async {
            //await TestRepo().getCategory();
            // await TestRepo()
            //     .deleteFavoriteByUser('qoEIEgYoeTWrHvQ0sybDgZUcoXd2', '123');
            // final VideoCourse aaa =
            //     await TestRepo().getVideoCourseByID(id: 'VO5NnMa4O3oyX9sgKHk3');
            // print(aaa);

            // final aaa = await TestRepo()
            //     .getNextProductByLimit(limit: 2, nextAssessmentScore: 71);
            // print(aaa.first.assessmentScore);
            // print(aaa.last.assessmentScore);

            // final list = await TestRepo().getValueInDocumentID(
            //   path: ApiPath.product(),
            //   key: 'course_teacher_id',
            // );
            // for (var i = 0; i < list.length; i++) {
            //   print('⚡⚡ $i: ${list[i]}');
            // }

            // final list = await TestRepo().getAllProduct();
            // for (var i = 0; i < list.length; i++) {
            //   print('⚡⚡ List đầu tiên: ${list[i]}');
            // }

            // final teacher =
            //     await TestRepo().getTeacher(id: '2EkoAjhWrF5k3vJBges5');
            // print(teacher);
          },
          child: Text(
            textButton,
            style: TxtStyle.headline6.copyWith(color: DarkTheme.primaryBlue600),
          ),
        ),
      ],
    );
  }
}
