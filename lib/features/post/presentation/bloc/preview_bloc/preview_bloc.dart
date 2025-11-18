import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instai/core/domain/usecases/posts_refresh_usecase.dart';
import 'package:instai/core/utils/failure.dart';
import 'package:instai/core/utils/status.dart';
import 'package:instai/features/post/domain/entities/generated_post_entity.dart';
import 'package:instai/features/post/domain/usecases/save_post_usecase.dart';

part 'preview_event.dart';
part 'preview_state.dart';

class PreviewBloc extends Bloc<PreviewEvent, PreviewState> {
  final SavePostUsecase _savePostUsecase;
  final PostsRefreshUsecase _refreshUsecase;

  PreviewBloc({required SavePostUsecase savePostUsecase, required PostsRefreshUsecase refreshUsecase})
    : _savePostUsecase = savePostUsecase,
      _refreshUsecase = refreshUsecase,
      super(const PreviewState()) {
    on<SavePostEvent>(_onSave);
  }

  void _onSave(SavePostEvent event, Emitter<PreviewState> emit) async {
    emit(state.copyWith(status: Status.loading));
    final response = await _savePostUsecase.call(event.entity);

    response.fold(
      (l) => emit(state.copyWith(status: Status.error, error: l)),
      (r) {
        emit(state.copyWith(status: Status.successfully));
        _refreshUsecase.fetch();
      },
    );

    emit(state.copyWith(status: Status.initial, resetError: true));
  }
}


