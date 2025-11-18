import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instai/core/constants/app_colors.dart';
import 'package:instai/core/routing/app_router.gr.dart';
import 'package:instai/core/utils/theme_controller.dart';
import 'package:instai/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:instai/service_locator.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget implements AutoRouteWrapper {
  const SettingsScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (_) => getIt<SettingsBloc>(), child: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Dark theme", style: TextTheme.of(context).bodyMedium),
                  Builder(
                    builder: (context) {
                      final controller = ThemeController.of(context);

                      return Switch.adaptive(
                        value: controller.isDarkMode,
                        onChanged: (value) {
                          late final ThemeMode mode;

                          if (value) {
                            mode = ThemeMode.dark;
                          } else {
                            mode = ThemeMode.light;
                          }

                          controller.toggleMode(mode);
                          BlocProvider.of<SettingsBloc>(context).add(ToggleModeEvent(mode));
                        },
                      );
                    },
                  ),
                ],
              ),
              const Spacer(),
              const Divider(),
              GestureDetector(
                onTap: () async {
                  final Completer completer = Completer();

                  BlocProvider.of<SettingsBloc>(
                    context,
                  ).add(ExitAppEvent(completer: completer));
                  await completer.future;
                  if (context.mounted) {
                    context.router.replace(const AuthRoute());
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10.0,
                    children: [
                      Icon(Icons.exit_to_app, color: AppColors.red),
                      Text(
                        "Log out",
                        style: TextStyle(color: AppColors.red),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
