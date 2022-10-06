// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../config/app_asset.dart';
import '../../config/app_color.dart';

class CustomPasswordField extends StatefulWidget {
  final String title;
  final TextEditingController? controller;
  final bool isShowTitle;
  final TextInputType? keyboardType;
  final Function(String)? onFieldSubmitted;
  final VoidCallback? onEditingComplete;

  const CustomPasswordField({
    Key? key,
    required this.title,
    this.controller,
    this.isShowTitle = true,
    this.keyboardType,
    this.onFieldSubmitted,
    this.onEditingComplete,
  }) : super(key: key);

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isShowTitle)
          Text(
            widget.title,
            style: AppColor.blackTextStyle.copyWith(
              fontWeight: AppColor.semiBold,
              fontSize: 16,
            ),
          ),
        if (widget.isShowTitle) const SizedBox(height: 8),
        TextFormField(
          obscureText: obscureText,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          onEditingComplete: widget.onEditingComplete,
          decoration: InputDecoration(
            hintText: (!widget.isShowTitle) ? widget.title : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
            contentPadding: const EdgeInsets.all(12),
            suffixIcon: IconButton(
              icon: Image.asset(
                AppAsset.icShowPassword,
                width: 18,
                height: 18,
              ),
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
            ),
          ),
          onFieldSubmitted: widget.onFieldSubmitted,
        ),
      ],
    );
  }
}
