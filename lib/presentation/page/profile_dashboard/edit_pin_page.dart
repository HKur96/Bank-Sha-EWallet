import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/user_model/user_pin_edit_form_model.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../config/app_method.dart';
import '../../../presentation/page/profile_dashboard/update_profile_success_page.dart';
import '../../../config/app_color.dart';
import '../../../presentation/widget/custom_button.dart';
import '../../../presentation/widget/custom_form.dart';

class EditPINPage extends StatefulWidget {
  const EditPINPage({Key? key}) : super(key: key);
  static const routeName = '/edit-pin';

  @override
  State<EditPINPage> createState() => _EditPINPageState();
}

class _EditPINPageState extends State<EditPINPage> {
  final _oldPinController = TextEditingController(text: '');
  final _newPinController = TextEditingController(text: '');

  bool validate() {
    if (_oldPinController.text.length != 6 ||
        _newPinController.text.length != 6) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit PIN'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            /// state jika gagal update pin
            AppMethod.showCustomSnackbar(context, state.e);
          }

          if (state is AuthSuccess) {
            /// state jika berhasil update pin dan dinavigasikan ke success page
            Navigator.pushNamedAndRemoveUntil(
                context, UpdateProfileSuccessPage.routeName, (route) => false);
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
              Container(
                margin: const EdgeInsets.only(top: 40),
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  children: [
                    CustomTextField(
                      title: 'Old PIN',
                      controller: _oldPinController,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      title: 'New PIN',
                      controller: _newPinController,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                    ),
                    const SizedBox(height: 26),
                    CustomFilledButton(
                      title: 'Update Now',
                      width: double.infinity,
                      onPressed: () {
                        if (validate()) {
                          context.read<AuthBloc>().add(
                                AuthUpdatePin(
                                  UserPinEditFormModel(
                                    previousPin: _oldPinController.text,
                                    newPin: _newPinController.text,
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
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _oldPinController;
    _newPinController;
    super.dispose();
  }
}
