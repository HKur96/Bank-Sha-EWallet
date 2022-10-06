import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../config/app_asset.dart';
import '../../config/app_method.dart';
import '../../config/app_color.dart';
import '../widget/custom_button.dart';

class PINPage extends StatefulWidget {
  const PINPage({Key? key}) : super(key: key);
  static const routeName = '/pin-page';

  @override
  State<PINPage> createState() => _PINPageState();
}

class _PINPageState extends State<PINPage> {
  final _pinController = TextEditingController(text: '');
  bool isError = false;
  String pin = '';

  addPin(String number) {
    if (_pinController.text.length <= 6) {
      _pinController.text += number;
    }
    if (_pinController.text.length == 6) {
      if (_pinController.text == pin) {
        Navigator.pop(context, true);
      } else {
        setState(() {
          isError = true;
        });
        AppMethod.showCustomSnackbar(
            context, 'PIN yang anda masukkan salah. Silakan coba lagi.');
      }
    }
  }

  deletePin() {
    if (_pinController.text.isNotEmpty) {
      setState(() {
        isError = false;
      });
      _pinController.text =
          _pinController.text.substring(0, _pinController.text.length - 1);
    }
  }

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      pin = authState.user.pin!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkBgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Text(
                      'Enter Your PIN',
                      style: AppColor.whiteTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: AppColor.semiBold,
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        controller: _pinController,
                        obscureText: true,
                        obscuringCharacter: '*',
                        cursorColor: AppColor.greyColor,
                        enabled: false,
                        style: AppColor.whiteTextStyle.copyWith(
                          fontSize: 36,
                          fontWeight: AppColor.medium,
                          letterSpacing: 16,
                          color: (isError)
                              ? AppColor.redColor
                              : AppColor.whiteColor,
                        ),
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColor.greyColor,
                            ),
                          ),
                          disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColor.greyColor,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 7,
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  spacing: 40,
                  runSpacing: 40,
                  children: [
                    CustomCircleButton(
                      onTap: () {
                        addPin('1');
                      },
                      number: '1',
                    ),
                    CustomCircleButton(
                      onTap: () {
                        addPin('2');
                      },
                      number: '2',
                    ),
                    CustomCircleButton(
                      onTap: () {
                        addPin('3');
                      },
                      number: '3',
                    ),
                    CustomCircleButton(
                      onTap: () {
                        addPin('4');
                      },
                      number: '4',
                    ),
                    CustomCircleButton(
                      onTap: () {
                        addPin('5');
                      },
                      number: '5',
                    ),
                    CustomCircleButton(
                      onTap: () {
                        addPin('6');
                      },
                      number: '6',
                    ),
                    CustomCircleButton(
                      onTap: () {
                        addPin('7');
                      },
                      number: '7',
                    ),
                    CustomCircleButton(
                      onTap: () {
                        addPin('8');
                      },
                      number: '8',
                    ),
                    CustomCircleButton(
                      onTap: () {
                        addPin('9');
                      },
                      number: '9',
                    ),
                    const SizedBox(
                      height: 60,
                      width: 60,
                    ),
                    CustomCircleButton(
                      onTap: () {
                        addPin('0');
                      },
                      number: '0',
                    ),
                    GestureDetector(
                      onTap: () {
                        deletePin();
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.numberBgColor,
                        ),
                        child: Center(
                          child: Image.asset(
                            AppAsset.icArrowleft,
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pinController;
    super.dispose();
  }
}
