import 'package:firebase_app_bloc/generated/l10n.dart';
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
    this.validator,
    this.onSubmit,
    this.enable = true,
    this.readOnly = false,
    this.initialValue = '',
  }) : super(key: key);

  final FocusNode? emailFocusNode;
  final TextEditingController? emailController;
  final ValueChanged<String>? onChange, onSubmit;
  final bool enable, readOnly;
  final String? errorText, initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final Function()? onEditingComplete;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return CommonTextField(
      initialValue: initialValue,
      validator: validator,
      errorText: errorText,
      controller: emailController,
      hintText: S.of(context).enterYourEmailAddress,
      label: S.of(context).email,
      enable: enable,
      readOnly: readOnly,
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
