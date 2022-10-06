import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../config/app_color.dart';

class AppMethod {
  static void showCustomSnackbar(BuildContext context, String message) {
    Flushbar(
      backgroundColor: AppColor.redColor,
      duration: const Duration(seconds: 2),
      message: message,
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  static Future<XFile?> selectImage() async {
    XFile? selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return selectedImage;
  }

// Function ini dibutuhkan untuk mengubah huruf depan menjadi kapital
  static String toUpper(String name) {
    List n = name.split(' ').map((item) {
      var x = item[0].toUpperCase();
      return x + item.substring(1, item.length);
    }).toList();
    return n.join(' ');
  }
}
