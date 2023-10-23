import 'package:flutter/material.dart';
import 'package:gisscope/styles/app_colors.dart';

class AppTextField extends StatelessWidget {
  final String hint;
  final bool? obscureText;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final bool? autofocus;
  final ValueChanged<String>? onFieldSubmitted;
  final TextEditingController? controller;
  final ValueChanged<String>? onChange;
  final FormFieldValidator<String>? validate;
  const AppTextField(
      {super.key,
      required this.hint,
      this.onChange,
      this.validate,
      this.controller,
      this.suffixIcon,
      this.obscureText,
      this.focusNode,
      this.autofocus,
      this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      autofocus: autofocus ?? false,
      focusNode: focusNode,
      obscureText: obscureText ?? false,
      controller: controller,
      validator: validate,
      onChanged: onChange,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hint,
        labelText: hint,
        labelStyle: const TextStyle(color: AppColors.white),
        border: const UnderlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        filled: true,
        fillColor: AppColors.fieldColor,
      ),
    );
  }
}
