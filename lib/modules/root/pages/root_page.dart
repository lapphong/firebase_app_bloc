import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_bloc/assets/assets_path.dart';
import 'package:firebase_app_bloc/repositories/app_repository/app_base.dart';
import 'package:firebase_app_bloc/repositories/user_repository/user_base.dart';
import 'package:firebase_app_bloc/repositories/user_repository/user_repository.dart';
import 'package:firebase_app_bloc/services/notification_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/blocs.dart';
import '../../../repositories/app_repository/app_repository.dart';
import '../../../themes/themes.dart';
import '../../../utils/showSnackBar.dart';
import '../../details/blocs/blocs.dart';
import '../../home/blocs/blocs.dart';
import '../../home/pages/home_page.dart';
import '../../setting/pages/setting_page.dart';
import '../cubits/cubits.dart';
import '../enums/tab_item.dart';
import '../widgets/cupertino_home_scaffold.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserBase>(
          create: (context) => UserRepository(
            firebaseFirestore: FirebaseFirestore.instance,
            firebaseStorage: FirebaseStorage.instance,
          ),
        ),
        RepositoryProvider<AppBase>(
          create: (context) => AppRepository(
            firebaseFirestore: FirebaseFirestore.instance,
            firebaseStorage: FirebaseStorage.instance,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => TabCubit()),
          BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit(
              userBase: context.read<UserBase>(),
            )..getProfile(uid: context.read<AppBloc>().state.user!.uid),
          ),
          BlocProvider(
            create: (context) => ClassBloc(appBase: context.read<AppBase>()),
          ),
          BlocProvider(
            create: (context) => MentorBloc(appBase: context.read<AppBase>()),
          ),
          BlocProvider(
            create: (context) => DetailBloc(appBase: context.read<AppBase>()),
          ),
        ],
        child: const RootView(),
      ),
    );
  }
}

class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  @override
  void initState() {
    super.initState();
    context.read<ClassBloc>().add(GetListCourseEvent());
    context.read<MentorBloc>().add(GetListMentorEvent());
  }

  static final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.activity: GlobalKey<NavigatorState>(),
    TabItem.category: GlobalKey<NavigatorState>(),
    TabItem.setting: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.home: (_) => const HomePage(),
      TabItem.activity: (_) => const ActivityPage(),
      TabItem.category: (_) => const CategoryPage(),
      TabItem.setting: (_) => const SettingPage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final currentTab = context.select((TabCubit cubit) => cubit.state.tab);
    return WillPopScope(
      onWillPop: () => _onWillPop(context, currentTab),
      child: CupertinoHomeScaffold(
        currentTab: currentTab,
        onSelectTab: (TabItem tabItem) {
          tabItem == currentTab
              ? navigatorKeys[tabItem]!
                  .currentState
                  ?.popUntil((route) => route.isFirst)
              : context.read<TabCubit>().setTab(tabItem);
        },
        widgetBuilders: widgetBuilders,
        navigatorKeys: navigatorKeys,
      ),
    );
  }

  DateTime timeBackPress = DateTime.now();
  Future<bool> _onWillPop(BuildContext context, TabItem currentTab) async {
    String? currentRoute;
    navigatorKeys[currentTab]?.currentState!.popUntil((route) {
      currentRoute = route.settings.name;
      return true;
    });

    if (currentRoute == '/') {
      final difference = DateTime.now().difference(timeBackPress);
      final cantExit = difference >= const Duration(seconds: 2);
      timeBackPress = DateTime.now();
      if (cantExit) {
        showSnackBar(
          context,
          "Click again Press Back button to Exit",
          const Icon(Icons.exit_to_app, color: DarkTheme.white),
        );
        return false;
      } else {
        return true;
      }
    } else {
      return !await navigatorKeys[currentTab]!.currentState!.maybePop();
    }
  }
}

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key, this.payload});
  final String? payload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Activity'),
            Text(
              payload ?? 'abc',
              style: TxtStyle.headline1,
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    listenToNotificationStream();
  }

  void listenToNotificationStream() {
    _notificationService.selectNotificationStream.stream
        .listen((String? payload) async {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ActivityPage(payload: payload)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Category Page', style: TxtStyle.headline1),
              const SizedBox(height: 16),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(DarkTheme.primaryBlue600),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  onPressed: () async {
                    await _notificationService.showScheduledLocalNotification(
                      id: 1,
                      title: "Drink Water",
                      body: "Time to drink some water!",
                      payload: "You just took water! Hurray!",
                      seconds: 10,
                    );

                    //await _notificationService.showGroupedNotifications();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AssetPath.iconBell, color: DarkTheme.white),
                      const SizedBox(width: 10),
                      const Text('Show notification'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
