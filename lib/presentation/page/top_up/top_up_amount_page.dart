import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

import '../../../data/model/transaction_model/top_up_form_model.dart';
import '../../../config/app_method.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../bloc/top_up/top_up_bloc.dart';
import '../../../data/model/transaction_model/payment_method_model.dart';
import '../../../config/app_asset.dart';
import '../../../config/app_color.dart';
import '../../../presentation/page/pin_page.dart';
import '../../../presentation/page/top_up/top_up_success_page.dart';
import '../../../presentation/widget/custom_button.dart';

class TopUpAmountPage extends StatefulWidget {
  final PaymentMethodModel data;
  const TopUpAmountPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<TopUpAmountPage> createState() => _TopUpAmountPageState();
}

class _TopUpAmountPageState extends State<TopUpAmountPage> {
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
      /// untuk mengambil data pin dari AuthSuccess
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
          create: (context) => TopUpBloc(),
          child: BlocConsumer<TopUpBloc, TopUpState>(
            listener: (context, state) async {
              if (state is TopUpFailed) {
                /// state jika top up gagal
                AppMethod.showCustomSnackbar(context, state.e);
              }

             if (state is TopUpSuccess) {
                /// state jika top up success,
                /// dan akan dinavigasikan ke website midtrans
                /// dan akan menjalankan event AuthUpdateBalance
                /// untuk mengupdate balance di AuthSuccess
                final url = Uri.parse(state.url);
                try {
                  await launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                  ).then((_) {
                    
                    Navigator.pushNamedAndRemoveUntil(
                        context, TopUpSuccessPage.routeName, (route) => false);
                    context.read<AuthBloc>().add(
                          AuthUpdateBalance(
                            int.parse(
                              _amountController.text.replaceAll('.', ''),
                            ),
                          ),
                        );
                  });
                } catch (e) {
                  AppMethod.showCustomSnackbar(context, e.toString());
                }
              }
            },
            builder: (context, state) {
              if (state is TopUpLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                children: [
                  Text(
                    'Total Amount',
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
                        String pin = '';
                        final authState = context.read<AuthBloc>().state;
                        if (authState is AuthSuccess) {
                          pin = authState.user.pin!;
                        }
                        context.read<TopUpBloc>().add(
                              TopUpPost(
                                TopUpFormModel(
                                  amount: _amountController.text
                                      .replaceAll('.', ''),
                                  paymentMethodCode: widget.data.code,
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
