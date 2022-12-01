import 'package:flutter/material.dart';

import '../../../assets/assets_path.dart';
import '../enums/tab_item.dart';


class TabItemData {
  const TabItemData({
    required this.icon,
    required this.label,
  });
  final AssetImage icon;
  final String label;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.home: TabItemData(
      label: 'Home',
      icon: AssetImage(AssetPath.iconHome),
    ),
    TabItem.activity: TabItemData(
      label: 'Activity',
      icon: AssetImage(AssetPath.iconActivity),
    ),
    TabItem.category: TabItemData(
      label: 'Category',
      icon: AssetImage(AssetPath.iconCategory),
    ),
    TabItem.setting: TabItemData(
      label: 'Setting',
      icon: AssetImage(AssetPath.iconSetting),
    ),
  };
}
