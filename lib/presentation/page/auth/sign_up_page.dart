import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/auth_model/sign_up_form_model.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../config/app_method.dart';
import '../../../config/app_color.dart';
import '../../../presentation/page/auth/sign_in_page.dart';
import '../../../presentation/page/auth/sign_up_upload_pic.dart';
import '../../../presentation/widget/custom_button.dart';
import '../../../presentation/widget/custom_form.dart';
import '../../../config/app_asset.dart';
import '../../widget/custom_password_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static const routeName = '/sign-up-page';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController(text: '');
  final _emailController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');

  /// function ini untuk mem-validasi supaya data yang di-inputkan user tidak
  /// ada yang kosong

  bool validate() {
    if (_emailController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _passwordController.text.isEmpty) {
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

          if (state is AuthCheckEmailSuccess) {
            // Navigator.pushNamed(context, SignUpUploadPic.routeName);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignUpUploadPic(
                  data: SignUpFormModel(
                    name: _nameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                  ),
                ),
              ),
            );
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
                'Join Us to Unlock\nYour Growth',
                style: AppColor.blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: AppColor.semiBold,
                ),
              ),
              const SizedBox(height: 30),
              // FORM =======================================
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    // FULL NAME ===============================
                    CustomTextField(
                      title: 'Full Name',
                      controller: _nameController,
                    ),
                    const SizedBox(height: 16),
                    // EMAIL ADDRESS ===============================
                    CustomTextField(
                      title: 'Email Address',
                      controller: _emailController,
                    ),
                    const SizedBox(height: 16),
                    // PASSWORD =======================================
                    CustomPasswordField(
                      title: 'Password',
                      controller: _passwordController,
                      onEditingComplete: () {
                        if (validate()) {
                          context
                              .read<AuthBloc>()
                              .add(AuthCheckEmail(_emailController.text));
                        } else {
                          AppMethod.showCustomSnackbar(
                              context, 'Semua field harus diisi');
                        }
                      },
                    ),
                    const SizedBox(height: 30),
                    CustomFilledButton(
                      title: 'Continue',
                      width: double.infinity,
                      onPressed: () {
                        if (validate()) {
                          context
                              .read<AuthBloc>()
                              .add(AuthCheckEmail(_emailController.text));
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
                title: 'Sign In',
                width: double.infinity,
                onPressed: () {
                  Navigator.pushNamed(context, SignInPage.routeName);
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
    _nameController;
    _emailController;
    _passwordController;
    super.dispose();
  }
}
