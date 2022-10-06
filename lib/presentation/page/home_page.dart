import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../presentation/widget/custom_button.dart';
import '../../presentation/page/transaction_history_page.dart';
import '../../config/app_method.dart';
import '../../../config/app_format.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/tip/tip_bloc.dart';
import '../../bloc/transaction_history/transaction_history_bloc.dart';
import '../../bloc/user/user_bloc.dart';
import '../../config/app_asset.dart';
import '../../config/app_color.dart';
import '../../data/model/auth_model/user_model.dart';
import '../../data/model/user_model/tip_model.dart';
import '../../presentation/page/more_service/package_data/service_data_page.dart';
import '../../presentation/page/profile_dashboard/profile_dashboard.dart';
import '../../presentation/page/top_up/top_up_page.dart';
import '../../presentation/page/transfer/transfer_page.dart';
import '../widget/latest_transaction_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            buildProfile(context),
            buildWallet(),
            buildLevel(),
            buildService(context),
            buildLatestTransaction(),
            buildSendAgain(),
            buildFriendlyTips(),
            const SizedBox(height: 70),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        color: AppColor.whiteColor,
        notchMargin: 6,
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          backgroundColor: AppColor.whiteColor,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: AppColor.blueTextStyle.copyWith(
            fontSize: 10,
            fontWeight: AppColor.medium,
          ),
          unselectedLabelStyle: AppColor.blackTextStyle.copyWith(
            fontSize: 10,
            fontWeight: AppColor.medium,
          ),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: AppColor.blueColor,
          unselectedItemColor: AppColor.blackColor,
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  AppAsset.icOverview,
                  width: 20,
                  color: AppColor.blueColor,
                ),
                label: 'Overview'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  AppAsset.icHistory,
                  width: 20,
                ),
                label: 'History'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  AppAsset.icStatistic,
                  width: 20,
                ),
                label: 'Statistic'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  AppAsset.icRewards,
                  width: 20,
                ),
                label: 'Rewards'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.purpleColor,
        child: Image.asset(
          AppAsset.icPlus,
          width: 24,
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildProfile(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 32),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Howdy,',
                      style: AppColor.greyTextStyle.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      AppMethod.toUpper(state.user.name!),
                      style: AppColor.blackTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: AppColor.semiBold,
                      ),
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, ProfileDashboardPage.routeName);
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: (state.user.profilePicture!.isEmpty)
                              ? const AssetImage(AppAsset.imgProfile)
                              : NetworkImage(
                                  state.user.profilePicture.toString(),
                                ) as ImageProvider,
                          fit: BoxFit.cover),
                    ),
                    child: (state.user.verified == 1)
                        ? Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              width: 17,
                              height: 17,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.whiteColor,
                              ),
                              child: Image.asset(
                                AppAsset.icCheck,
                                width: 14,
                                height: 14,
                              ),
                            ),
                          )
                        : Container(),
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget buildWallet() {
    return Container(
      margin: const EdgeInsets.only(top: 32),
      padding: const EdgeInsets.all(30),
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            AppAsset.imgBgCard,
          ),
        ),
      ),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppMethod.toUpper(state.user.name!),
                  style: AppColor.whiteTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: AppColor.medium,
                  ),
                ),
                Text(
                  '**** **** **** ${state.user.cardNumber!.substring(12, 16)}',
                  style: AppColor.whiteTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: AppColor.medium,
                    wordSpacing: 10,
                    letterSpacing: 3,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Balance',
                      style: AppColor.whiteTextStyle,
                    ),
                    Text(
                      AppFormat.formatCurrency(state.user.balance!),
                      style: AppColor.whiteTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: AppColor.semiBold,
                      ),
                    )
                  ],
                )
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget buildLevel() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Level 1',
                style: AppColor.blackTextStyle.copyWith(
                  fontWeight: AppColor.medium,
                ),
              ),
              Row(
                children: [
                  Text(
                    '55 % ',
                    style: AppColor.greenTextStyle.copyWith(
                      fontWeight: AppColor.medium,
                    ),
                  ),
                  Text(
                    'of Rp 20.000',
                    style: AppColor.blackTextStyle.copyWith(
                      fontWeight: AppColor.medium,
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          const LinearProgressIndicator(
            value: 0.55,
            backgroundColor: AppColor.lightBgColor,
            color: AppColor.greenColor,
          ),
        ],
      ),
    );
  }

  Widget buildService(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Do Something',
            style: AppColor.blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: AppColor.semiBold,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ServiceItem(
                image: AppAsset.icTopup,
                title: 'Top Up',
                onTap: () {
                  Navigator.pushNamed(context, TopUpPage.routeName);
                },
              ),
              ServiceItem(
                image: AppAsset.icSend,
                title: 'Send',
                onTap: () {
                  Navigator.pushNamed(context, TransferPage.routeName);
                },
              ),
              ServiceItem(
                image: AppAsset.icWithdraw,
                title: 'Withdraw',
                onTap: () {},
              ),
              ServiceItem(
                image: AppAsset.icMore,
                title: 'More',
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => const MoreDialog());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildLatestTransaction() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: BlocBuilder<TransactionHistoryBloc, TransactionHistoryState>(
        builder: (context, state) {
          if (state is TransactionHistorySuccess) {
            var index = 0;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Latest Transaction',
                  style: AppColor.blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: AppColor.semiBold,
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColor.whiteColor,
                  ),
                  child: (state.data.length >= 5)
                      ? Column(
                          children: [
                            Column(
                              children: state.data.take(5).map((item) {
                                index++;
                                return Container(
                                  margin: EdgeInsets.only(
                                      top: (index != 1) ? 18 : 0),
                                  child:
                                      LatestTransactionItem(transaction: item),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 18),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomTextButton(
                                  title: 'See All',
                                  width: 100,
                                  onPressed: () {
                                    Navigator.pushNamed(context,
                                        TransactionHistoryPage.routeName);
                                  },
                                ),
                              ],
                            ),
                          ],
                        )
                      : Column(
                          children: state.data.map((item) {
                            index++;
                            return Container(
                              margin:
                                  EdgeInsets.only(top: (index != 1) ? 18 : 0),
                              child: LatestTransactionItem(transaction: item),
                            );
                          }).toList(),
                        ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget buildSendAgain() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: BlocProvider(
        create: (context) => UserBloc()..add(UserGetRecent()),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Send Again',
                    style: AppColor.blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: AppColor.semiBold,
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 120,
                    width: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: state.user.map((user) {
                        return SendAgainItem(user: user);
                      }).toList(),
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget buildFriendlyTips() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 30),
      child: BlocBuilder<TipBloc, TipState>(
        builder: (context, state) {
          if (state is TipSuccess) {
            if (state.tips.isEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Friendly Tips',
                    style: AppColor.blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: AppColor.semiBold,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'RESPONSE BACK END EMPTY',
                    style: AppColor.blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: AppColor.medium,
                    ),
                  ),
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Friendly Tips',
                  style: AppColor.blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: AppColor.semiBold,
                  ),
                ),
                const SizedBox(height: 14),
                Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    runSpacing: 18,
                    children: state.tips.map((tip) {
                      return GestureDetector(
                        onTap: () async {
                          try {
                            await launchUrl(Uri.parse(tip.url!));
                          } catch (e) {
                            AppMethod.showCustomSnackbar(context, 'Error : $e');
                          }
                        },
                        child: FriendlyTipsItem(tip: tip),
                      );
                    }).toList()),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}

// CUSTOM WIDGET ======================== CUSTOM WIDGET =========
// CUSTOM WIDGET ======================== CUSTOM WIDGET =========

class ServiceItem extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;
  const ServiceItem({
    Key? key,
    required this.image,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(image),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppColor.blackTextStyle.copyWith(
              fontWeight: AppColor.medium,
            ),
          )
        ],
      ),
    );
  }
}

class MoreDialog extends StatelessWidget {
  const MoreDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return AlertDialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      alignment: Alignment.bottomCenter,
      content: Container(
        height: 330,
        width: width,
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: AppColor.lightBgColor,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Do More With Us',
              style: AppColor.blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: AppColor.semiBold,
              ),
            ),
            const SizedBox(height: 13),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ServiceItem(
                  image: AppAsset.icProductData,
                  title: 'Data',
                  onTap: () {
                    Navigator.pushNamed(context, ServiceDataPage.routeName);
                  },
                ),
                ServiceItem(
                  image: AppAsset.icProductWater,
                  title: 'Water',
                  onTap: () {},
                ),
                ServiceItem(
                  image: AppAsset.icProductStream,
                  title: 'Stream',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 29),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ServiceItem(
                  image: AppAsset.icProductMovie,
                  title: 'Movie',
                  onTap: () {},
                ),
                ServiceItem(
                  image: AppAsset.icProductFood,
                  title: 'Food',
                  onTap: () {},
                ),
                ServiceItem(
                  image: AppAsset.icProductTravel,
                  title: 'Travel',
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SendAgainItem extends StatelessWidget {
  final UserModel user;
  const SendAgainItem({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 90,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: (user.profilePicture != null)
                    ? NetworkImage(
                        user.profilePicture.toString(),
                      )
                    : const AssetImage(AppAsset.imgProfile) as ImageProvider,
              ),
            ),
          ),
          const SizedBox(height: 13),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  user.name.toString(),
                  style: AppColor.blackTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: AppColor.medium,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class FriendlyTipsItem extends StatelessWidget {
  final TipModel tip;
  const FriendlyTipsItem({
    Key? key,
    required this.tip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 155,
        height: 176,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Image.network(
                tip.thumbnail.toString(),
                height: 110,
                width: 155,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 12,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      tip.title.toString(),
                      style: AppColor.blackTextStyle.copyWith(
                        fontWeight: AppColor.medium,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
