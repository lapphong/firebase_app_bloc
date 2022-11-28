import 'package:flutter/material.dart';

import '../themes/app_color.dart';

void showSnackBar(BuildContext context, String text, Widget image) {
  final snackBar = SnackBar(
    backgroundColor: DarkTheme.greyScale800,
    content: Row(
      children: [
        image,
        const SizedBox(width: 20),
        Text(text),
      ],
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
