import 'package:flutter/material.dart';
import '../../core/constants/app_icons.dart';
import '../../core/constants/app_routes.dart';
import '../../core/theme/app_theme.dart';

enum AppTab { explore, favorites }

class AppBottomNav extends StatelessWidget {
  final AppTab currentTab;

  const AppBottomNav({super.key, required this.currentTab});

  void _goTo(BuildContext context, AppTab tab) {
    if (tab == currentTab) return;
    final route =
        tab == AppTab.explore ? AppRoutes.explore : AppRoutes.favorites;
    Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.cardWhite,
        border: Border(top: BorderSide(color: AppColors.textGray, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 66,
          child: Row(
            children: [
              _NavItem(
                iconAsset: AppIcons.home,
                label: 'Explorar',
                selected: currentTab == AppTab.explore,
                onTap: () => _goTo(context, AppTab.explore),
              ),
              _NavItem(
                iconAsset: AppIcons.star,
                tintColor: AppColors.buttonBlue,
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
  final String iconAsset;
  final Color? tintColor;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.iconAsset,
    this.tintColor,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const color = AppColors.buttonBlue;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconAsset,
              width: 26,
              height: 26,
              color: tintColor,
              colorBlendMode: tintColor != null ? BlendMode.srcIn : null,
            ),
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
