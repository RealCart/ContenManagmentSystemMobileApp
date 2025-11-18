import 'package:flutter/material.dart';
import 'package:instai/core/constants/app_colors.dart';
import 'package:instai/core/presentation/widgets/custom_text_form_filed.dart';
import 'package:instai/core/utils/app_validators.dart';
import 'package:instai/features/authorization/presentation/widget/password_text_field.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.emailController,
    required this.emailFocusNode,
    required this.passwordController,
    required this.passwordFocusNode,
    required this.repeatPasswordController,
    required this.repeatPasswordFocusNode,
    required this.onFinishedForm,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController repeatPasswordController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode repeatPasswordFocusNode;
  final VoidCallback onFinishedForm;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTextFormFiled(
          controller: emailController,
          focusNode: emailFocusNode,
          backgroundColor: AppColors.white,
          maxLines: 1,
          hintText: "Login",
          textColor: AppColors.black,
          validator: (value) => AppValidators.loginValidator(value),
          onFieldSubmitted: (value) => passwordFocusNode.requestFocus(),
        ),
        const SizedBox(height: 10.0),
        PasswordTextField(
          controller: passwordController,
          validator: (value) => AppValidators.passwordValidator(value),
          focusNode: passwordFocusNode,
          hintText: "Password",
          onFieldSubmitted: (value) => repeatPasswordFocusNode.requestFocus(),
        ),
        const SizedBox(height: 10.0),
        PasswordTextField(
          controller: repeatPasswordController,
          validator: (value) => AppValidators.repeatPasswordValudator(
            value,
            passwordController.text,
          ),
          focusNode: repeatPasswordFocusNode,
          hintText: "Repeat password",
          onFieldSubmitted: (_) => onFinishedForm.call(),
        ),
      ],
    );
  }
}
