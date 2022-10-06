part of 'transaction_history_bloc.dart';

abstract class TransactionHistoryState extends Equatable {
  const TransactionHistoryState();

  @override
  List<Object> get props => [];
}

class TransactionHistoryInitial extends TransactionHistoryState {}

class TransactionHistoryLoading extends TransactionHistoryState {}

class TransactionHistoryFailed extends TransactionHistoryState {
  final String e;
  const TransactionHistoryFailed(this.e);
  @override
  List<Object> get props => [e];
}

class TransactionHistorySuccess extends TransactionHistoryState {
  final List<TransactionHistoryModel> data;
  const TransactionHistorySuccess(this.data);
  @override
  List<Object> get props => [data];
}
