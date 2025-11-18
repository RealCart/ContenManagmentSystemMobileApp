part of 'preview_bloc.dart';

sealed class PreviewEvent extends Equatable {
  const PreviewEvent();

  @override
  List<Object?> get props => [];
}

final class SavePostEvent extends PreviewEvent {
  const SavePostEvent(this.entity);

  final GeneratedPostEntity entity;

  @override
  List<Object?> get props => [entity];
}


