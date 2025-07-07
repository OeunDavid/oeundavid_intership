import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:products/core/constants/app_color.dart';

class TextfieldWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int? maxLines;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String pathIcon;

  TextfieldWidget({
    required this.label,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.maxLines,
    this.validator,
    this.onChanged,
    required this.pathIcon,
  });
  Widget build() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines ?? 1,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgPicture.asset(
              pathIcon,
              width: 24,
              height: 24,
              color: AppColor.textPrimary.withOpacity(0.5),
            ),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          floatingLabelStyle: TextStyle(color: AppColor.primary),
          labelStyle: TextStyle(color: AppColor.textPrimary.withOpacity(0.5)),
          hintStyle: TextStyle(color: AppColor.textPrimary.withOpacity(0.5)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColor.primary, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColor.textPrimary.withOpacity(0.5),
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
