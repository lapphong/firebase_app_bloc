import 'package:flutter/material.dart';

import '../../assets/assets_path.dart';
import '../../themes/app_color.dart';
import '../../themes/text_style.dart';

class Terms extends StatefulWidget {
  const Terms({
    Key? key,
    this.size,
  }) : super(key: key);
  final Size? size;

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  bool? _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected!;
        });
      },
      child: SizedBox(
        width: widget.size!.width,
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _isSelected!
                ? Image.asset(AssetPath.iconCheck)
                : Image.asset(AssetPath.iconUncheck),
            const Padding(padding: EdgeInsets.only(left: 12)),
            RichText(
              text: TextSpan(
                text: 'By Creating your account you have to agree with\nour',
                style: TxtStyle.buttonSmall.copyWith(
                  color: DarkTheme.greyScale500,
                ),
                children: const <TextSpan>[
                  TextSpan(
                    text: ' Terms and Condition',
                    style: TxtStyle.headline6,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
