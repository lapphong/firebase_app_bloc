import 'package:firebase_app_bloc/modules/activity/pages/complete_page.dart';
import 'package:firebase_app_bloc/modules/activity/pages/incomplete_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../assets/assets_path.dart';
import '../../../blocs/blocs.dart';
import '../../../repositories/repository.dart';
import '../../../themes/themes.dart';
import '../../../widgets/stateless/common_button.dart';
import '../blocs/blocs.dart';
import '../widgets/widgets.dart';
import '../../../models/models.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TabCubit>(create: (context) => TabCubit()),
        BlocProvider<ActivityListCubit>(
          create: (context) => ActivityListCubit(
            userBase: context.read<UserBase>(),
            profileCubit: BlocProvider.of<ProfileCubit>(context),
          ),
          lazy: false,
        ),
      ],
      child: const ActivityView(),
    );
  }
}

class ActivityView extends StatefulWidget {
  const ActivityView({Key? key}) : super(key: key);

  @override
  State<ActivityView> createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> {
  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Incomplete'),
    const Tab(text: 'Complete'),
  ];

  @override
  void initState() {
    super.initState();
    context.read<ActivityListCubit>().getListActivityByTab();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: myTabs.length,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      buildTitleActivity(),
                      const SizedBox(height: 24),
                      BlocBuilder<TabCubit, TabState>(
                        builder: (context, state) {
                          return state.tabStatus == TabStatus.incomplete
                              ? buildProgressUncompleted()
                              : const CompletedProgress();
                        },
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
                Material(
                  color: DarkTheme.primaryBlueButton,
                  child: TabBar(
                    onTap: (value) => context.read<TabCubit>().changeTab(value),
                    tabs: myTabs,
                    physics: const NeverScrollableScrollPhysics(),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: TxtStyle.headline4
                        .copyWith(color: DarkTheme.primaryBlue600),
                    unselectedLabelColor: DarkTheme.greyScale500,
                    unselectedLabelStyle: TxtStyle.headline4
                        .copyWith(color: DarkTheme.greyScale500),
                    labelColor: DarkTheme.primaryBlue600,
                    indicatorColor: DarkTheme.primaryBlue600,
                  ),
                ),
                Container(
                  height: 500,
                  color: DarkTheme.primaryBlueButton,
                  child: const TabBarView(
                    children: [
                      IncompletePage(),
                      CompletedPage(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProgressUncompleted() {
    return BlocBuilder<ActivityListCubit, ActivityListState>(
      builder: (context, state) {
        return UncompletedProgress(
          percent: state.totalProgress,
          percentUnCompleted: state.listInComplete.length,
          percentCompleted: state.listComplete.length,
        );
      },
    );
  }

  Widget buildTitleActivity() {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text('Activity', style: TxtStyle.title),
          SquareButton(
            bgColor: DarkTheme.greyScale800,
            edge: 40,
            radius: 10,
            child: ImageIcon(
              size: 13,
              color: DarkTheme.white,
              AssetImage(AssetPath.iconBell),
            ),
          ),
        ],
      ),
    );
  }
}
