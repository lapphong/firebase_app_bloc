import 'package:flutter/material.dart';

import '../themes/app_color.dart';

void showSnackBar(BuildContext context, String text, Widget image) {
  final snackBar = SnackBar(
    backgroundColor: DarkTheme.greyScale800,
    content: Row(
      children: [
        image,
        const SizedBox(width: 20),
        Expanded(
          child: Text(
            text,
            maxLines: 3,
            textDirection: TextDirection.ltr,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
    duration: const Duration(seconds: 3),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
