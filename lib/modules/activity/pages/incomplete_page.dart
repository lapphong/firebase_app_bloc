import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/route_name.dart';
import '../../../themes/themes.dart';
import '../../../widgets/stateless/stateless.dart';
import '../blocs/blocs.dart';
import '../widgets/widgets.dart';

class IncompletePage extends StatelessWidget {
  const IncompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityListCubit, ActivityListState>(
      builder: (context, state) {
        if (state.activityStateStatus == ActivityStateStatus.initial) {
          return const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: CupertinoActivityIndicator(color: DarkTheme.white),
          );
        } else if (state.activityStateStatus == ActivityStateStatus.error) {
          return const StatusError();
        }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: state.listInComplete.length,
          addAutomaticKeepAlives: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 24, right: 24),
              child: ItemsActivity(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    RouteName.detailCoursePage,
                    arguments: state.listInComplete[index],
                  );
                },
                title: state.listInComplete[index].title,
                imgUrl: state.listInComplete[index].image,
                percent: state.progressCourseInComplete[index],
                duration: state.listInComplete[index].duration,
                timeLearned: state.timeLearnedInComplete[index],
              ),
            );
          },
        );
      },
    );
  }
}
