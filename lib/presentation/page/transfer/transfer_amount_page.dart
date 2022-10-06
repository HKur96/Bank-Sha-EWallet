import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../../config/app_method.dart';
import '../../../bloc/transfer/transfer_bloc.dart';
import '../../../data/model/transaction_model/transfer_form_model.dart';
import '../../../config/app_asset.dart';
import '../../../config/app_color.dart';
import '../../../presentation/page/transfer/transfer_success_page.dart';
import '../../widget/custom_button.dart';
import '../pin_page.dart';

class TransferAmountPage extends StatefulWidget {
  final TransferFormModel data;
  const TransferAmountPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<TransferAmountPage> createState() => _TransferAmountPageState();
}

class _TransferAmountPageState extends State<TransferAmountPage> {
  final _amountController = TextEditingController(text: '');

  addAmount(String number) {
    if (_amountController.text == '0') {
      _amountController.text = '';
    }
    setState(() {
      _amountController.text += number;
    });
  }

  deleteAmount() {
    if (_amountController.text.isNotEmpty) {
      setState(() {
        _amountController.text = _amountController.text
            .substring(0, _amountController.text.length - 1);
      });
    }
    if (_amountController.text == '') {
      _amountController.text = '0';
    }
  }

  @override
  void initState() {
    super.initState();
    _amountController.addListener(() {
      final text = _amountController.text;
      _amountController.value = _amountController.value.copyWith(
        text: NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0)
            .format(
          int.parse(
            text.replaceAll('.', ''),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkBgColor,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => TransferBloc(),
          child: BlocConsumer<TransferBloc, TransferState>(
            listener: (context, state) {
              if (state is TransferFailed) {
                /// state jika gagal transfer
                ///
                ///
                ///
                AppMethod.showCustomSnackbar(context, state.e);
              }

              if (state is TransferSuccess) {
                /// state jika berhasil transfer
                ///
                ///
                ///
                context.read<AuthBloc>().add(
                      AuthUpdateBalance(
                        int.parse(
                          _amountController.text.replaceAll('.', '') * -1,
                        ),
                      ),
                    );
                Navigator.pushNamedAndRemoveUntil(
                    context, TransferSuccessPage.routeName, (route) => false);
              }
            },
            builder: (context, state) {
              if (state is TransferLoading) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                children: [
                  Text(
                    'Enter Your PIN',
                    style: AppColor.whiteTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: AppColor.semiBold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _amountController,
                      cursorColor: AppColor.greyColor,
                      enabled: false,
                      style: AppColor.whiteTextStyle.copyWith(
                        fontSize: 30,
                        fontWeight: AppColor.medium,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Text(
                          'Rp ',
                          style: AppColor.whiteTextStyle.copyWith(
                            fontSize: 36,
                            fontWeight: AppColor.medium,
                          ),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.greyColor,
                          ),
                        ),
                        disabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.greyColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                  Wrap(
                    spacing: 40,
                    runSpacing: 40,
                    children: [
                      CustomCircleButton(
                        number: '1',
                        onTap: () {
                          addAmount('1');
                        },
                      ),
                      CustomCircleButton(
                        number: '2',
                        onTap: () {
                          addAmount('2');
                        },
                      ),
                      CustomCircleButton(
                        number: '3',
                        onTap: () {
                          addAmount('3');
                        },
                      ),
                      CustomCircleButton(
                        number: '4',
                        onTap: () {
                          addAmount('4');
                        },
                      ),
                      CustomCircleButton(
                        number: '5',
                        onTap: () {
                          addAmount('5');
                        },
                      ),
                      CustomCircleButton(
                        number: '6',
                        onTap: () {
                          addAmount('6');
                        },
                      ),
                      CustomCircleButton(
                        number: '7',
                        onTap: () {
                          addAmount('7');
                        },
                      ),
                      CustomCircleButton(
                        number: '8',
                        onTap: () {
                          addAmount('8');
                        },
                      ),
                      CustomCircleButton(
                        number: '9',
                        onTap: () {
                          addAmount('9');
                        },
                      ),
                      const SizedBox(
                        width: 60,
                        height: 60,
                      ),
                      CustomCircleButton(
                        number: '0',
                        onTap: () {
                          addAmount('0');
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          deleteAmount();
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: AppColor.numberBgColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Image.asset(
                              AppAsset.icArrowleft,
                              width: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  CustomFilledButton(
                    title: 'Checkout Now',
                    width: double.infinity,
                    onPressed: () async {
                      if (await Navigator.pushNamed(
                              context, PINPage.routeName) ==
                          true) {
                        /// untuk menjalankan event TransferPost
                        String pin = '';
                        final authState = context.read<AuthBloc>().state;
                        if (authState is AuthSuccess) {
                          pin = authState.user.pin!;
                        }
                        context.read<TransferBloc>().add(
                              TransferPost(
                                widget.data.copyWith(
                                  amount: _amountController.text
                                      .replaceAll('.', ''),
                                  pin: pin,
                                ),
                              ),
                            );
                      }
                    },
                  ),
                  const SizedBox(height: 25),
                  CustomTextButton(
                    title: 'Terms & Conditions',
                    width: double.infinity,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 25),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _amountController;
    super.dispose();
  }
}
