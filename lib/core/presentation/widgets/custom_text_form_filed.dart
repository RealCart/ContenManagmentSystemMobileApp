import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instai/core/constants/app_colors.dart';

class CustomTextFormFiled extends StatelessWidget {
  const CustomTextFormFiled({
    super.key,
    this.hintText,
    this.controller,
    this.focusNode,
    this.validator,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.minLines,
    required this.maxLines,
    this.expands = false,
    this.contentPadding,
    this.textColor,
    this.backgroundColor,
  });

  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool expands;
  final EdgeInsets? contentPadding;
  final Color? textColor;
  final Color? backgroundColor;
  final int? minLines;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.gray),
        contentPadding: contentPadding,
        fillColor: backgroundColor,
        filled: true,
      ),
      minLines: minLines,
      maxLines: maxLines,
      expands: expands,
      keyboardType: null,
      errorBuilder: (context, errorText) =>
          Text(errorText, style: Theme.of(context).textTheme.bodySmall),
      cursorErrorColor: AppColors.blue,
      validator: validator,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: inputFormatters,
      onTapUpOutside: (event) => focusNode?.unfocus(),
    );
  }
}
