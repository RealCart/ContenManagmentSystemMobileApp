import 'package:get_it/get_it.dart';
import 'package:instai/core/constants/app_constants.dart';
import 'package:instai/core/data/sources/locale/secure_storage.dart';
import 'package:instai/core/data/sources/remote/http_client.dart';
import 'package:instai/features/authorization/data/repositories/auth_repository_impl.dart';
import 'package:instai/core/data/sources/locale/token_storage.dart';
import 'package:instai/features/authorization/data/sources/remote/auth_remote.dart';
import 'package:instai/features/authorization/domain/repositories/auth_repository.dart';
import 'package:instai/features/authorization/domain/usecases/sign_in_usecase.dart';
import 'package:instai/features/authorization/domain/usecases/sign_up_usecase.dart';
import 'package:instai/features/authorization/presentation/bloc/auth_bloc.dart';
import 'package:instai/features/home/data/repositories/home_repository_impl.dart';
import 'package:instai/features/home/data/sources/remote/home_remote.dart';
import 'package:instai/features/home/domain/repositories/home_repositories.dart';
import 'package:instai/features/home/domain/usecase/get_posts_usecase.dart';
import 'package:instai/features/home/domain/usecase/get_user_info_usecase.dart';
import 'package:instai/features/home/domain/usecase/delete_post_usecase.dart';
import 'package:instai/features/home/presentation/bloc/home_bloc.dart';
import 'package:instai/features/post/data/repositories/post_repository_impl.dart';
import 'package:instai/features/post/data/sources/remote/post_remote.dart';
import 'package:instai/features/post/domain/repositories/post_repository.dart';
import 'package:instai/features/post/domain/usecases/generate_post_usecase.dart';
import 'package:instai/features/post/domain/usecases/save_post_usecase.dart';
import 'package:instai/features/post/presentation/bloc/post_bloc/post_bloc.dart';
import 'package:instai/features/post/presentation/bloc/preview_bloc/preview_bloc.dart';
import 'package:instai/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:instai/features/settings/data/sources/locale/settings_locale.dart';
import 'package:instai/features/settings/domain/repositories/settings_repository.dart';
import 'package:instai/features/settings/domain/usecases/clear_cache_usecase.dart';
import 'package:instai/features/settings/domain/usecases/get_theme_mode_usecase.dart';
import 'package:instai/features/settings/domain/usecases/save_theme_mode_usecase.dart';
import 'package:instai/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:instai/core/domain/usecases/posts_refresh_usecase.dart';

final getIt = GetIt.I;

Future<void> serviceLocator() async {
  //Core locale
  getIt.registerLazySingleton<SecureStorage>(() => SecureStorage());
  getIt.registerLazySingleton<TokenStorage>(
    () => TokenStorageImpl(getIt<SecureStorage>()),
  );
  getIt.registerSingletonAsync<SharedPreferencesWithCache>(
    () => SharedPreferencesWithCache.create(cacheOptions: const SharedPreferencesWithCacheOptions(allowList: {AppConstants.themeIsDarkKey})),
  );

  // Core remote
  getIt.registerLazySingleton<HttpClient>(
    () => HttpClient(tokentStorage: getIt<TokenStorage>()),
  );
  // Core usecases
  getIt.registerLazySingleton<PostsRefreshUsecase>(() => PostsRefreshUsecase());

  // Feature remote
  getIt.registerLazySingleton<AuthRemote>(
    () => AuthRemoteImpl(getIt<HttpClient>()),
  );
  getIt.registerLazySingleton<HomeRemote>(
    () => HomeRemoteImpl(getIt<HttpClient>()),
  );
  getIt.registerLazySingleton<PostRemote>(
    () => PostRemoteImpl(getIt<HttpClient>()),
  );

  //Feature locale
  getIt.registerLazySingleton<SettingsLocale>(
    () => SettingsLocaleImpl(
      getIt<SharedPreferencesWithCache>(),
      getIt<TokenStorage>(),
    ),
  );

  // Feature repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remote: getIt<AuthRemote>(),
      token: getIt<TokenStorage>(),
    ),
  );
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remote: getIt<HomeRemote>()),
  );
  getIt.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(remote: getIt<PostRemote>()),
  );
  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(getIt<SettingsLocale>()),
  );

  // Feature usecase's
  getIt.registerFactory<SignInUsecase>(
    () => SignInUsecase(getIt<AuthRepository>()),
  );
  getIt.registerFactory<SignUpUsecase>(
    () => SignUpUsecase(getIt<AuthRepository>()),
  );
  getIt.registerFactory<GetUserInfoUsecase>(
    () => GetUserInfoUsecase(getIt<HomeRepository>()),
  );
  getIt.registerFactory<GetPostsUsecase>(
    () => GetPostsUsecase(getIt<HomeRepository>()),
  );
  getIt.registerFactory<DeletePostUsecase>(
    () => DeletePostUsecase(getIt<HomeRepository>()),
  );
  getIt.registerFactory<GeneratePostUsecase>(
    () => GeneratePostUsecase(getIt<PostRepository>()),
  );
  getIt.registerFactory<SavePostUsecase>(
    () => SavePostUsecase(getIt<PostRepository>()),
  );
  getIt.registerFactory<ClearCacheUsecase>(
    () => ClearCacheUsecase(getIt<SettingsRepository>()),
  );
  getIt.registerFactory<GetThemeModeUsecase>(
    () => GetThemeModeUsecase(getIt<SettingsRepository>()),
  );
  getIt.registerFactory<SaveThemeModeUsecase>(
    () => SaveThemeModeUsecase(getIt<SettingsRepository>()),
  );

  // BLoC's
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      signInUsecase: getIt<SignInUsecase>(),
      signUpUsecase: getIt<SignUpUsecase>(),
    ),
  );
  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(
      getUserInfoUsecase: getIt<GetUserInfoUsecase>(),
      getPostsUsecase: getIt<GetPostsUsecase>(),
      deletePostUsecase: getIt<DeletePostUsecase>(),
      refreshUsecase: getIt<PostsRefreshUsecase>(),
    ),
  );
  getIt.registerFactory<PostBloc>(
    () => PostBloc(generatePostUsecase: getIt<GeneratePostUsecase>()),
  );
  getIt.registerFactory<PreviewBloc>(
    () => PreviewBloc(
      savePostUsecase: getIt<SavePostUsecase>(),
      refreshUsecase: getIt<PostsRefreshUsecase>(),
    ),
  );
  getIt.registerFactory<SettingsBloc>(
    () => SettingsBloc(
      clearCacheUsecase: getIt<ClearCacheUsecase>(),
      saveThemeModeUsecase: getIt<SaveThemeModeUsecase>(),
    ),
  );
}
