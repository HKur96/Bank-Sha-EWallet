import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/app_method.dart';
import '../../../../data/model/operator_card/data_plan_form_model.dart';
import '../../../../bloc/auth/auth_bloc.dart';
import '../../../../bloc/data_plan/data_plan_bloc.dart';
import '../../../../config/app_format.dart';
import '../../../../data/model/operator_card/data_plan_model.dart';
import '../../../../data/model/operator_card/operator_card_model.dart';
import '../../../../config/app_color.dart';
import '../../../../presentation/page/more_service/package_data/service_data_success_page.dart';
import '../../../../presentation/widget/custom_button.dart';
import '../../../../presentation/widget/custom_form.dart';
import '../../pin_page.dart';

class ServiceDataPulsaPage extends StatefulWidget {
  final OperatorCardModel data;
  const ServiceDataPulsaPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<ServiceDataPulsaPage> createState() => _ServiceDataPulsaPageState();
}

class _ServiceDataPulsaPageState extends State<ServiceDataPulsaPage> {
  DataPlanModel? selectedDataPlan;
  final _phoneNumberController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataPlanBloc(),
      child: BlocConsumer<DataPlanBloc, DataPlanState>(
        listener: (context, state) {
          if (state is DataPlanFailed) {
            AppMethod.showCustomSnackbar(context, state.e);
          }

          if (state is DataPlanSuccess) {
            context
                .read<AuthBloc>()
                .add(AuthUpdateBalance(selectedDataPlan!.price! * -1));
            Navigator.pushNamedAndRemoveUntil(
                context, ServiceDataSuccessPage.routeName, (route) => false);
          }
        },
        builder: (context, state) {
          if (state is DataPlanLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('Paket Data'),
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                const SizedBox(height: 30),
                CustomTextField(
                  title: 'Phone Number',
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.number,
                  hintText: '08',
                ),
                const SizedBox(height: 40),
                Text(
                  'Select Package',
                  style: AppColor.blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: AppColor.semiBold,
                  ),
                ),
                const SizedBox(height: 14),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 18,
                  children: widget.data.dataPlans!.map((dataPlan) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDataPlan = dataPlan;
                        });
                      },
                      child: SelectPackageItem(
                        dataPlan: dataPlan,
                        isSelected: selectedDataPlan?.id == dataPlan.id,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 100),
              ],
            ),
            floatingActionButton: (selectedDataPlan != null &&
                    _phoneNumberController.text.isNotEmpty)
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    child: CustomFilledButton(
                      title: 'Continue',
                      width: double.infinity,
                      onPressed: () async {
                        if (await Navigator.pushNamed(
                                context, PINPage.routeName) ==
                            true) {
                          String pin = '';
                          final authState = context.read<AuthBloc>().state;
                          if (authState is AuthSuccess) {
                            pin = authState.user.pin!;
                          }
                          context.read<DataPlanBloc>().add(
                                DataPlanPost(
                                  DataPlanFormModel(
                                    dataPlanId: selectedDataPlan!.id,
                                    phoneNumber: _phoneNumberController.text,
                                    pin: pin,
                                  ),
                                ),
                              );
                        }
                      },
                    ),
                  )
                : Container(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _phoneNumberController;
    super.dispose();
  }
}

class SelectPackageItem extends StatelessWidget {
  final DataPlanModel dataPlan;
  final bool isSelected;

  const SelectPackageItem({
    Key? key,
    required this.dataPlan,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 151,
      padding: const EdgeInsets.symmetric(vertical: 50),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 3,
          color: (isSelected) ? AppColor.blueColor : AppColor.whiteColor,
        ),
      ),
      child: Column(
        children: [
          Text(
            dataPlan.name!,
            style: AppColor.blackTextStyle.copyWith(
              fontSize: 32,
              fontWeight: AppColor.medium,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            AppFormat.formatCurrency(dataPlan.price!),
            style: AppColor.greyTextStyle.copyWith(
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
