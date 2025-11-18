part of 'home_bloc.dart';

@immutable
class HomeState extends Equatable {
  const HomeState({
    this.userInfoError,
    this.postListError,
    this.postsList = const [],
    this.userInfo,
    this.userInfoStatus = Status.initial,
    this.postListStatus = Status.initial,
  });

  final UserEnttiy? userInfo;
  final List<PostEntity> postsList;
  final Status userInfoStatus;
  final Status postListStatus;
  final Failure? userInfoError;
  final Failure? postListError;

  bool get userInfoShimmerFlag => userInfo == null;
  bool get postListShimmerFlag => postListStatus == Status.loading;

  HomeState copyWith({
    UserEnttiy? userInfo,
    List<PostEntity>? postsList,
    Status? userInfoStatus,
    Status? postListStatus,
    Failure? userInfoError,
    Failure? postListError,
    bool resetUserInfoError = false,
    bool resetPostListError = false,
  }) {
    return HomeState(
      userInfo: userInfo ?? this.userInfo,
      postsList: postsList ?? this.postsList,
      userInfoStatus: userInfoStatus ?? this.userInfoStatus,
      postListStatus: postListStatus ?? this.postListStatus,
      postListError: resetPostListError
          ? null
          : postListError ?? this.postListError,
      userInfoError: resetUserInfoError
          ? null
          : userInfoError ?? this.userInfoError,
    );
  }

  @override
  List<Object?> get props => [
    userInfo,
    postsList,
    userInfoStatus,
    postListStatus,
    userInfoError,
    postListError,
  ];
}
