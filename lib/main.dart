import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instai/core/constants/app_colors.dart';
import 'package:instai/core/routing/app_router.dart';
import 'package:instai/core/theme/app_theme.dart';
import 'package:instai/core/utils/theme_controller.dart';
import 'package:instai/core/utils/theme_mode_utils.dart';
import 'package:instai/service_locator.dart';
import 'package:instai/features/settings/domain/usecases/get_theme_mode_usecase.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await serviceLocator();
  await getIt.allReady();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final ValueNotifier<ThemeMode> _appThemeMode = ValueNotifier<ThemeMode>(ThemeMode.system);

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    final themeMode = await getIt<GetThemeModeUsecase>().call();

    if (themeMode == null) {
      _appThemeMode.value = ThemeMode.system;
    } else if (themeMode) {
      _appThemeMode.value = ThemeMode.dark;
    } else {
      _appThemeMode.value = ThemeMode.light;
    }
  }

  @override
  Widget build(BuildContext context) {
    final routing = AppRouter();
    return ThemeController(
      notifier: _appThemeMode,
      child: ValueListenableBuilder(
        valueListenable: _appThemeMode,
        builder: (context, value, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'InstaAI',
            theme: AppTheme.lightTheme,
            themeMode: _appThemeMode.value,
            darkTheme: AppTheme.darkTheme,
            routerConfig: routing.config(),
            builder: (context, child) {
              return DefaultSvgTheme(
                theme: SvgTheme(
                  currentColor: ThemeModeUtils.isLightThemeMode(context)
                      ? AppColors.black
                      : AppColors.white,
                ),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
