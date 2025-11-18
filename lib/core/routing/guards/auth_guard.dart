import 'package:auto_route/auto_route.dart';
import 'package:instai/core/data/sources/locale/token_storage.dart';
import 'package:instai/core/routing/app_router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  const AuthGuard(TokenStorage storage) : _storage = storage;

  final TokenStorage _storage;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    if (await _storage.containsToken()) {
      router.replace(const HomeRoute());
    } else {
      resolver.next(true);
    }
  }
}
