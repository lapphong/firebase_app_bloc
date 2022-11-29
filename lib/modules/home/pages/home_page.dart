import 'package:firebase_app_bloc/themes/text_style.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('HomePgae',style:TxtStyle.headline1),
      ),
    );
  }
}