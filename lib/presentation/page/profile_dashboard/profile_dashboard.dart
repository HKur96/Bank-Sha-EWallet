import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/app_method.dart';
import '../../../presentation/page/auth/sign_in_page.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../presentation/page/pin_page.dart';
import '../../../presentation/page/profile_dashboard/edit_pin_page.dart';
import '../../../presentation/page/profile_dashboard/edit_profile_page.dart';
import '../../../presentation/widget/custom_button.dart';
import '../../../config/app_asset.dart';
import '../../../config/app_color.dart';

class ProfileDashboardPage extends StatelessWidget {
  const ProfileDashboardPage({Key? key}) : super(key: key);
  static const routeName = '/profile-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            /// state jika gagal logout
            AppMethod.showCustomSnackbar(context, state.e);
          }

          if (state is AuthInitial) {
            /// jika berhasil logout akan dinaviasikan ke sign in page
            Navigator.pushNamedAndRemoveUntil(
                context, SignInPage.routeName, (route) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthSuccess) {
            /// state untuk mengambil data dari authSuccess. 
            /// Untuk mengubah foto profile dan nama user
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 40),
                  padding: const EdgeInsets.symmetric(
                    vertical: 22,
                    horizontal: 30,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      // PROFILE PICTURE ============================

                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: (state.user.profilePicture == null)
                                  ? const AssetImage(
                                      AppAsset.imgProfile,
                                    )
                                  : NetworkImage(state.user.profilePicture!)
                                      as ImageProvider,
                              fit: BoxFit.cover),
                        ),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 27,
                            height: 27,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.whiteColor,
                            ),
                            child: Image.asset(
                              AppAsset.icCheck,
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        AppMethod.toUpper(state.user.name!),
                        style: AppColor.blackTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: AppColor.medium,
                        ),
                      ),
                      const SizedBox(height: 40),
                      ProfileServiceItem(
                        image: AppAsset.icEditProfile,
                        title: 'Edit Profile',
                        onTap: () async {
                          if (await Navigator.pushNamed(
                                  context, PINPage.routeName) ==
                              true) {
                            Navigator.pushNamed(
                                context, EditProfilePage.routeName);
                          }
                        },
                      ),
                      const SizedBox(height: 32),
                      ProfileServiceItem(
                        image: AppAsset.icPin,
                        title: 'My PIN',
                        onTap: () async {
                          if (await Navigator.pushNamed(
                                  context, PINPage.routeName) ==
                              true) {
                            Navigator.pushNamed(context, EditPINPage.routeName);
                          }
                        },
                      ),
                      const SizedBox(height: 32),
                      ProfileServiceItem(
                        image: AppAsset.icWallet,
                        title: 'Wallet Settings',
                        onTap: () {},
                      ),
                      const SizedBox(height: 32),
                      ProfileServiceItem(
                        image: AppAsset.icRewards,
                        title: 'My Rewards',
                        onTap: () {},
                      ),
                      const SizedBox(height: 32),
                      ProfileServiceItem(
                        image: AppAsset.icHelp,
                        title: 'Help Center',
                        onTap: () {},
                      ),
                      const SizedBox(height: 32),
                      ProfileServiceItem(
                        image: AppAsset.icLogout,
                        title: 'Log Out',
                        onTap: () {
                          context.read<AuthBloc>().add(AuthLogout());
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 87),
                CustomTextButton(
                  title: 'Report a Problem',
                  width: double.infinity,
                  onPressed: () {},
                ),
                const SizedBox(height: 50),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}

class ProfileServiceItem extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;
  const ProfileServiceItem({
    Key? key,
    required this.image,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(
            image,
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 18),
          Text(
            title,
            style: AppColor.blackTextStyle,
          ),
        ],
      ),
    );
  }
}
