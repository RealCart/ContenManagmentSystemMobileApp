part of 'preview_bloc.dart';

class PreviewState extends Equatable {
  const PreviewState({
    this.status = Status.initial,
    this.error,
  });

  final Status status;
  final Failure? error;

  PreviewState copyWith({
    Status? status,
    Failure? error,
    bool resetError = false,
  }) {
    return PreviewState(
      status: status ?? this.status,
      error: resetError ? null : error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, error];
}


