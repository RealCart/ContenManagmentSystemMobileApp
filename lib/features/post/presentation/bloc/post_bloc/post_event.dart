part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

final class SubmitGenerateEvent extends PostEvent {
  const SubmitGenerateEvent({
    required this.description,
    required this.hashtags,
  });

  final String description;
  final List<String> hashtags;

  @override
  List<Object?> get props => [description, hashtags];
}

final class ResetPostEvent extends PostEvent {
  const ResetPostEvent();
}

final class PickImageEvent extends PostEvent {
  const PickImageEvent({required this.source});

  final ImageSource source;

  @override
  List<Object?> get props => [source];
}

final class RemoveImageEvent extends PostEvent {
  const RemoveImageEvent();
}

final class ChangeCaptionSizeEvent extends PostEvent {
  const ChangeCaptionSizeEvent(this.size);

  final CaptionSize size;

  @override
  List<Object?> get props => [size];
}


