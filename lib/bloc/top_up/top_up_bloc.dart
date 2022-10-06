import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/transaction_model/top_up_form_model.dart';
import '../../data/service/transaction_service.dart';

part 'top_up_event.dart';
part 'top_up_state.dart';

class TopUpBloc extends Bloc<TopUpEvent, TopUpState> {
  TopUpBloc() : super(TopUpInitial()) {
    on<TopUpEvent>((event, emit) async {
      if (event is TopUpPost) {
        try {
          emit(TopUpLoading());
          final url = await TransactionService.topUp(event.data);
          emit(TopUpSuccess(url));
        } catch (e) {
          emit(TopUpFailed(e.toString()));
        }
      }
    });
  }
}
