import 'package:flutter/material.dart';
import '../../features/country_details/presentation/screens/details_screen.dart';
import '../../features/navigation/presentation/screens/app_shell.dart';
import '../../features/navigation/presentation/screens/settings_screen.dart';
import '../../shared/models/country.dart';
import '../constants/app_routes.dart';

class AppRouteBuilder {
  AppRouteBuilder._();

  static Route<dynamic>? build(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const AppShell(),
        );
      case AppRoutes.explore:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const AppShell(),
        );
      case AppRoutes.favorites:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const AppShell(initialIndex: 1),
        );
      case AppRoutes.settings:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SettingsScreen(),
        );
      case AppRoutes.details:
        final country = settings.arguments as Country;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => DetailsScreen(country: country),
        );
      default:
        return null;
    }
  }
}
