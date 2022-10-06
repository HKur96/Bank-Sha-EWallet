import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../../config/app_method.dart';
import '../../../data/model/auth_model/sign_up_form_model.dart';
import '../../../config/app_asset.dart';
import '../../../config/app_color.dart';
import '../../page/auth/sign_up_success_page.dart';
import '../../widget/custom_button.dart';

class SignUpUploadKTP extends StatefulWidget {
  final SignUpFormModel data;
  const SignUpUploadKTP({
    Key? key,
    required this.data,
  }) : super(key: key);
  // static const routeName = '/sign-up-upload-ktp';

  @override
  State<SignUpUploadKTP> createState() => _SignUpUploadKTPState();
}

class _SignUpUploadKTPState extends State<SignUpUploadKTP> {
  XFile? selectedImage;

  bool validate() {
    if (selectedImage == null) {
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
                context, SignUpSuccessPage.routeName, (route) => false);
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
                'Verify Your\nAccount',
                style: AppColor.blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: AppColor.semiBold,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // BUTTON UPLOAD
                    InkWell(
                      onTap: () async {
                        final image = await AppMethod.selectImage();
                        setState(() {
                          selectedImage = image;
                        });
                      },
                      child: Container(
                        width: 120,
                        height: 120,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: AppColor.lightBgColor,
                          shape: BoxShape.circle,
                          image: (selectedImage != null)
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(
                                    File(selectedImage!.path),
                                  ),
                                )
                              : null,
                        ),
                        child: (selectedImage == null)
                            ? Center(
                                child: Image.asset(AppAsset.icUpload),
                              )
                            : null,
                      ),
                    ),
                    Text(
                      'Passport/ID Card',
                      style: AppColor.blackTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: AppColor.medium,
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomFilledButton(
                      title: 'Continue',
                      width: double.infinity,
                      onPressed: () {
                        if (validate()) {
                          context.read<AuthBloc>().add(
                                AuthRegister(
                                  widget.data.copyWith(
                                    ktp:
                                        'data:image/png;base64,${base64Encode(File(selectedImage!.path).readAsBytesSync())}',
                                  ),
                                ),
                              );
                        } else {
                          AppMethod.showCustomSnackbar(
                              context, 'Gambar harus diisi');
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              CustomTextButton(
                title: 'Skip for Now',
                width: double.infinity,
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, SignUpSuccessPage.routeName, (route) => false);
                },
              ),
              const SizedBox(height: 50),
            ],
          );
        },
      ),
    );
  }
}
