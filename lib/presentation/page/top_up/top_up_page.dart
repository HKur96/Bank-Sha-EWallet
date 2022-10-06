import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../../bloc/payment_method/payment_method_bloc.dart';
import '../../../config/app_asset.dart';
import '../../../config/app_color.dart';
import '../../../config/app_method.dart';
import '../../../data/model/transaction_model/payment_method_model.dart';
import '../../../presentation/page/top_up/top_up_amount_page.dart';
import '../../../presentation/widget/custom_button.dart';

class TopUpPage extends StatefulWidget {
  const TopUpPage({Key? key}) : super(key: key);
  static const routeName = '/top-up';

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  PaymentMethodModel? selectedPaymentMethod;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Up'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          buildWallet(),
          buildSelectBank(),
        ],
      ),
      floatingActionButton: (selectedPaymentMethod != null)
          ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomFilledButton(
                title: 'Continue',
                width: double.infinity,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TopUpAmountPage(
                        data: selectedPaymentMethod!,
                      ),
                    ),
                  );
                },
              ),
            )
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildWallet() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            /// untuk mengambil data dari AuthSuccess
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wallet',
                  style: AppColor.blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: AppColor.semiBold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Image.asset(
                      AppAsset.imgWallet,
                      width: 80,
                      height: 55,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.user.cardNumber!.replaceAllMapped(
                              RegExp(r".{4}"), (match) => "${match.group(0)} "),
                          style: AppColor.blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: AppColor.medium,
                          ),
                        ),
                        Text(
                          AppMethod.toUpper(state.user.name!),
                          style: AppColor.greyTextStyle.copyWith(
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget buildSelectBank() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: BlocConsumer<PaymentMethodBloc, PaymentMethodState>(
        listener: (context, state) {
          if (state is PaymentMethodFailed) {
            /// state jika gagal mengambil data payment method
            AppMethod.showCustomSnackbar(context, state.e);
          }
        },
        builder: (context, state) {
          if (state is PaymentMethodSuccess) {
            /// state jika success mengambil data payment method
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Bank',
                  style: AppColor.blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: AppColor.semiBold,
                  ),
                ),
                const SizedBox(height: 14),
                Column(
                  children: state.data.map((paymentMethod) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPaymentMethod = paymentMethod;
                        });
                      },
                      child: TopUpSelectItem(
                        image: paymentMethod.thumbnail!,
                        title: paymentMethod.name!,
                        subtitle: paymentMethod.status!,
                        code: paymentMethod.code!,
                        isSelected:
                            selectedPaymentMethod?.id == paymentMethod.id,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 100),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}

// CUSTOM WIDGET ======================= CUSTOM WIDGET ============

class TopUpSelectItem extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String code;
  final bool isSelected;

 const TopUpSelectItem({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.code,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Function ini dibutuhkan jika data thumbnail dari Backend kosong
    String selectImage(String code) {
      if (code == 'bni_va') {
        return AppAsset.imgBankBNI;
      } else if (code == 'bca_va') {
        return AppAsset.imgBankBCA;
      } else {
        return AppAsset.imgBankBRI;
      }
    }

    return Container(
      padding: const EdgeInsets.all(22),
      margin: const EdgeInsets.only(bottom: 18),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColor.whiteColor,
        border: Border.all(
          color: (isSelected) ? AppColor.blueColor : AppColor.whiteColor,
          width: 3,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          (image.isEmpty)
              ? Image.asset(
                  selectImage(code),
                  height: 30,
                )
              : Image.network(image),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title,
                style: AppColor.blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: AppColor.medium,
                ),
              ),
              Text(
                AppMethod.toUpper(subtitle),
                style: AppColor.greyTextStyle.copyWith(
                  fontSize: 12,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
