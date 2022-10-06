import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../config/app_asset.dart';
import '../../config/app_color.dart';
import '../widget/custom_button.dart';
import './auth/sign_in_page.dart';
import './auth/sign_up_page.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);
  static const routeName = '/onboarding-page';

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  var carouselController = CarouselController();

  int currentIndex = 0;
  final List sliderItem = [
    AppAsset.imgOnboarding1,
    AppAsset.imgOnboarding2,
    AppAsset.imgOnboarding3,
  ];

  List<String> titles = [
    'Grow Your\nFinancial Today',
    'Build From\nZero to Freedom',
    'Start Together',
  ];

  List<String> subtitles = [
    'Our system is helping you to\nachieve a better goal',
    'We provide tips for you so that\nyou can adapt easier',
    'We will guide you to where\nyou wanted it too'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CarouselSlider(
              items: sliderItem.map((item) {
                return Image.asset(item);
              }).toList(),
              options: CarouselOptions(
                  height: 300,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  onPageChanged: (i, reason) {
                    setState(() {
                      currentIndex = i;
                    });
                  }),
              carouselController: carouselController,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: 10,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 24,
              ),
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(20),
              ),
              height: 250,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    titles[currentIndex],
                    style: AppColor.blackTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: AppColor.semiBold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    subtitles[currentIndex],
                    style: AppColor.greyTextStyle.copyWith(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  (currentIndex == 2)
                      ? Column(
                          children: [
                            CustomFilledButton(
                              title: 'Get Started',
                              width: double.infinity,
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    SignUpPage.routeName, (route) => false);
                              },
                            ),
                            const SizedBox(height: 10),
                            CustomTextButton(
                              title: 'Sign In',
                              width: double.infinity,
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    SignInPage.routeName, (route) => false);
                              },
                            )
                          ],
                        )
                      : Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (currentIndex == 0)
                                    ? AppColor.blueColor
                                    : AppColor.lightBgColor,
                              ),
                            ),
                            Container(
                              width: 12,
                              height: 12,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (currentIndex == 1)
                                    ? AppColor.blueColor
                                    : AppColor.lightBgColor,
                              ),
                            ),
                            Container(
                              width: 12,
                              height: 12,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (currentIndex == 2)
                                    ? AppColor.blueColor
                                    : AppColor.lightBgColor,
                              ),
                            ),
                            const Spacer(),
                            CustomFilledButton(
                              title: 'Continue',
                              width: 150,
                              onPressed: () {
                                carouselController.nextPage();
                              },
                            ),
                          ],
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
