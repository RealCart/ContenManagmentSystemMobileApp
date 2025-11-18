part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

final class GetUserEvent extends HomeEvent {
  const GetUserEvent();

  @override
  List<Object> get props => [];
}

final class GetPostsEvent extends HomeEvent {
  const GetPostsEvent({this.completer});

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}

final class DeletePostEvent extends HomeEvent {
  const DeletePostEvent(this.id);

  final int id;

  @override
  List<Object?> get props => [id];
}
