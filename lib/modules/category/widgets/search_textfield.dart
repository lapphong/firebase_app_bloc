import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../assets/assets_path.dart';
import '../../../widgets/stateless/common_avatar.dart';
import '../../../widgets/stateless/common_textfield.dart';

class TextFieldSearch extends StatelessWidget {
  const TextFieldSearch({
    Key? key,
    this.nameFocusNode,
    this.nameController,
    this.onChange,
    this.errorText,
    this.inputFormatters,
    this.onEditingComplete,
    this.validator,
    this.onSubmit,
    this.hintText,
  }) : super(key: key);

  final FocusNode? nameFocusNode;
  final TextEditingController? nameController;
  final ValueChanged<String>? onChange, onSubmit;

  final String? errorText, hintText;
  final List<TextInputFormatter>? inputFormatters;
  final Function()? onEditingComplete;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return CommonTextField(
      validator: validator,
      errorText: errorText,
      controller: nameController,
      hintText: hintText,
      label: '',
      sizedBox: 0,
      focusNode: nameFocusNode,
      inputFormatters: inputFormatters,
      inputType: TextInputType.name,
      inputAction: TextInputAction.next,
      onChange: onChange,
      onSubmit: onSubmit,
      prefixIcon: const Align(
        widthFactor: 0.5,
        heightFactor: 0.5,
        child: CustomAvatar(
          width: 15,
          height: 15,
          assetName: AssetPath.iconSearch,
        ),
      ),
    );
  }
}
