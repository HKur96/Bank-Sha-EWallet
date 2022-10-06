import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/app_method.dart';
import '../../../data/model/auth_model/sign_in_form_model.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../presentation/page/home_page.dart';
import '../../../presentation/page/auth/sign_up_page.dart';
import '../../../presentation/widget/custom_button.dart';
import '../../../config/app_asset.dart';
import '../../../config/app_color.dart';
import '../../../presentation/widget/custom_form.dart';
import '../../widget/custom_password_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  static const routeName = '/sign-in-page';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');

  /// function ini untuk mem-validasi supaya data yang di-inputkan user tidak
  /// ada yang kosong

  bool validate() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            AppMethod.showCustomSnackbar(context, state.e);
          }
          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, HomePage.routeName, (route) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              const SizedBox(height: 100),
              Image.asset(
                AppAsset.logoLight,
                width: 155,
                height: 50,
              ),
              const SizedBox(height: 100),
              Text(
                'Sign In &\nGrow Your Finance',
                style: AppColor.blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: AppColor.semiBold,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                // FORM =============================
                child: Column(
                  children: [
                    // EMAIL FORM ========================================
                    CustomTextField(
                      title: 'Email Address',
                      controller: _emailController,
                    ),
                    const SizedBox(height: 16),
                    // PASSWORD FORM ========================================
                    CustomPasswordField(
                      title: 'Password',
                      controller: _passwordController,
                      onEditingComplete: () {
                        if (validate()) {
                          context.read<AuthBloc>().add(
                                AuthLogin(
                                  SignInFormModel(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  ),
                                ),
                              );
                        } else {
                          AppMethod.showCustomSnackbar(
                              context, 'Semua field harus diisi');
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: Text(
                            'Forgot Password',
                            style: AppColor.blueTextStyle,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    CustomFilledButton(
                      title: 'Sign In',
                      width: double.infinity,
                      onPressed: () {
                        if (validate()) {
                          context.read<AuthBloc>().add(
                                AuthLogin(
                                  SignInFormModel(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  ),
                                ),
                              );
                        } else {
                          AppMethod.showCustomSnackbar(
                              context, 'Semua field harus diisi');
                        }
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 50),
              CustomTextButton(
                title: 'Create New Account',
                width: double.infinity,
                onPressed: () {
                  Navigator.pushNamed(context, SignUpPage.routeName);
                },
              ),
              const SizedBox(height: 50),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController;
    _passwordController;
    super.dispose();
  }
}
