import 'package:flutter/material.dart';

import '../../themes/app_color.dart';
import '../../themes/text_style.dart';

class Terms extends StatelessWidget {
  const Terms({
    Key? key,
    this.value,
    required this.onChanged,
    required this.onTap,
  }) : super(key: key);

  final bool? value;
  final Function(bool?) onChanged;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Checkbox(
              side: MaterialStateBorderSide.resolveWith(
                  (states) => const BorderSide(width: 0.0)),
              activeColor: DarkTheme.green,
              checkColor: DarkTheme.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0)),
              value: value,
              onChanged: onChanged,
            ),
          ),
          const SizedBox(width: 18),
          InkWell(
            onTap: onTap,
            child: RichText(
              text: TextSpan(
                text: 'By Creating your account you have to agree with\nour',
                style: TxtStyle.buttonSmall.copyWith(
                  color: DarkTheme.greyScale500,
                ),
                children: [
                  TextSpan(
                    text: ' Terms and Condition',
                    style: TxtStyle.headline6.copyWith(
                      color: DarkTheme.primaryBlue600,
                    ),
                  ),
                  TextSpan(
                    text: ' *',
                    style: TxtStyle.headline4.copyWith(
                      color: DarkTheme.red,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
