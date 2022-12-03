import 'package:flutter/cupertino.dart';

import '../../../themes/app_color.dart';
import '../enums/tab_item.dart';
import '../models/tab_item.dart';
import '../../../routes/routes.dart' as router;

class CupertinoHomeScaffold extends StatelessWidget {
  const CupertinoHomeScaffold({
    Key? key,
    required this.currentTab,
    required this.onSelectTab,
    required this.widgetBuilders,
    required this.navigatorKeys,
  }) : super(key: key);

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Map<TabItem, WidgetBuilder> widgetBuilders;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: DarkTheme.greyScale800,
        currentIndex: currentTab.index,
        height: 55,
        iconSize: 20,
        items: [
          _buildItem(TabItem.home),
          _buildItem(TabItem.activity),
          _buildItem(TabItem.category),
          _buildItem(TabItem.setting),
        ],
        onTap: (index) => onSelectTab(TabItem.values[index]),
      ),
      tabBuilder: (context, index) {
        final item = TabItem.values[index];
        return CupertinoTabView(
          navigatorKey: navigatorKeys[item],
          builder: (context) => widgetBuilders[item]!(context),
          onGenerateRoute: router.Routes.generateRoute,
        );
      },
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final itemData = TabItemData.allTabs[tabItem]!;
    final color = currentTab == tabItem
        ? DarkTheme.primaryBlue600
        : DarkTheme.greyScale400;
    return BottomNavigationBarItem(
      icon: ImageIcon(itemData.icon, color: color),
      label: itemData.label,
    );
  }
}
