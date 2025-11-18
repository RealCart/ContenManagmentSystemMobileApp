part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class ChangeAuthStateEvent extends AuthEvent {
  const ChangeAuthStateEvent(this.state);

  final PageState state;

  @override
  List<Object> get props => [state];
}

final class SubmitFormEvent extends AuthEvent {
  const SubmitFormEvent(this.params);

  final FormParamsEntity params;

  @override
  List<Object> get props => [params];
}
