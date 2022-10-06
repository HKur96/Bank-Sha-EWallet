import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/app_method.dart';
import '../../../../data/model/operator_card/operator_card_model.dart';
import '../../../../bloc/operator_card/operator_card_bloc.dart';
import '../../../../config/app_format.dart';
import '../../../../bloc/auth/auth_bloc.dart';
import '../../../../presentation/page/more_service/package_data/service_data_pulsa_page.dart';
import '../../../../presentation/widget/custom_button.dart';
import '../../../../config/app_asset.dart';
import '../../../../config/app_color.dart';

class ServiceDataPage extends StatefulWidget {
  const ServiceDataPage({Key? key}) : super(key: key);
  static const routeName = '/service-data';

  @override
  State<ServiceDataPage> createState() => _ServiceDataPageState();
}

class _ServiceDataPageState extends State<ServiceDataPage> {
  OperatorCardModel? selectedOperator;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beli Data'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          buildWallet(),
          buildSelectProvider(),
          const SizedBox(height: 70),
        ],
      ),
      floatingActionButton: (selectedOperator != null)
          ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomFilledButton(
                title: 'Continue',
                width: double.infinity,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ServiceDataPulsaPage(
                        data: selectedOperator!,
                      ),
                    ),
                  );
                },
              ),
            )
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildWallet() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            /// state untuk mengambil data dari AuthSuccess
            /// 
            /// 
            /// 
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'From Wallet',
                  style: AppColor.blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: AppColor.semiBold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Image.asset(
                      AppAsset.imgWallet,
                      width: 80,
                      height: 55,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.user.cardNumber!.replaceAllMapped(
                              RegExp(r".{4}"), (match) => "${match.group(0)} "),
                          style: AppColor.blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: AppColor.medium,
                          ),
                        ),
                        Text(
                          'Balance ${AppFormat.formatCurrency(state.user.balance!)}',
                          style: AppColor.greyTextStyle.copyWith(
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget buildSelectProvider() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: BlocBuilder<OperatorCardBloc, OperatorCardState>(
        builder: (context, state) {
          if (state is OperatorCardSuccess) {
            /// state untuk mengambil data Operator Card
            /// 
            /// 
            /// 
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Provider',
                  style: AppColor.blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: AppColor.semiBold,
                  ),
                ),
                const SizedBox(height: 14),
                Column(
                    children: state.operatorCards.map((item) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedOperator = item;
                      });
                    },
                    child: SelectProvideritem(
                      operatorCard: item,
                      isSelected: selectedOperator?.id == item.id,
                    ),
                  );
                }).toList()),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}

class SelectProvideritem extends StatelessWidget {
  final OperatorCardModel operatorCard;
  final bool isSelected;

  const SelectProvideritem({
    Key? key,
    required this.operatorCard,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      margin: const EdgeInsets.only(bottom: 18),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColor.whiteColor,
        border: Border.all(
          color: (isSelected) ? AppColor.blueColor : AppColor.whiteColor,
          width: 3,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            operatorCard.thumbnail.toString(),
            height: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                operatorCard.name.toString(),
                style: AppColor.blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: AppColor.medium,
                ),
              ),
              Text(
                AppMethod.toUpper(operatorCard.status.toString()),
                style: AppColor.greyTextStyle.copyWith(
                  fontSize: 12,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
