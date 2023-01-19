import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../assets/assets_path.dart';
import '../../../models/models.dart';
import '../../../themes/themes.dart';
import '../../../widgets/stateless/stateless.dart';
import '../../details/blocs/blocs.dart';
import '../widgets/playing_widgets.dart';

class PlayingCoursePage extends StatelessWidget {
  const PlayingCoursePage({
    super.key,
    required this.video,
    required this.context,
  });
  final VideoCourse video;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: BlocProvider.of<DetailBloc>(this.context),
        ),
      ],
      child: PlayingCourseView(video: video),
    );
  }
}

class PlayingCourseView extends StatefulWidget {
  const PlayingCourseView({super.key, required this.video});
  final VideoCourse video;

  @override
  State<PlayingCourseView> createState() => _PlayingCourseViewState();
}

class _PlayingCourseViewState extends State<PlayingCourseView> {
  late final _itemScrollController = ItemScrollController();

  getIndex() {
    final list = context.read<DetailBloc>().state.videoCourse;
    for (var i = 0; i < list.length; i++) {
      if (widget.video.id == list[i].id) {
        return i + 1;
      }
    }
  }

  @override
  void initState() {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildImageVideoCourse(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  buildCoursePartVideo(),
                  const SizedBox(height: 16),
                  Text(widget.video.title, style: TxtStyle.headline2),
                  const SizedBox(height: 4),
                  buildInfoTeacher(context),
                  const SizedBox(height: 16),
                  Text(widget.video.description, style: TxtStyle.headline5),
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
    return Stack(
      children: [
        Hero(
          tag: widget.video.imgVideo,
          child: CachedNetworkImage(
            height: 240,
            width: 360,
            imageUrl: widget.video.imgVideo,
            fit: BoxFit.fill,
            placeholder: (_, __) =>
                const Image(image: AssetImage(AssetPath.imgLoading)),
            errorWidget: (context, url, error) =>
                const Image(image: AssetImage(AssetPath.imgError)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 98.0),
          child: Center(
            child: SizedBox(
              width: 48,
              height: 48,
              child: CircleButton(
                widthIcon: 24,
                heightIcon: 24,
                assetPath: AssetPath.iconPlay,
                onTap: () {
                  // setState(() {
                  //   if (_playArea == false) {
                  //     _playArea = true;
                  //     _chewieController.play();
                  //   }
                  // });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool checkTheLastVideo() {
    return widget.video == context.read<DetailBloc>().state.videoCourse.last
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
          onTap: () {
            //scroll();
          },
          width: 132,
          radius: 10,
          widthRadius: 0.0,
          colorRadius: DarkTheme.yellow.withOpacity(0.1),
          height: 32,
          color: DarkTheme.yellow.withOpacity(0.1),
          child: Center(
              child: Text(
            'Course Part ${widget.video.part}',
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
                      // setState(() {
                      //   if (_playArea == false) {
                      //     _playArea = true;
                      //   }
                      // });
                      //_playView(context);
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


// class PlayingCoursePage extends StatefulWidget {
//   //final ModelCourse modelCourse;
//   final int index;

//   const PlayingCoursePage({
//     Key? key,
//     //required this.modelCourse,
//     this.index = 0,
//   }) : super(key: key);

//   @override
//   State<PlayingCoursePage> createState() => _PlayingCoursePageState();
// }

// class _PlayingCoursePageState extends State<PlayingCoursePage> {
//   bool _playArea = false;
//   late VideoPlayerController _videoPlayerController;
//   late ChewieController _chewieController;

//   @override
//   void initState() {
//     _initializePlayer();
//     super.initState();
//   }

//   Future<void> _initializePlayer() async {
//     if (mounted) {
//       _videoPlayerController = VideoPlayerController.asset(AssetPath.video);

//       await _videoPlayerController.initialize();
//       _createChewieController();
//     }
//   }

//   _createChewieController() {
//     _chewieController = ChewieController(
//       videoPlayerController: _videoPlayerController,
//       aspectRatio: 16 / 9,
//       autoPlay: false,
//       looping: true,
//       allowedScreenSleep: false,
//       autoInitialize: true,
//     );
//   }

//   @override
//   void dispose() {
//     _chewieController.dispose();
//     _videoPlayerController.dispose();
//     super.dispose();
//   }

//   Widget _playView(BuildContext context) {
//     final controller = _chewieController;
//     if (controller.videoPlayerController.value.isInitialized &&
//         controller.isPlaying) {
//       return SizedBox(
//         height: 250,
//         child: Chewie(controller: controller),
//       );
//     } else {
//       return const Text('Loading...');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               _playArea
//                   ? _playView(context)
//                   : Stack(
//                       children: [
//                         Image.asset(
//                           courseItem[widget.index].iconUrl,
//                           height: 250,
//                           width: MediaQuery.of(context).size.width,
//                           fit: BoxFit.cover,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 98.0),
//                           child: Center(
//                             child: SizedBox(
//                               width: 48,
//                               height: 48,
//                               child: CircleButton(
//                                 widthIcon: 24,
//                                 heightIcon: 24,
//                                 bgColor: DarkTheme.white.withOpacity(0.6),
//                                 assetPath: AssetPath.iconPlay,
//                                 onTap: () {
//                                   setState(() {
//                                     if (_playArea == false) {
//                                       _playArea = true;
//                                       _chewieController.play();
//                                     }
//                                   });
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.bottomRight,
//                           child: Padding(
//                             padding: const EdgeInsets.only(
//                                 top: 214, right: 24.0, bottom: 16),
//                             child: SizedBox(
//                               width: 38,
//                               height: 20,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(4),
//                                   color: DarkTheme.white.withOpacity(0.6),
//                                 ),
//                                 alignment: Alignment.center,
//                                 child: const Text(
//                                   '10:09',
//                                   style: TxtStyle.headline6,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 16.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           ClassicButton(
//                             onTap: () {},
//                             width: 132,
//                             radius: 10,
//                             widthRadius: 0.0,
//                             colorRadius: DarkTheme.yellow.withOpacity(0.1),
//                             height: 32,
//                             color: DarkTheme.yellow.withOpacity(0.1),
//                             child: Center(
//                                 child: Text(
//                               courseItem[widget.index].part!.toUpperCase(),
//                               style: TxtStyle.buttonSmall.copyWith(
//                                 color: DarkTheme.yellow,
//                               ),
//                             )),
//                           ),
//                           Image.asset(
//                             AssetPath.iconMore,
//                             fit: BoxFit.cover,
//                             height: 24,
//                             width: 24,
//                           ),
//                         ],
//                       ),
//                     ),
//                     Text(
//                       courseItem[widget.index].title,
//                       maxLines: 1,
//                       style: TxtStyle.headline2,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 4.0, bottom: 16),
//                       child: Row(
//                         children: [
//                           Text(
//                             'James Haritz',
//                             style: TxtStyle.headline5.copyWith(
//                               color: DarkTheme.greyScale500,
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 8.0),
//                             child: Container(
//                               width: 4,
//                               height: 4,
//                               decoration: const BoxDecoration(
//                                 color: DarkTheme.greyScale500,
//                                 shape: BoxShape.circle,
//                               ),
//                             ),
//                           ),
//                           Text(
//                             'Teaching Psychology',
//                             style: TxtStyle.headline5.copyWith(
//                               color: DarkTheme.greyScale500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     RichText(
//                       text: TextSpan(
//                         text:
//                             'In this meeting i want introduce myself and talk\nabout this course about social psychology. Th...\n',
//                         style: TxtStyle.headline5,
//                         children: <TextSpan>[
//                           TextSpan(
//                             text: 'Show All',
//                             style: TxtStyle.bodyMedium.copyWith(
//                               color: DarkTheme.primaryBlue600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 20.0),
//                       child: Divider(
//                         color: DarkTheme.greyScale50.withOpacity(0.8),
//                       ),
//                     ),
//                     widget.index == courseItem.length - 1
//                         ? const Text(
//                             'THE END',
//                             style: TxtStyle.headline1,
//                           )
//                         : Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 'Next Video',
//                                 style: TxtStyle.buttonLarge,
//                               ),
//                               const SizedBox(height: 16),
//                               buildListDownloadVideo(
//                                   courseItem, widget.index + 1),
//                             ],
//                           ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   ListView buildListDownloadVideo(List<ModelCourse> list, int indexSent) {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: list.length - indexSent,
//       itemBuilder: (context, index) {
//         index = indexSent++;
//         return Padding(
//           padding: const EdgeInsets.only(bottom: 20),
//           child: ItemsCourse(
//             onTap: () {
//               setState(() {
//                 if (_playArea == false) {
//                   _playArea = true;
//                 }
//               });
//               //_playView(context);
//             },
//             assetName: list[index].iconUrl,
//             time: list[index].time,
//             part: list[index].part,
//             title: list[index].title,
//           ),
//         );
//       },
//     );
//   }
// }
