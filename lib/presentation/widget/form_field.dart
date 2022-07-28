import 'package:flutter/material.dart';

import '../style/colors.dart';

class DefaultTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final IconData? suffixIcon;
  final TextInputType type;
  final String validate;
  final bool isPassword;
  final VoidCallback? onSubmit;
  final VoidCallback? onTap;
  final VoidCallback? onChange;
  final bool isClickable;

  const DefaultTextField({
    Key? key,
    required this.text,
    required this.controller,
    required this.validate,
    required this.type,
    this.suffixIcon,
    this.onTap,
    this.onChange,
    this.onSubmit,
    this.isPassword = false,
    this.isClickable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: (s) {
        onSubmit!();
      },
      validator: (String? value) {
        if (value!.isEmpty) {
          return validate;
        }
        return null;
      },
      onTap: onTap,
      decoration: InputDecoration(
        hintText: text,
        suffixIcon: Icon(
          suffixIcon,
          color: AppColors.darkGrey,
        ),
        filled: true,
        fillColor: Colors.grey[100],
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.lightGrey)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.lightGrey),
          borderRadius: BorderRadius.circular(10),
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
