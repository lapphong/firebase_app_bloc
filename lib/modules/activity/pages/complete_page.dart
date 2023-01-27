import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/route_name.dart';
import '../../../widgets/stateless/stateless.dart';
import '../blocs/blocs.dart';
import '../widgets/widgets.dart';

class CompletedPage extends StatelessWidget {
  const CompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityListCubit, ActivityListState>(
      builder: (context, state) {
        if (state.activityStateStatus == ActivityStateStatus.initial) {
          return const CircularProgressIndicator();
        } else if (state.activityStateStatus == ActivityStateStatus.error) {
          return const StatusError();
        }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: state.listComplete.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 24, right: 24),
              child: ItemsActivity(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    RouteName.detailCoursePage,
                    arguments: state.listComplete[index],
                  );
                },
                title: state.listComplete[index].title,
                imgUrl: state.listComplete[index].image,
                percent: state.progressCourseComplete[index],
                duration: state.listComplete[index].duration,
                timeLearned: state.timeLearnedComplete[index],
              ),
            );
          },
        );
      },
    );
  }
}
