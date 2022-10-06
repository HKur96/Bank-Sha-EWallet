import 'package:flutter/material.dart';

import '../../../presentation/page/home_page.dart';
import '../../../config/app_color.dart';
import '../../../presentation/widget/custom_button.dart';

class UpdateProfileSuccessPage extends StatelessWidget {
  const UpdateProfileSuccessPage({Key? key}) : super(key: key);
  static const routeName = '/update-profile-success';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nice Update!',
              style: AppColor.blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: AppColor.semiBold,
              ),
            ),
            const SizedBox(height: 26),
            Text(
              'Your data is safe with\nour system',
              style: AppColor.greyTextStyle.copyWith(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            CustomFilledButton(
              title: 'My Profile',
              width: 190,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context,HomePage.routeName, (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
