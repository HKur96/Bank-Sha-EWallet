part of 'top_up_bloc.dart';

abstract class TopUpState extends Equatable {
  const TopUpState();

  @override
  List<Object> get props => [];
}

class TopUpInitial extends TopUpState {}

class TopUpLoading extends TopUpState {}

class TopUpFailed extends TopUpState {
  final String e;
  const TopUpFailed(this.e);
  @override
  List<Object> get props => [e];
}

class TopUpSuccess extends TopUpState {
  final String url;
  const TopUpSuccess(this.url);
  @override
  List<Object> get props => [url];
}
