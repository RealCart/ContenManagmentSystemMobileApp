part of 'post_bloc.dart';

enum CaptionSize { short, medium, long }

@immutable
class PostState extends Equatable {
  const PostState({
    this.status = Status.initial,
    this.error,
    this.result,
    this.photo,
    this.captionSize = CaptionSize.medium,
  });

  final Status status;
  final Failure? error;
  final GeneratedPostEntity? result;
  final File? photo;
  final CaptionSize captionSize;

  PostState copyWith({
    Status? status,
    Failure? error,
    GeneratedPostEntity? result,
    File? photo,
    CaptionSize? captionSize,
    bool resetPhoto = false,
    bool resetError = false,
    }) {
    return PostState(
      status: status ?? this.status,
      error: resetError ? null : error ?? this.error,  
      result: result ?? this.result,
      photo: resetPhoto ? null : photo ?? this.photo,
      captionSize: captionSize ?? this.captionSize,
    );
  }

  @override
  List<Object?> get props => [status, error, result, photo, captionSize];
}


