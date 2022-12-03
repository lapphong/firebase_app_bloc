import 'package:flutter/cupertino.dart';

import '../../themes/app_color.dart';

class ToggleSwitchButton extends StatelessWidget {
  const ToggleSwitchButton({
    Key? key,
    this.value = false,
    this.onChanged,
  }) : super(key: key);
  final bool value;
  final Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: CupertinoSwitch(
        value: value,
        activeColor: DarkTheme.primaryBlue600,
        onChanged: onChanged,
      ),
    );
  }
}
