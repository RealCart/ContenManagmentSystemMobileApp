import 'package:auto_route/auto_route.dart';
import 'package:instai/core/data/sources/locale/token_storage.dart';
import 'package:instai/core/routing/app_router.gr.dart';
import 'package:instai/core/routing/guards/auth_guard.dart';
import 'package:instai/service_locator.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: AuthRoute.page,
      initial: true,
      guards: [AuthGuard(getIt<TokenStorage>())],
    ),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: SettingsRoute.page),
    AutoRoute(page: PostRoute.page),
    AutoRoute(page: PreviewRoute.page),
    AutoRoute(page: PhotoViewRoute.page),
  ];
}
