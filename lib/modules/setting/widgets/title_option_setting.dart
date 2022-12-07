import 'package:flutter/material.dart';
import '../../../themes/themes.dart';

class TitleOptionSettings extends StatelessWidget {
  const TitleOptionSettings({
    Key? key,
    this.title = '',
    this.height = 32,
  }) : super(key: key);

  final String title;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      color: DarkTheme.greyScale800,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Text(
            title,
            style: TxtStyle.headline6.copyWith(color: DarkTheme.greyScale500),
          ),
        ),
      ),
    );
  }
}
