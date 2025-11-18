// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:instai/features/authorization/presentation/screen/auth_screen.dart'
    as _i1;
import 'package:instai/features/home/presentation/screen/home_screen.dart'
    as _i2;
import 'package:instai/features/home/presentation/screen/photo_view_screen.dart'
    as _i3;
import 'package:instai/features/post/domain/entities/generated_post_entity.dart'
    as _i9;
import 'package:instai/features/post/presentation/screen/post_screen.dart'
    as _i4;
import 'package:instai/features/post/presentation/screen/preview_screen.dart'
    as _i5;
import 'package:instai/features/settings/presentation/screen/settings_screen.dart'
    as _i6;

/// generated route for
/// [_i1.AuthScreen]
class AuthRoute extends _i7.PageRouteInfo<void> {
  const AuthRoute({List<_i7.PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return _i7.WrappedRoute(child: const _i1.AuthScreen());
    },
  );
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return _i7.WrappedRoute(child: const _i2.HomeScreen());
    },
  );
}

/// generated route for
/// [_i3.PhotoViewScreen]
class PhotoViewRoute extends _i7.PageRouteInfo<PhotoViewRouteArgs> {
  PhotoViewRoute({
    _i8.Key? key,
    required String photoPath,
    required String tag,
    List<_i7.PageRouteInfo>? children,
  }) : super(
         PhotoViewRoute.name,
         args: PhotoViewRouteArgs(key: key, photoPath: photoPath, tag: tag),
         initialChildren: children,
       );

  static const String name = 'PhotoViewRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PhotoViewRouteArgs>();
      return _i3.PhotoViewScreen(
        key: args.key,
        photoPath: args.photoPath,
        tag: args.tag,
      );
    },
  );
}

class PhotoViewRouteArgs {
  const PhotoViewRouteArgs({
    this.key,
    required this.photoPath,
    required this.tag,
  });

  final _i8.Key? key;

  final String photoPath;

  final String tag;

  @override
  String toString() {
    return 'PhotoViewRouteArgs{key: $key, photoPath: $photoPath, tag: $tag}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PhotoViewRouteArgs) return false;
    return key == other.key && photoPath == other.photoPath && tag == other.tag;
  }

  @override
  int get hashCode => key.hashCode ^ photoPath.hashCode ^ tag.hashCode;
}

/// generated route for
/// [_i4.PostScreen]
class PostRoute extends _i7.PageRouteInfo<void> {
  const PostRoute({List<_i7.PageRouteInfo>? children})
    : super(PostRoute.name, initialChildren: children);

  static const String name = 'PostRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return _i7.WrappedRoute(child: const _i4.PostScreen());
    },
  );
}

/// generated route for
/// [_i5.PreviewScreen]
class PreviewRoute extends _i7.PageRouteInfo<PreviewRouteArgs> {
  PreviewRoute({
    _i8.Key? key,
    required _i9.GeneratedPostEntity result,
    List<_i7.PageRouteInfo>? children,
  }) : super(
         PreviewRoute.name,
         args: PreviewRouteArgs(key: key, result: result),
         initialChildren: children,
       );

  static const String name = 'PreviewRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PreviewRouteArgs>();
      return _i7.WrappedRoute(
        child: _i5.PreviewScreen(key: args.key, result: args.result),
      );
    },
  );
}

class PreviewRouteArgs {
  const PreviewRouteArgs({this.key, required this.result});

  final _i8.Key? key;

  final _i9.GeneratedPostEntity result;

  @override
  String toString() {
    return 'PreviewRouteArgs{key: $key, result: $result}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PreviewRouteArgs) return false;
    return key == other.key && result == other.result;
  }

  @override
  int get hashCode => key.hashCode ^ result.hashCode;
}

/// generated route for
/// [_i6.SettingsScreen]
class SettingsRoute extends _i7.PageRouteInfo<void> {
  const SettingsRoute({List<_i7.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return _i7.WrappedRoute(child: const _i6.SettingsScreen());
    },
  );
}
