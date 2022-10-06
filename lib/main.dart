import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './bloc/operator_card/operator_card_bloc.dart';
import './presentation/page/transaction_history_page.dart';
import './bloc/transaction_history/transaction_history_bloc.dart';
import './bloc/tip/tip_bloc.dart';
import './bloc/user/user_bloc.dart';
import './bloc/payment_method/payment_method_bloc.dart';
import './bloc/auth/auth_bloc.dart';
import './presentation/page/more_service/package_data/service_data_success_page.dart';
import './presentation/page/more_service/package_data/service_data_page.dart';
import './presentation/page/transfer/transfer_page.dart';
import './presentation/page/transfer/transfer_success_page.dart';
import './presentation/page/profile_dashboard/edit_pin_page.dart';
import './presentation/page/top_up/top_up_page.dart';
import './presentation/page/top_up/top_up_success_page.dart';
import './presentation/page/pin_page.dart';
import './presentation/page/profile_dashboard/edit_profile_page.dart';
import './presentation/page/profile_dashboard/profile_dashboard.dart';
import './presentation/page/profile_dashboard/update_profile_success_page.dart';
import './presentation/page/home_page.dart';
import './presentation/page/auth/sign_up_success_page.dart';
import '../presentation/page/auth/sign_in_page.dart';
import '../presentation/page/auth/sign_up_page.dart';
import '../presentation/page/onboarding_page.dart';
import './config/app_color.dart';
import '../presentation/page/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AuthBloc()..add(AuthGetCurrentUser())),
        BlocProvider(
            create: (context) => PaymentMethodBloc()..add(PaymentMethodGet())),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => TipBloc()..add(TipGet())),
        BlocProvider(
            create: (context) =>
                TransactionHistoryBloc()..add(TransactionHistoryGet())),
        BlocProvider(
          create: (context) => OperatorCardBloc()..add(OperatorCardGet()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: AppColor.lightBgColor,
          appBarTheme: AppBarTheme(
            elevation: 0,
            iconTheme: const IconThemeData(color: AppColor.blackColor),
            backgroundColor: AppColor.lightBgColor,
            centerTitle: true,
            titleTextStyle: AppColor.blackTextStyle.copyWith(
              fontSize: 20,
              fontWeight: AppColor.semiBold,
            ),
          ),
        ),
        routes: {
          SplashPage.routeName: (context) => const SplashPage(),
          OnBoardingPage.routeName: (context) => const OnBoardingPage(),
          SignInPage.routeName: (context) => const SignInPage(),
          SignUpPage.routeName: (context) => const SignUpPage(),
          SignUpSuccessPage.routeName: (context) => const SignUpSuccessPage(),
          HomePage.routeName: (context) => const HomePage(),
          ProfileDashboardPage.routeName: (context) =>
              const ProfileDashboardPage(),
          PINPage.routeName: (context) => const PINPage(),
          EditProfilePage.routeName: (context) => const EditProfilePage(),
          UpdateProfileSuccessPage.routeName: (context) =>
              const UpdateProfileSuccessPage(),
          EditPINPage.routeName: (context) => const EditPINPage(),
          TopUpPage.routeName: (context) => const TopUpPage(),
          TopUpSuccessPage.routeName: (context) => const TopUpSuccessPage(),
          TransferPage.routeName: (context) => const TransferPage(),
          TransferSuccessPage.routeName: (context) =>
              const TransferSuccessPage(),
          ServiceDataPage.routeName: (context) => const ServiceDataPage(),
          ServiceDataSuccessPage.routeName: (context) =>
              const ServiceDataSuccessPage(),
          TransactionHistoryPage.routeName: (context) =>
              const TransactionHistoryPage(),
        },
        initialRoute: SplashPage.routeName,
      ),
    );
  }
}
