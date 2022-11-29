import 'package:firebase_app_bloc/modules/authentication/pages/splash_page.dart';
import 'package:firebase_app_bloc/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/app/app_bloc.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state.appStatus == AppStatus.unauthenticated) {
          Navigator.pushNamedAndRemoveUntil(context, RouteName.signInPage,
              (route) {
            print('route.settings.name: ${route.settings.name}');
            print('ModalRoute: ${ModalRoute.of(context)!.settings.name}');

            return route.settings.name == ModalRoute.of(context)!.settings.name
                ? true
                : false;
          });
        } else if (state.appStatus == AppStatus.authenticated) {
          Navigator.pushNamed(context, RouteName.homePage);
        }
      },
      builder: (context, state) {
        return const SplashPage();
      },
    );
  }
}
