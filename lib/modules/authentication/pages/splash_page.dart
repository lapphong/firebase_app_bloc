import 'package:flutter/material.dart';

import '../../../themes/themes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkTheme.greyScale900,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Expanded(
            flex: 8,
            child: Center(child: Text('Ontari.', style: TxtStyle.titleBig)),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 34.0),
              child: Text(
                textAlign: TextAlign.center,
                'Lorem ipsum dolor sit amet, consectetur adipiscing\nelit. Tincidunt et, volutpat duis amet, risus.',
                style: TxtStyle.bodySmallMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}