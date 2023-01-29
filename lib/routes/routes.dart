import 'package:firebase_app_bloc/modules/dashboardPage.dart';
import 'package:firebase_app_bloc/modules/details/pages/detail_course_page.dart';
import 'package:firebase_app_bloc/modules/playing/pages/playing_course_page.dart';
import 'package:firebase_app_bloc/routes/route_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../modules/authentication/authentication.dart';
import '../modules/details/pages/detail_mentor_page.dart';
import '../modules/setting/pages/setting_pages.dart';

class Routes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _buildRoute(settings, const DashBoardPage());
      case RouteName.signUpPage:
        return _buildRoute(settings, const SignUpPage());
      case RouteName.languagePage:
        return _buildRoute(settings, const ChangeLanguagePage());
      case RouteName.favoritePage:
        return _buildRoute(settings, const MyFavoritePage());
      case RouteName.editProfilePage:
        final user = settings.arguments;
        if (user is User) {
          return _buildRoute(settings, EditProfilePage(user: user));
        }
        break;
      case RouteName.detailCoursePage:
        final product = settings.arguments;
        if (product is Product) {
          return _buildRoute(settings, DetailCoursePage(product: product));
        }
        break;
      case RouteName.detailMentorPage:
        final teacher = settings.arguments;
        if (teacher is Teacher) {
          return _buildRoute(settings, DetailMentorPage(teacher: teacher));
        }
        break;
      case RouteName.playingCoursePage:
        final arguments = settings.arguments as Map;
        if (arguments['videoCourse'] is VideoCourse &&
            arguments['context'] is BuildContext) {
          return _buildRoute(
            settings,
            PlayingCoursePage(
              videoCourse: arguments['videoCourse'],
              context: arguments['context'],
              product: arguments['product'],
            ),
          );
        }
        return _errorRoute(settings);
      default:
        return _errorRoute(settings);
    }
  }

  static CupertinoPageRoute _buildRoute(
    RouteSettings settings,
    Widget builder,
  ) {
    return CupertinoPageRoute(
        settings: settings, builder: (BuildContext context) => builder);
  }

  static Route _errorRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(child: Text('No route defined for ${settings.name}')),
      ),
    );
  }
}
