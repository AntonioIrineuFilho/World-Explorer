import 'package:flutter/material.dart';
import '../screens/explore_screen.dart';
import '../screens/favorites_screen.dart';
import '../theme/app_theme.dart';

enum AppTab { explore, favorites }

/// Barra de navegação inferior fixa, presente em todas as telas do app,
/// espelhando o rodapé "Explorar / Favoritos" dos protótipos.
class AppBottomNav extends StatelessWidget {
  final AppTab currentTab;

  const AppBottomNav({super.key, required this.currentTab});

  void _goTo(BuildContext context, AppTab tab) {
    if (tab == currentTab) return;
    final page = tab == AppTab.explore
        ? const ExploreScreen()
        : const FavoritesScreen();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.cardWhite,
        border: Border(top: BorderSide(color: AppColors.divider, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 66,
          child: Row(
            children: [
              _NavItem(
                icon: Icons.home_outlined,
                label: 'Explorar',
                selected: currentTab == AppTab.explore,
                onTap: () => _goTo(context, AppTab.explore),
              ),
              _NavItem(
                icon: Icons.star_border_rounded,
                label: 'Favoritos',
                selected: currentTab == AppTab.favorites,
                onTap: () => _goTo(context, AppTab.favorites),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppColors.primaryBlue;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 26),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
