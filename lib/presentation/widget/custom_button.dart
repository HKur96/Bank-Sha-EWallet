import 'package:flutter/material.dart';

import '../../config/app_color.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    Key? key,
    required this.title,
    required this.width,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final double width;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(56),
        color: AppColor.purpleColor,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: AppColor.whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: AppColor.semiBold,
          ),
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String title;
  final double width;
  final VoidCallback onPressed;

  const CustomTextButton({
    Key? key,
    required this.title,
    required this.width,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: width,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        child: Text(
          title,
          style: AppColor.greyTextStyle.copyWith(fontSize: 16),
        ),
      ),
    );
  }
}

class CustomCircleButton extends StatelessWidget {
  final String number;
  final VoidCallback? onTap;
  const CustomCircleButton({
    Key? key,
    required this.number,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.numberBgColor,
        ),
        child: Center(
          child: Text(
            number,
            style: AppColor.whiteTextStyle.copyWith(
              fontSize: 22,
              fontWeight: AppColor.semiBold,
            ),
          ),
        ),
      ),
    );
  }
}
