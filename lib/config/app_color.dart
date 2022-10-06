import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColor {
  static const lightBgColor = Color(0xffF1F1F9);
  static const darkBgColor =  Color(0xff020518);
  static const whiteColor =  Color(0xffFFFFFF);
  static const blueColor =  Color(0xff53C1F9);
  static const purpleColor =  Color(0xff5142E6);
  static const greenColor =  Color(0xff22B07D);
  static const numberBgColor =  Color(0xff1A1D2E);
  static const blackColor =  Color(0xff14193F);
  static const greyColor =  Color(0xffA4A8AE);
  static const redColor =  Color(0xffFF2566);

  static var blackTextStyle = GoogleFonts.poppins(color: blackColor);
  static var whiteTextStyle = GoogleFonts.poppins(color: whiteColor);
  static var greyTextStyle = GoogleFonts.poppins(color: greyColor);
  static var greenTextStyle = GoogleFonts.poppins(color: greenColor);
  static var blueTextStyle = GoogleFonts.poppins(color: blueColor);

  static var light = FontWeight.w300;
  static var normal = FontWeight.w400;
  static var medium = FontWeight.w500;
  static var semiBold = FontWeight.w600;
  static var bold = FontWeight.w700;
  static var extraBold = FontWeight.w800;
}
