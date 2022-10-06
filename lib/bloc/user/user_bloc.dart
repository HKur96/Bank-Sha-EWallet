import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/auth_model/user_model.dart';
import '../../data/service/user_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is UserGetRecent) {
        try {
          emit(UserLoading());
          final user = await UserService.getRecentUser();
          emit(UserSuccess(user));
        } catch (e) {
          emit(UserFailed(e.toString()));
        }
      }

      if (event is UserGetByUsername) {
        try {
          emit(UserLoading());
          final user = await UserService.getUserByUsername(event.username);
          emit(UserSuccess(user));
        } catch (e) {
          emit(UserFailed(e.toString()));
        }
      }
    });
  }
}
