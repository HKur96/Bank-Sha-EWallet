import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/app_method.dart';
import '../../../data/model/user_model/user_edit_form_model.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../presentation/page/profile_dashboard/update_profile_success_page.dart';
import '../../../config/app_color.dart';
import '../../../presentation/widget/custom_button.dart';
import '../../../presentation/widget/custom_form.dart';
import '../../widget/custom_password_field.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);
  static const routeName = '/edit-profile';

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _usernameController = TextEditingController(text: '');
  final _fullnameController = TextEditingController(text: '');
  final _emailController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      _usernameController.text = authState.user.username!;
      _fullnameController.text = authState.user.name!;
      _emailController.text = authState.user.email!;
      _passwordController.text = authState.user.password!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            /// state jika gagal edit profile
            AppMethod.showCustomSnackbar(context, state.e);
          }

          if (state is AuthSuccess) {
            /// state jika berhasil edit profile dan dinavigasikan ke success page
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
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    CustomTextField(
                      title: 'Username',
                      controller: _usernameController,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      title: 'Full Name',
                      controller: _fullnameController,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      title: 'Email Address',
                      controller: _emailController,
                    ),
                    const SizedBox(height: 16),
                    CustomPasswordField(
                      title: 'Password',
                      controller: _passwordController,
                    ),
                    const SizedBox(height: 30),
                    CustomFilledButton(
                      title: 'Update Now',
                      width: double.infinity,
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              AuthUpdateProfile(
                                UserEditFormModel(
                                  name: _fullnameController.text,
                                  username: _usernameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ),
                              ),
                            );
                      },
                    )
                  ],
                ),
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
    _usernameController;
    _fullnameController;
    _emailController;
    _passwordController;
    super.dispose();
  }
}
