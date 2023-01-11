import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/models.dart';
import '../../../repositories/repository.dart';
import '../../../routes/route_name.dart';
import '../../../themes/themes.dart';
import '../../../widgets/stateless/stateless.dart';
import '../blocs/blocs.dart';
import '../widgets/detail_widget.dart';

class DetailMentorPage extends StatelessWidget {
  const DetailMentorPage({super.key, required this.teacher});
  final Teacher teacher;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailMentorCubit(appBase: context.read<AppBase>()),
      child: DetailMentorView(teacher: teacher),
    );
  }
}

class DetailMentorView extends StatefulWidget {
  const DetailMentorView({super.key, required this.teacher});
  final Teacher teacher;

  @override
  State<DetailMentorView> createState() => _DetailMentorViewState();
}

class _DetailMentorViewState extends State<DetailMentorView> {
  @override
  void initState() {
    super.initState();
    context
        .read<DetailMentorCubit>()
        .getListProductByTeacherID(id: widget.teacher.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(height: 150, color: DarkTheme.primaryBlueButton),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 70),
                  buildInfoTeacher(),
                  const SizedBox(height: 20),
                  const Text('All course:', style: TxtStyle.headline3),
                  buildListCourseByTeacher(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListCourseByTeacher() {
    return BlocBuilder<DetailMentorCubit, DetailMentorState>(
      builder: (context, state) {
        return ListView.separated(
          padding: const EdgeInsets.only(top: 10),
          shrinkWrap: true,
          itemCount: state.product.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Divider(),
            );
          },
          itemBuilder: (BuildContext context, int index) {
            if (state.statusProduct == ProductStatus.initial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.statusProduct == ProductStatus.error) {
              return const StatusError();
            }
            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ItemProductCourse(
                onTap: () {
                  Navigator.of(context).pushNamed(RouteName.detailCoursePage,
                      arguments: state.product[index]);
                },
                tagHeroImg: state.product[index].image,
                titleCourse: state.product[index].title,
                imgUrl: state.product[index].image,
                assessmentScore: state.product[index].assessmentScore,
                reviewer: state.product[index].reviewer,
                duration: state.product[index].duration,
              ),
            );
          },
        );
      },
    );
  }

  Widget buildInfoTeacher() {
    return Center(
      child: Column(
        children: [
          AvatarTeacher(
            urlImg: widget.teacher.imgUrl,
            tagImgHero: widget.teacher.imgUrl,
          ),
          const SizedBox(height: 10),
          Text(widget.teacher.name, style: TxtStyle.headline2),
          Text(
            '(${widget.teacher.specialize})',
            style: TxtStyle.headline5.copyWith(color: DarkTheme.greyScale500),
          ),
        ],
      ),
    );
  }
}
