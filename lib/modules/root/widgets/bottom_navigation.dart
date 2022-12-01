import 'package:flutter/material.dart';

import '../../../themes/app_color.dart';
import '../enums/tab_item.dart';
import '../models/tab_item.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    Key? key,
    required this.currentTab,
    required this.onSelectTab,
  }) : super(key: key);
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      backgroundColor: DarkTheme.greyScale800,
      unselectedItemColor: DarkTheme.greyScale400,
      selectedItemColor: DarkTheme.primaryBlue600,
      currentIndex: currentTab.index,
      items: [
        _buildItem(TabItem.home),
        _buildItem(TabItem.activity),
        _buildItem(TabItem.category),
        _buildItem(TabItem.setting),
      ],
      onTap: (index) => onSelectTab(TabItem.values[index]),
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final itemData = TabItemData.allTabs[tabItem]!;
    return BottomNavigationBarItem(
      icon: ImageIcon(itemData.icon),
      label: itemData.label,
      //activeIcon: itemData.activeIcon,
    );
  }
}
