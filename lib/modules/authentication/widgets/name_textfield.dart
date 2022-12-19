import 'package:firebase_app_bloc/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../assets/assets_path.dart';
import '../../../widgets/stateless/common_avatar.dart';
import '../../../widgets/stateless/common_textfield.dart';

class TextFieldName extends StatelessWidget {
  const TextFieldName({
    Key? key,
    this.nameFocusNode,
    this.nameController,
    this.onChange,
    this.errorText,
    this.inputFormatters,
    this.onEditingComplete,
    this.validator,
    this.onSubmit,
    this.enable = true,
    this.initialValue = '',
    this.readOnly = false,
    this.autoFocus = false,
    this.inputType,
  }) : super(key: key);

  final FocusNode? nameFocusNode;
  final TextEditingController? nameController;
  final ValueChanged<String>? onChange, onSubmit;
  final bool enable, readOnly, autoFocus;
  final String? errorText, initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final Function()? onEditingComplete;
  final String? Function(String?)? validator;
  final TextInputAction? inputType;

  @override
  Widget build(BuildContext context) {
    return CommonTextField(
      initialValue: initialValue,
      autoFocus: autoFocus,
      validator: validator,
      errorText: errorText,
      readOnly: readOnly,
      controller: nameController,
      hintText: S.of(context).enterYourName,
      label: S.of(context).name,
      onEditingComplete: onEditingComplete,
      enable: enable,
      focusNode: nameFocusNode,
      inputFormatters: inputFormatters,
      inputType: TextInputType.name,
      inputAction: inputType ?? TextInputAction.next,
      onChange: onChange,
      onSubmit: onSubmit,
      prefixIcon: const Align(
        widthFactor: 0.5,
        heightFactor: 0.5,
        child: CustomAvatar(
          width: 15,
          height: 15,
          assetName: AssetPath.iconUser,
        ),
      ),
    );
  }
}
