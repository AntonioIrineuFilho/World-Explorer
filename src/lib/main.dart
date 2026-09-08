import 'package:flutter/material.dart';
import 'screens/explore_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const WorldExplorerApp());
}

class WorldExplorerApp extends StatelessWidget {
  const WorldExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'World Explorer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const ExploreScreen(),
    );
  }
}
