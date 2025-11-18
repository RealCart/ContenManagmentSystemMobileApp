import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:instai/core/utils/failure.dart';
import 'package:instai/core/utils/status.dart';
import 'package:instai/features/home/domain/entity/post_entity.dart';
import 'package:instai/features/home/domain/entity/user_enttiy.dart';
import 'package:instai/features/home/domain/usecase/get_posts_usecase.dart';
import 'package:instai/features/home/domain/usecase/get_user_info_usecase.dart';
import 'package:instai/features/home/domain/usecase/delete_post_usecase.dart';
import 'package:instai/core/domain/usecases/posts_refresh_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUserInfoUsecase _getUserInfoUsecase;
  final GetPostsUsecase _getPostsUsecase;
  final DeletePostUsecase _deletePostUsecase;
  final PostsRefreshUsecase _refreshUsecase;
  StreamSubscription<RefreshCommand>? _refreshSubscription;

  HomeBloc({
    required GetUserInfoUsecase getUserInfoUsecase,
    required GetPostsUsecase getPostsUsecase,
    required DeletePostUsecase deletePostUsecase,
    required PostsRefreshUsecase refreshUsecase,
  }) : _getUserInfoUsecase = getUserInfoUsecase,
       _getPostsUsecase = getPostsUsecase,
       _deletePostUsecase = deletePostUsecase,
       _refreshUsecase = refreshUsecase,
       super(const HomeState()) {
    on<GetUserEvent>(_onGetUser);
    on<GetPostsEvent>(_onGetPost);
    on<DeletePostEvent>(_onDeletePost);

    _refreshSubscription = _refreshUsecase.stream.listen((cmd) {
      if (cmd == RefreshCommand.fetch) {
        add(const GetPostsEvent());
      }
    });
  }

  void _onGetUser(GetUserEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(userInfoStatus: Status.loading));
    final response = await _getUserInfoUsecase.call();

    response.fold(
      (l) {
        emit(state.copyWith(userInfoError: l, userInfoStatus: Status.error));
      },
      (r) {
        emit(state.copyWith(userInfo: r, userInfoStatus: Status.successfully));
      },
    );

    emit(
      state.copyWith(userInfoStatus: Status.initial, resetUserInfoError: true),
    );
  }

  void _onGetPost(GetPostsEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(postListStatus: Status.loading));
    final response = await _getPostsUsecase.call();

    response.fold(
      (l) {
        emit(state.copyWith(postListError: l, postListStatus: Status.error));
      },
      (r) {
        emit(state.copyWith(postsList: r, postListStatus: Status.successfully));
      },
    );

    event.completer?.complete();
    emit(
      state.copyWith(resetPostListError: true, postListStatus: Status.initial),
    );
  }

  void _onDeletePost(DeletePostEvent event, Emitter<HomeState> emit) async {
    final response = await _deletePostUsecase.call(event.id);

    response.fold(
      (l) {
        emit(state.copyWith(postListError: l));
      },
      (r) {
        final updated = state.postsList.where((e) => e.id != event.id).toList();
        emit(state.copyWith(postsList: updated));
      },
    );
  }

  @override
  Future<void> close() {
    _refreshSubscription?.cancel();
    return super.close();
  }
}
