import 'package:cydeva_application/common/Colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.textInputType,
    required this.obscureText,
    required this.suffixIcon,
    required this.hintText,
    this.validator,
    this.onSaved,
    this.onChanged,
    required this.prefixIcon,
    required this.readOnly,
    required this.width,
    required this.height,
    required this.colorHintText,
  });

  final TextEditingController controller;
  final TextInputType textInputType;
  final bool obscureText;
  final IconButton suffixIcon;
  final String hintText;
  final String? Function(String?)? validator; // Specify the type here
  final Function(String?)? onSaved;
  final Function(String)? onChanged;
  final Icon prefixIcon;
  final bool readOnly;
  final double width;
  final double height;
  final Color colorHintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      // cursorColor: Colors.black,
      readOnly: readOnly,
      controller: controller,
      keyboardType: textInputType,
      style: const TextStyle(
          color: AppColors.primaryText,
          fontWeight: FontWeight.normal,
          fontSize: 15),
      obscureText: obscureText,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          // isDense: true,
          hintStyle: TextStyle(color: colorHintText, fontSize: 16),
          border: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.neutral05),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          contentPadding: const EdgeInsets.all(20),
          suffixIcon: suffixIcon,
          hintText: hintText, // change here hinttext
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(width: 1, color: AppColors.primary3)),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1, color: AppColors.neutral05),
          )),
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
    );
  }
}
