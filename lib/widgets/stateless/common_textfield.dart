import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../themes/app_color.dart';
import '../../themes/text_style.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    this.onEditingComplete,
    this.obscureText = false,
    this.focusNode,
    this.hintText,
    this.suffix,
    this.prefixIcon,
    this.controller,
    this.background,
    this.errorText,
    this.minLine = 1,
    this.maxLine = 1,
    this.onChange,
    this.onSubmit,
    this.inputAction,
    this.inputType,
    this.enable = true,
    this.onTap,
    this.readOnly,
    this.inputFormatters,
    this.autoFocus,
    this.label = '',
    this.prefix,
    this.isRequired,
    Key? key,
  }) : super(key: key);

  final Widget? prefixIcon;
  final bool? obscureText, enable, readOnly;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText, errorText;
  final Widget? suffix;
  final Color? background;
  final int minLine, maxLine;
  final ValueChanged<String>? onChange, onSubmit;
  final TextInputAction? inputAction;
  final TextInputType? inputType;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final bool? autoFocus;
  final String label;
  final Widget? prefix;
  final bool? isRequired;
  final void Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TxtStyle.headline4),
        const SizedBox(height: 16),
        Theme(
          data: Theme.of(context).copyWith(
            iconTheme: const IconThemeData(
              size: 10,
            ),
            primaryColor: Theme.of(context).textTheme.headline5?.color,
          ),
          child: TextFormField(
            onEditingComplete: onEditingComplete,
            focusNode: focusNode,
            controller: controller,
            obscureText: obscureText ?? false,
            minLines: minLine,
            maxLines: maxLine,
            onChanged: onChange,
            onFieldSubmitted: onSubmit,
            textInputAction: inputAction ?? TextInputAction.done,
            keyboardType: inputType,
            enabled: enable,
            onTap: onTap,
            readOnly: readOnly ?? false,
            inputFormatters: inputFormatters,
            autofocus: autoFocus ?? false,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              counterText: '',
              hintText: hintText ?? '',
              errorText: errorText,
              suffixIcon: suffix,
              hintStyle:
                  TxtStyle.headline4.copyWith(color: DarkTheme.greyScale500),
              filled: true,
              fillColor: DarkTheme.greyScale800,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 18.0,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: DarkTheme.greyScale900,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: DarkTheme.red),
                borderRadius: BorderRadius.circular(12.0),
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
