import 'package:firebase_app_bloc/modules/authentication/pages/sign_in_page.dart';
import 'package:firebase_app_bloc/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: DarkTheme.greyScale900,
      statusBarBrightness: Brightness.light,
    ));
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: DarkTheme.greyScale900,
        fontFamily: 'manrope',
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: DarkTheme.white,
              displayColor: DarkTheme.white,
            ),
      ),
      home: const SignInPage(),
    );
  }
}
