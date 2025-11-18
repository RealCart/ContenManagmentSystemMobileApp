import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:instai/core/utils/either.dart';
import 'package:instai/core/utils/failure.dart';
import 'package:instai/core/utils/status.dart';
import 'package:instai/features/authorization/domain/entities/form_params_entity.dart';
import 'package:instai/features/authorization/domain/usecases/sign_in_usecase.dart';
import 'package:instai/features/authorization/domain/usecases/sign_up_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUsecase _signInUsecase;
  final SignUpUsecase _signUpUsecase;

  AuthBloc({
    required SignInUsecase signInUsecase,
    required SignUpUsecase signUpUsecase,
  }) : _signInUsecase = signInUsecase,
       _signUpUsecase = signUpUsecase,
       super(const AuthState()) {
    on<ChangeAuthStateEvent>(_changeAuthState);
    on<SubmitFormEvent>(_onSubmitForm);
  }

  void _changeAuthState(ChangeAuthStateEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(pageState: event.state));
  }

  void _onSubmitForm(SubmitFormEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: Status.loading));
    late final Either<Failure, bool> response;

    if (state.pageState == PageState.signIn) {
      response = await _signInUsecase.call(event.params);
    } else {
      response = await _signUpUsecase.call(event.params);
    }

    response.fold(
      (l) {
        emit(state.copyWith(status: Status.error, error: l));
      },
      (r) {
        emit(state.copyWith(status: Status.successfully));
      },
    );

    emit(state.copyWith(resetError: true, status: Status.initial));
  }
}
