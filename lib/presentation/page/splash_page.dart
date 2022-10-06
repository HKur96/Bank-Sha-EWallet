import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/page/auth/sign_in_page.dart';
import '../../presentation/page/home_page.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../config/app_color.dart';
import '../../config/app_asset.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);
  static const routeName = '/splash-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkBgColor,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          /*
          Diawal aplikasi dijalankan akan menjalankan 
          function untuk mengecek apakah ada data authentifikasi yang
          disimpan di local storage... AuthGetCurrentUser



          
           */

          /**
           * jika ada data maka akan dinavigasikan ke home page
           * 
           * 
           */
          if (state is AuthSuccess) {
            Timer(
              const Duration(seconds: 1),
              () {
                Navigator.pushNamedAndRemoveUntil(
                    context, HomePage.routeName, (route) => false);
              },
            );
          }
          /**
           * namun jika data kosong maka akan dinavigasikan ke Sign in page
           */
          if (state is AuthFailed) {
            Timer(
              const Duration(seconds: 1),
              () {
                Navigator.pushNamedAndRemoveUntil(
                    context, SignInPage.routeName, (route) => false);
              },
            );
          }
        },
        child: Center(
          child: Image.asset(
            AppAsset.logoDark,
            width: 155,
          ),
        ),
      ),
    );
  }
}
