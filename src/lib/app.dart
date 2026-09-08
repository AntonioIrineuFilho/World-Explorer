import 'package:flutter/material.dart';
import 'core/constants/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'features/explore/presentation/screens/explore_screen.dart';
import 'features/favorites/presentation/screens/favorites_screen.dart';

class WorldExplorerApp extends StatelessWidget {
  const WorldExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'World Explorer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: AppRoutes.explore,
      routes: {
        AppRoutes.explore: (context) => const ExploreScreen(),
        AppRoutes.favorites: (context) => const FavoritesScreen(),
      },
    );
  }
}
