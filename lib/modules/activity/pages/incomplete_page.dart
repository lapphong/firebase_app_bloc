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
          itemCount: state.list.length,
          addAutomaticKeepAlives: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 24, right: 24),
              child: ItemsActivity(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    RouteName.detailCoursePage,
                    arguments: state.list[index],
                  );
                },
                title: state.list[index].title,
                imgUrl: state.list[index].image,
                percent: state.progressCourse[index],
                duration: state.list[index].duration,
                timeLearned: state.timeLearned[index],
              ),
            );
          },
        );
      },
    );
  }
}
