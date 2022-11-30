import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../assets/assets_path.dart';
import '../../../widgets/stateless/common_avatar.dart';
import '../../../widgets/stateless/common_textfield.dart';

class TextFieldEmail extends StatelessWidget {
  const TextFieldEmail({
    Key? key,
    this.emailFocusNode,
    this.emailController,
    this.onChange,
    this.errorText,
    this.inputFormatters,
    this.onEditingComplete,
    this.onSubmit,
  }) : super(key: key);

  final FocusNode? emailFocusNode;
  final TextEditingController? emailController;
  final ValueChanged<String>? onChange, onSubmit;

  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  final Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return CommonTextField(
      errorText: errorText,
      controller: emailController,
      hintText: 'Enter your Email',
      label: 'Email',
      focusNode: emailFocusNode,
      inputFormatters: inputFormatters,
      inputType: TextInputType.emailAddress,
      inputAction: TextInputAction.next,
      onChange: onChange,
      onSubmit: onSubmit,
      prefixIcon: const Align(
        widthFactor: 0.5,
        heightFactor: 0.5,
        child: CustomAvatar(
          width: 15,
          height: 12,
          assetName: AssetPath.iconEmail,
        ),
      ),
    );
  }
}
