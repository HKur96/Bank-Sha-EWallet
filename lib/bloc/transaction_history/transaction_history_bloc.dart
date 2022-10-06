import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/transaction_model/transaction_history_model.dart';
import '../../data/service/transaction_service.dart';

part 'transaction_history_event.dart';
part 'transaction_history_state.dart';

class TransactionHistoryBloc
    extends Bloc<TransactionHistoryEvent, TransactionHistoryState> {
  TransactionHistoryBloc() : super(TransactionHistoryInitial()) {
    on<TransactionHistoryEvent>((event, emit) async {
      if (event is TransactionHistoryGet) {
        try {
          emit(TransactionHistoryLoading());

          final data = await TransactionService.getTransactionHistory();
          emit(TransactionHistorySuccess(data));
        } catch (e) {
          emit(TransactionHistoryFailed(e.toString()));
        }
      }
    });
  }
}
