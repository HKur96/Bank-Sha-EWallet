part of 'top_up_bloc.dart';

abstract class TopUpEvent extends Equatable {
  const TopUpEvent();

  @override
  List<Object> get props => [];
}

class TopUpPost extends TopUpEvent {
  final TopUpFormModel data;
  const TopUpPost(this.data);
  @override
  List<Object> get props => [data];
}
