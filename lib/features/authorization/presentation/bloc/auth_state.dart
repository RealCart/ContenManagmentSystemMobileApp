part of 'auth_bloc.dart';

enum PageState { signIn, signUp }

@immutable
class AuthState extends Equatable {
  const AuthState({
    this.status = Status.initial,
    this.pageState = PageState.signIn,
    this.error,
  });

  final Status status;
  final Failure? error;
  final PageState pageState;

  AuthState copyWith({
    Status? status,
    Failure? error,
    PageState? pageState,
    bool resetError = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      error: resetError ? null : error ?? this.error,
      pageState: pageState ?? this.pageState,
    );
  }

  @override
  List<Object?> get props => [pageState, status, error];
}
