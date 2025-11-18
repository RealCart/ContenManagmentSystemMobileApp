import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instai/core/constants/app_assets.dart';
import 'package:instai/core/constants/app_colors.dart';
import 'package:instai/core/routing/app_router.gr.dart';
import 'package:instai/core/utils/bloc_ex.dart';
import 'package:instai/features/home/domain/entity/post_entity.dart';
import 'package:instai/features/home/domain/entity/user_enttiy.dart';
import 'package:instai/features/home/presentation/bloc/home_bloc.dart';
import 'package:instai/features/home/presentation/widgets/avatar_widger.dart';
import 'package:instai/features/home/presentation/widgets/post_widget.dart';
import 'package:instai/service_locator.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class HomeScreen extends StatelessWidget implements AutoRouteWrapper {
  const HomeScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<HomeBloc>()
            ..addAll([const GetUserEvent(), const GetPostsEvent()]),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: AppColors.gradientColors,
          ),
        ),
        child: FloatingActionButton(
          onPressed: () => context.router.push(const PostRoute()),
          backgroundColor: AppColors.transparent,
          child: SvgPicture.asset(
            AppAssets.icon.ai,
            fit: BoxFit.scaleDown,
            width: 30.0,
            height: 30.0,
            colorFilter: ColorFilter.mode(
              Theme.of(context).cardColor,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        toolbarHeight: kToolbarHeight + 20.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (p, c) =>
                (p.userInfo != c.userInfo) ||
                (p.userInfoStatus != c.userInfoStatus),
            builder: (context, state) {
              late final UserEnttiy userData;

              if (state.userInfoShimmerFlag) {
                userData = const UserEnttiy(
                  username: "awdcawcdawc",
                  postCount: 0,
                  avatarPath: "",
                );
              } else {
                userData = state.userInfo!;
              }

              return Skeletonizer(
                enabled: state.userInfoShimmerFlag,
                child: AvatarWidget(userInfo: userData),
              );
            },
          ),
        ),
        leadingWidth: double.infinity,
        actions: [
          IconButton(
            onPressed: () => context.router.push(const SettingsRoute()),
            icon: SvgPicture.asset(
              AppAssets.icon.settings,
              width: 25.0,
              height: 25.0,
              fit: BoxFit.scaleDown,
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: RefreshIndicator.adaptive(
          onRefresh: () async {
            final Completer completer = Completer();
            BlocProvider.of<HomeBloc>(
              context,
            ).add(GetPostsEvent(completer: completer));
            return await completer.future;
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (p, c) =>
                !listEquals(c.postsList, p.postsList) ||
                p.postListStatus != c.postListStatus,
            builder: (context, state) {
              late final List<PostEntity> list;

              if (state.postListShimmerFlag) {
                list = List.filled(
                  3,
                  PostEntity(
                    id: 0,
                    description:
                        "************************************************",
                    hashtags: "************************",
                    photosPath: [""],
                    createdAt: DateTime.now(),
                  ),
                );
              } else {
                list = state.postsList;
              }

              if (list.isEmpty) {
                return const Center(
                  child: Text(
                    "No posts!",
                    style: TextStyle(color: AppColors.white),
                  ),
                );
              }

              return Skeletonizer(
                enabled: state.postListShimmerFlag,
                child: ListView.separated(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final item = list[index];
                    return PostWidget(
                      post: item,
                      onPhotoTap: ({required photoUrl, required tag}) =>
                          context.pushRoute(
                            PhotoViewRoute(photoPath: photoUrl, tag: tag),
                          ),
                    );
                  },
                  separatorBuilder: (_, _) => const SizedBox(height: 20.0),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
