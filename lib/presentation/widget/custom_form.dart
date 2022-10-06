import 'package:flutter/material.dart';

import '../../config/app_color.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final bool isShowTitle;
  final TextInputType? keyboardType;
  final Function(String)? onFieldSubmitted;

  const CustomTextField({
    Key? key,
    required this.title,
    this.controller,
    this.obscureText = false,
    this.isShowTitle = true,
    this.keyboardType,
    this.onFieldSubmitted,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isShowTitle)
          Text(
            title,
            style: AppColor.blackTextStyle.copyWith(
              fontWeight: AppColor.semiBold,
              fontSize: 16,
            ),
          ),
        if (isShowTitle) const SizedBox(height: 8),
        TextFormField(
          obscureText: obscureText,
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppColor.greyTextStyle,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
            contentPadding: const EdgeInsets.all(12),
          ),
          onFieldSubmitted: onFieldSubmitted,
        ),
      ],
    );
  }
}
