import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:instai/core/utils/failure.dart';
import 'package:instai/core/utils/status.dart';
import 'package:instai/features/post/domain/entities/generate_post_params_entity.dart';
import 'package:instai/features/post/domain/entities/generated_post_entity.dart';
import 'package:instai/features/post/domain/usecases/generate_post_usecase.dart';
import 'package:image_picker/image_picker.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GeneratePostUsecase _generatePostUsecase;

  PostBloc({required GeneratePostUsecase generatePostUsecase})
    : _generatePostUsecase = generatePostUsecase,
      super(const PostState()) {
    on<SubmitGenerateEvent>(_onGenerate);
    on<ResetPostEvent>(_onReset);
    on<PickImageEvent>(_onPickImage);
    on<RemoveImageEvent>(_onRemoveImage);
    on<ChangeCaptionSizeEvent>(_onChangeSize);
  }

  String _mapSizeToApi(CaptionSize s) {
    switch (s) {
      case CaptionSize.short:
        return "SHORT";
      case CaptionSize.medium:
        return "MEDIUM";
      case CaptionSize.long:
        return "LONG";
    }
  }

  void _onGenerate(SubmitGenerateEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: Status.loading));

    final response = await _generatePostUsecase.call(
      GeneratePostParamsEntity(
        photoFile: state.photo,
        description: event.description,
        hashtags: event.hashtags,
        size: _mapSizeToApi(state.captionSize),
      ),
    );

    response.fold(
      (l) => emit(state.copyWith(status: Status.error, error: l)),
      (r) => emit(state.copyWith(status: Status.successfully, result: r)),
    );

    emit(state.copyWith(status: Status.initial, resetError: true));
  }

  void _onReset(ResetPostEvent event, Emitter<PostState> emit) {
    emit(const PostState());
  }

  void _onPickImage(PickImageEvent event, Emitter<PostState> emit) async {
    final XFile? picked = await ImagePicker().pickImage(
      source: event.source,
      imageQuality: 100,
    );
    if (picked != null) {
      emit(state.copyWith(photo: File(picked.path)));
    }
  }

  void _onRemoveImage(RemoveImageEvent event, Emitter<PostState> emit) {
    emit(state.copyWith(resetPhoto: true));
  }

  void _onChangeSize(ChangeCaptionSizeEvent event, Emitter<PostState> emit) {
    emit(state.copyWith(captionSize: event.size));
  }
}


