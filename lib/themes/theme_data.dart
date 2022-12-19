import 'package:firebase_app_bloc/themes/themes.dart';
import 'package:flutter/material.dart';

class ThemeDataApp {
  static ThemeData get light {
    return ThemeData(
      scaffoldBackgroundColor: DarkTheme.white,
      fontFamily: 'manrope',
      dividerColor: DarkTheme.greyScale700,
      textTheme: ThemeData().textTheme.apply(
            bodyColor: DarkTheme.greyScale700,
            displayColor: DarkTheme.greyScale700,
          ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      scaffoldBackgroundColor: DarkTheme.greyScale900,
      fontFamily: 'manrope',
      dividerColor: DarkTheme.white,
      textTheme: ThemeData()
          .textTheme
          .apply(bodyColor: DarkTheme.white, displayColor: DarkTheme.white),
    );
  }
}
