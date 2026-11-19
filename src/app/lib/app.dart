import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/favorites/data/favorites_controller.dart';
import 'features/auth/data/auth_controller.dart';
import 'core/constants/app_routes.dart';
import 'core/navigation/app_route_builder.dart';
import 'core/theme/app_theme.dart';
import 'features/navigation/presentation/screens/app_shell.dart';
import 'features/navigation/presentation/screens/settings_screen.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/presentation/screens/register_screen.dart';
import 'features/auth/presentation/screens/consultation_screen.dart';

class WorldExplorerApp extends StatelessWidget {
  const WorldExplorerApp({super.key});
  @override Widget build(BuildContext context) => MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => FavoritesStore()), ChangeNotifierProvider(create: (_) => AuthController())],
    child: MaterialApp(title: 'World Explorer', debugShowCheckedModeBanner: false, theme: AppTheme.theme,
      initialRoute: AppRoutes.home,
      routes: {AppRoutes.home: (_) => const AppShell(), AppRoutes.settings: (_) => const SettingsScreen(), AppRoutes.login: (_) => const LoginScreen(), AppRoutes.register: (_) => const RegisterScreen(), AppRoutes.consultation: (_) => const ConsultationScreen()},
      onGenerateRoute: AppRouteBuilder.build,
    ),
  );
}
