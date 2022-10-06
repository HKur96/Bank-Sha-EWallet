import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/transaction_model/transfer_form_model.dart';
import '../../../bloc/user/user_bloc.dart';
import '../../../data/model/auth_model/user_model.dart';
import '../../../presentation/page/transfer/transfer_amount_page.dart';
import '../../../config/app_asset.dart';
import '../../../config/app_color.dart';
import '../../../presentation/widget/custom_button.dart';
import '../../../presentation/widget/custom_form.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({Key? key}) : super(key: key);
  static const routeName = '/transfer-page';

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final _searchController = TextEditingController(text: '');

  UserModel? selectedUser;
  late UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = context.read<UserBloc>()..add(UserGetRecent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          CustomTextField(
            title: 'Search',
            controller: _searchController,
            onFieldSubmitted: (value) {
              if (value.isEmpty) {
                /// jika field kosong maka akan menjalankan UserGetRecent
                selectedUser = null;
                userBloc.add(UserGetRecent());
              } else {
                /// jika field tidak kosong maka akan menjalankan UserGetByUsername
                userBloc.add(UserGetByUsername(value));
              }
              setState(() {});
            },
          ),
          (_searchController.text.isEmpty)
              ? buildRecentUsers()
              : buildResultUser(),
          const SizedBox(height: 70),
        ],
      ),
      floatingActionButton: (selectedUser != null)
          ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomFilledButton(
                title: 'Continue',
                width: double.infinity,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransferAmountPage(
                        data: TransferFormModel(
                          sendTo: selectedUser!.username,
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildRecentUsers() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserSuccess) {
            /// untuk mengambil data dari UserGetRecent
            ///
            ///
            ///
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recent Users',
                  style: AppColor.blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: AppColor.semiBold,
                  ),
                ),
                const SizedBox(height: 14),
                (state.user.isNotEmpty)
                    ? Column(
                        children: state.user.map((user) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedUser = user;
                              });
                            },
                            child: RecentUsersItem(
                              user: user,
                              isSelected: selectedUser?.id == user.id,
                            ),
                          );
                        }).toList(),
                      )
                    : Center(
                        child: Text(
                          'Tidak ada data',
                          style: AppColor.blackTextStyle,
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

  Widget buildResultUser() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 40),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserSuccess) {
            /// untuk mengambil data dari UserGetByUsername
            ///
            ///
            ///
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Result',
                  style: AppColor.blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: AppColor.semiBold,
                  ),
                ),
                const SizedBox(height: 14),
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UserSuccess) {
                      return Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        spacing: 10,
                        runSpacing: 10,
                        children: state.user.map((user) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedUser = user;
                              });
                            },
                            child: ResultUserItem(
                              user: user,
                              isSelected: selectedUser?.id == user.id,
                            ),
                          );
                        }).toList(),
                      );
                    }
                    return Container();
                  },
                )
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController;
    super.dispose();
  }
}

// CUSTOM WIDGET ==================== CUSTOM WIDGET =================

class RecentUsersItem extends StatelessWidget {
  final UserModel user;
  final bool isSelected;

  const RecentUsersItem({
    Key? key,
    required this.user,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        border: Border.all(
          color: (isSelected) ? AppColor.blueColor : AppColor.whiteColor,
          width: 3,
        ),
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: (user.profilePicture!.isEmpty)
                    ? const AssetImage(AppAsset.imgProfile)
                    : NetworkImage(user.profilePicture!) as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
            child: (user.verified == 1)
                ? Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      AppAsset.icCheck,
                      width: 20,
                    ),
                  )
                : Container(),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name!,
                  style: AppColor.blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: AppColor.medium,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${user.username}',
                  style: AppColor.greyTextStyle.copyWith(
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ResultUserItem extends StatelessWidget {
  final UserModel user;
  final bool isSelected;
  const ResultUserItem({
    Key? key,
    required this.user,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 171,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 3,
          color: (isSelected) ? AppColor.blueColor : AppColor.whiteColor,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: (user.profilePicture!.isEmpty)
                    ? const AssetImage(AppAsset.imgProfile)
                    : NetworkImage(user.profilePicture!) as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
            child: (user.verified == 1)
                ? Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      AppAsset.icCheck,
                      width: 20,
                    ),
                  )
                : Container(),
          ),
          Column(
            children: [
              Text(
                '${user.name}',
                style: AppColor.blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: AppColor.medium,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                user.username!,
                style: AppColor.greyTextStyle.copyWith(
                  fontSize: 12,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ],
      ),
    );
  }
}
