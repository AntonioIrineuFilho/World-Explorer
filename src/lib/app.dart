import 'package:flutter/material.dart';
import 'core/constants/app_routes.dart';
import 'core/navigation/app_route_builder.dart';
import 'core/theme/app_theme.dart';
import 'features/navigation/presentation/screens/app_shell.dart';
import 'features/navigation/presentation/screens/settings_screen.dart';

class WorldExplorerApp extends StatelessWidget {
  const WorldExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'World Explorer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (context) => const AppShell(),
        AppRoutes.settings: (context) => const SettingsScreen(),
      },
      onGenerateRoute: AppRouteBuilder.build,
    );
  }
}
