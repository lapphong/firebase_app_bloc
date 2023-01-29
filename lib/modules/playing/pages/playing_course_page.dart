import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:firebase_app_bloc/modules/playing/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../assets/assets_path.dart';
import '../../../blocs/blocs.dart';
import '../../../models/models.dart';
import '../../../repositories/repository.dart';
import '../../../routes/route_name.dart';
import '../../../themes/themes.dart';
import '../../../widgets/stateless/stateless.dart';
import '../../details/blocs/blocs.dart';
import '../widgets/playing_widgets.dart';

class PlayingCoursePage extends StatelessWidget {
  const PlayingCoursePage({
    super.key,
    required this.videoCourse,
    required this.product,
    required this.context,
  });
  final VideoCourse videoCourse;
  final Product product;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: BlocProvider.of<DetailBloc>(this.context),
        ),
        BlocProvider(
          create: (context) => PlayingCubit(
            userBase: context.read<UserBase>(),
            detailBloc: BlocProvider.of<DetailBloc>(this.context),
          ),
        ),
      ],
      child: PlayingCourseView(
        videoCourse: videoCourse,
        product: product,
      ),
    );
  }
}

class PlayingCourseView extends StatefulWidget {
  const PlayingCourseView({
    super.key,
    required this.videoCourse,
    required this.product,
  });
  final VideoCourse videoCourse;
  final Product product;

  @override
  State<PlayingCourseView> createState() => _PlayingCourseViewState();
}

class _PlayingCourseViewState extends State<PlayingCourseView> {
  late final _itemScrollController = ItemScrollController();
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  getIndex() {
    final list = context.read<DetailBloc>().state.videoCourse;
    for (var i = 0; i < list.length; i++) {
      if (widget.videoCourse.id == list[i].id) {
        return i + 1;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeController();
    Future.delayed(
      const Duration(milliseconds: 200),
      () {
        if (_itemScrollController.isAttached) {
          _itemScrollController.scrollTo(
            index: getIndex(),
            duration: const Duration(seconds: 1),
          );
        }
      },
    );
  }

  Future<void> _initializeController() async {
    _videoPlayerController =
        VideoPlayerController.network(widget.videoCourse.video);

    await _videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 11,
      autoInitialize: true,
      allowedScreenSleep: false,
      errorBuilder: (context, errorMessage) {
        return Center(child: Text(errorMessage, style: TxtStyle.headline2));
      },
    );
    if (_videoPlayerController.value.isInitialized) {
      // ignore: use_build_context_synchronously
      context.read<PlayingCubit>().initPlaying();
    }
    _chewieController.videoPlayerController
        .addListener(_listenerEventVideoPlayer);
  }

  void _listenerEventVideoPlayer() {
    bool isPlaying = _chewieController.videoPlayerController.value.isPlaying;
    int durationVideo =
        _chewieController.videoPlayerController.value.duration.inMilliseconds;
    int durationTimeLearned =
        _chewieController.videoPlayerController.value.position.inMilliseconds;
    String userID = context.read<ProfileCubit>().state.user.id;

    if (!isPlaying || durationVideo == durationTimeLearned) {
      context.read<PlayingCubit>().updateVideoProgress(
            userID: userID,
            product: widget.product,
            videoID: widget.videoCourse.id,
            durationVideo: durationVideo,
            durationTimeLearned: durationTimeLearned,
          );
    }
  }

  @override
  void dispose() {
    _chewieController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  Widget _playView() {
    return BlocConsumer<PlayingCubit, PlayingState>(
      listener: (context, state) {
        if (state.playingVideoStatus == PlayingVideoStatus.learned) {
          context.read<DetailBloc>().add(UpdateVideoProgressEvent(
                videoProgress: context.read<PlayingCubit>().state.videoProgress,
                userID: context.read<ProfileCubit>().state.user.id,
                productID: widget.product.id,
              ));
        }
      },
      builder: (context, state) {
        return state.status == PlayingStatus.initial
            ? buildImageVideoCourse()
            : Hero(
                tag: widget.videoCourse.imgVideo,
                child: SizedBox(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: Chewie(controller: _chewieController),
                ),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _playView(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  buildCoursePartVideo(),
                  const SizedBox(height: 16),
                  Text(widget.videoCourse.title, style: TxtStyle.headline2),
                  const SizedBox(height: 4),
                  buildInfoTeacher(context),
                  const SizedBox(height: 16),
                  Text(widget.videoCourse.description,
                      style: TxtStyle.headline5),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),
                  checkTheLastVideo()
                      ? const Text('THE END', style: TxtStyle.headline1)
                      : const Text('Next Video', style: TxtStyle.buttonLarge),
                ],
              ),
            ),
            checkTheLastVideo()
                ? const Text('')
                : SizedBox(height: 320, child: buildListNextVideoCourse()),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildImageVideoCourse() {
    return Hero(
      tag: widget.videoCourse.imgVideo,
      child: CachedNetworkImage(
        height: 240,
        width: 360,
        imageUrl: widget.videoCourse.imgVideo,
        fit: BoxFit.fill,
        placeholder: (_, __) =>
            const Image(image: AssetImage(AssetPath.imgLoading)),
        errorWidget: (context, url, error) =>
            const Image(image: AssetImage(AssetPath.imgError)),
      ),
    );
  }

  bool checkTheLastVideo() {
    return widget.videoCourse ==
            context.read<DetailBloc>().state.videoCourse.last
        ? true
        : false;
  }

  Widget buildInfoTeacher(BuildContext context) {
    return Row(
      children: [
        Text(
          context.read<DetailBloc>().state.teacher.name,
          style: TxtStyle.headline5.copyWith(color: DarkTheme.greyScale500),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
                color: DarkTheme.greyScale500, shape: BoxShape.circle),
          ),
        ),
        Text(
          context.read<DetailBloc>().state.teacher.specialize,
          style: TxtStyle.headline5.copyWith(color: DarkTheme.greyScale500),
        ),
      ],
    );
  }

  Widget buildCoursePartVideo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClassicButton(
          onTap: () {},
          width: 132,
          radius: 10,
          widthRadius: 0.5,
          colorRadius: DarkTheme.yellow.withOpacity(0.1),
          height: 32,
          color: DarkTheme.yellow.withOpacity(0.1),
          child: Center(
              child: Text(
            'Course Part ${widget.videoCourse.part}',
            style: TxtStyle.buttonSmall.copyWith(color: DarkTheme.yellow),
          )),
        ),
        Image.asset(AssetPath.iconMore,
            fit: BoxFit.cover, height: 24, width: 24),
      ],
    );
  }

  Widget buildListNextVideoCourse() {
    return BlocBuilder<DetailBloc, DetailState>(
      builder: (context, state) {
        return ScrollablePositionedList.separated(
          padding: const EdgeInsets.only(top: 10, left: 24, right: 24),
          itemCount: state.videoCourse.length,
          itemScrollController: _itemScrollController,
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Divider(),
            );
          },
          itemBuilder: (context, index) {
            return Stack(
              children: [
                index <= getIndex() - 1
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                          color: DarkTheme.greyScale300.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ItemsCourse(
                    key: ValueKey(state.videoCourse[index]),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        RouteName.playingCoursePage,
                        arguments: {
                          'videoCourse': state.videoCourse[index],
                          'context': context,
                        },
                      );
                    },
                    assetName: state.videoCourse[index].imgVideo,
                    time: '10:09',
                    part: 'Course Part ${state.videoCourse[index].part}',
                    title: state.videoCourse[index].title,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
