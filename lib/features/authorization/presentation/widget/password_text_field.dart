import 'package:flutter/material.dart';
import 'package:instai/core/constants/app_colors.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    this.hintText,
    this.controller,
    this.focusNode,
    this.validator,
    this.onFieldSubmitted,
  });

  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _show = true;

  void _toggle() {
    setState(() {
      _show = !_show;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _show,
      controller: widget.controller,
      style: const TextStyle(color: AppColors.black),
      decoration: InputDecoration(
        hintText: widget.hintText,
        fillColor: AppColors.white,
        filled: true,
        hintStyle: const TextStyle(color: AppColors.gray),
        suffixIcon: TapRegion(
          onTapUpInside: (_) => _toggle(),
          child: Icon(
            _show ? Icons.visibility_off_rounded : Icons.visibility_rounded,
            color: AppColors.gray,
          ),
        ),
      ),
      errorBuilder: (context, errorText) => Text(
        errorText,
        style: const TextStyle(fontSize: 12.0, color: AppColors.white),
      ),
      cursorErrorColor: AppColors.blue,
      validator: widget.validator,
      focusNode: widget.focusNode,
      onFieldSubmitted: widget.onFieldSubmitted,
      onTapUpOutside: (event) => widget.focusNode?.unfocus(),
    );
  }
}
