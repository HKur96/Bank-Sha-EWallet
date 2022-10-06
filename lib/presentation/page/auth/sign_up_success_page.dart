import 'package:flutter/material.dart';

import '../../../config/app_color.dart';
import '../../widget/custom_button.dart';
import '../home_page.dart';

class SignUpSuccessPage extends StatelessWidget {
  const SignUpSuccessPage({Key? key}) : super(key: key);
  static const routeName = '/sign-up-success-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Akun Berhasil\nTerdaftar',
                style: AppColor.blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: AppColor.semiBold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 26),
                Text(
                  'Grow your finance start\ntogether with us',
                  style: AppColor.greyTextStyle.copyWith(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                CustomFilledButton(
                  title: 'Get Started',
                  width: 183,
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, HomePage.routeName, (route) => false);
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}
