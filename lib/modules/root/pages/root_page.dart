import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../themes/themes.dart';
import '../../../utils/showSnackBar.dart';
import '../cubits/cubits.dart';
import '../enums/tab_item.dart';
import '../widgets/cupertino_home_scaffold.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TabCubit(),
      child: const RootView(),
    );
  }
}

class RootView extends StatelessWidget {
  const RootView({super.key});
  static var timeBackPress;

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
    timeBackPress = DateTime.now();
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
        navigatorKeys: RootView.navigatorKeys,
      ),
    );
  }

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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Home Page',
          style: TxtStyle.headline1,
        ),
      ),
    );
  }
}

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Activity Page',
          style: TxtStyle.headline1,
        ),
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'CategoryPage Page',
          style: TxtStyle.headline1,
        ),
      ),
    );
  }
}

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPage(),
                )),
            child: Text(
              'Setting Page',
              style: TxtStyle.headline1,
            )),
      ),
    );
  }
}

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Edit Page',
          style: TxtStyle.headline1,
        ),
      ),
    );
  }
}
