import 'package:firebase_app_bloc/modules/dashboardPage.dart';
import 'package:firebase_app_bloc/routes/route_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../modules/authentication/pages/sign_up/sign_up_page.dart';

class Routes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _buildRoute(settings, const DashBoardPage());
      case RouteName.signUpPage:
        return _buildRoute(settings, const SignUpPage());

      // case RouteName.verifyYourPage:
      //   return _buildRoute(settings, const VerifyYourPage());
      // case RouteName.selectPlanPage:
      //   return _buildRoute(settings, const SelectPlanPage());
      // case RouteName.homePage:
      //   return _buildRoute(settings, const RootPage());
      // case RouteName.activityPage:
      //   return _buildRoute(
      //       settings, const RootPage(currentTab: TabItem.activity));
      // case RouteName.categoryPage:
      //   return _buildRoute(
      //       settings, const RootPage(currentTab: TabItem.category));
      // case RouteName.settingPage:
      //   return _buildRoute(
      //       settings, const RootPage(currentTab: TabItem.setting));
      // case RouteName.languagePage:
      //   return _buildRoute(settings, const LanguagePage());
      // case RouteName.favoritePage:
      //   return _buildRoute(settings, const MyFavoritePage());
      // case RouteName.downloadVideoPage:
      //   return _buildRoute(settings, DownloadVideoPage());
      // case RouteName.editProfilePage:
      //   return _buildRoute(settings, const EditProfilePage());
      // case RouteName.detailMentorPage:
      //   return _buildRoute(settings, const DetailMentorPage());
      // case RouteName.playingCoursePage:
      //   return _buildRoute(settings, const PlayingCoursePage());
      // case RouteName.fullScreenPage:
      //   return _buildRoute(settings, const LandingPage());
      default:
        return _errorRoute(settings);
    }
  }

  static CupertinoPageRoute _buildRoute(
      RouteSettings settings, Widget builder) {
    return CupertinoPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }

  static Route _errorRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(child: Text('No route defined for ${settings.name}')),
      ),
    );
  }
}
