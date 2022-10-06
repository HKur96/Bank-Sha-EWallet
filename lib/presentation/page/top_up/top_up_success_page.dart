import 'package:flutter/material.dart';

import '../../../config/app_color.dart';
import '../../../presentation/page/home_page.dart';
import '../../../presentation/widget/custom_button.dart';

class TopUpSuccessPage extends StatelessWidget {
  const TopUpSuccessPage({Key? key}) : super(key: key);
  static const routeName = '/top-up-success';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Top Up \nWallet Berhasil',
              style: AppColor.blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: AppColor.semiBold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 26),
            Text(
              'Use the money wisely and\ngrow your finance',
              style: AppColor.greyTextStyle.copyWith(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            CustomFilledButton(
              title: 'Back to Home',
              width: 230,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, HomePage.routeName, (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
