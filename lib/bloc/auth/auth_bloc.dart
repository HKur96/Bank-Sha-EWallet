import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/user_model/user_pin_edit_form_model.dart';
import '../../data/model/user_model/user_edit_form_model.dart';
import '../../data/service/user_service.dart';
import '../../data/model/auth_model/sign_in_form_model.dart';
import '../../data/model/auth_model/sign_up_form_model.dart';
import '../../data/model/auth_model/user_model.dart';
import '../../data/service/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthCheckEmail) {
        try {
          emit(AuthLoading());

          final res = await AuthService.checkEmail(event.email);
          if (res == false) {
            emit(AuthCheckEmailSuccess());
          } else {
            emit(const AuthFailed('Email sudah terpakai'));
          }
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthRegister) {
        try {
          emit(AuthLoading());

          final user = await AuthService.register(event.data);
          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthLogin) {
        try {
          emit(AuthLoading());
          final user = await AuthService.login(event.data);
          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthGetCurrentUser) {
        try {
          emit(AuthLoading());

          final data = await AuthService.getCredentialFromLocal();
          final user = await AuthService.login(data);
          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthUpdateProfile) {
        try {
          if (state is AuthSuccess) {
            final updatedUser = (state as AuthSuccess).user.copyWith(
                  name: event.data.name,
                  username: event.data.username,
                  email: event.data.email,
                  password: event.data.password,
                );
            emit(AuthLoading());
            await UserService.updateProfile(event.data);
            emit(AuthSuccess(updatedUser));
          }
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthUpdatePin) {
        try {
          if (state is AuthSuccess) {
            final updatedPin =
                (state as AuthSuccess).user.copyWith(pin: event.data.newPin);
            emit(AuthLoading());
            await UserService.updatePin(event.data);
            emit(AuthSuccess(updatedPin));
          }
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthLogout) {
        try {
          emit(AuthLoading());
          await AuthService.logout();
          emit(AuthInitial());
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthUpdateBalance) {
        final currentBalance = (state as AuthSuccess).user;
        final updatedBalance = currentBalance.copyWith(
          balance: currentBalance.balance! + event.amount,
        );
        emit(AuthSuccess(updatedBalance));
      }
    });
  }
}
