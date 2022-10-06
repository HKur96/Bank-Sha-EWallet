import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../config/app_method.dart';
import '../../../data/model/auth_model/sign_up_form_model.dart';
import '../../../config/app_asset.dart';
import '../../../config/app_color.dart';
import '../../../presentation/page/auth/sign_up_upload_ktp.dart';
import '../../../presentation/widget/custom_button.dart';
import '../../../presentation/widget/custom_form.dart';

class SignUpUploadPic extends StatefulWidget {
  final SignUpFormModel data;
  const SignUpUploadPic({
    Key? key,
    required this.data,
  }) : super(key: key);
  // static const routeName = '/sign-up-upload-pic';

  @override
  State<SignUpUploadPic> createState() => _SignUpUploadPicState();
}

class _SignUpUploadPicState extends State<SignUpUploadPic> {
  XFile? selectedImage;
  final _pinController = TextEditingController(text: '');

  bool validate() {
    if (_pinController.text.length != 6) {
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    _pinController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
                  widget.data.name.toString(),
                  style: AppColor.blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: AppColor.medium,
                  ),
                ),
                const SizedBox(height: 30),
                // SET PIN ================================
                CustomTextField(
                  title: 'Set PIN (6 digit number)',
                  controller: _pinController,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                CustomFilledButton(
                  title: 'Continue',
                  width: double.infinity,
                  onPressed: () {
                    if (validate()) {
                      // Navigator.pushNamed(context, SignUpUploadKTP.routeName);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpUploadKTP(
                            data: widget.data.copyWith(
                              pin: _pinController.text,
                              profilePicture: (selectedImage != null)?
                                  'data:image/png;base64,${base64Encode(File(selectedImage!.path).readAsBytesSync())}' : null,
                            ),
                          ),
                        ),
                      );
                    } else {
                      AppMethod.showCustomSnackbar(
                          context, 'PIN harus 6 digit');
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
